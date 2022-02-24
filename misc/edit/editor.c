#include "editor.h"
#include "terminal.h"
#include "vt100.h"
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>

#include <stdio.h>

struct editor_line {
	int rlen;
	char *raw_buffer;
};

void editor_init (struct editor *ed, const char *filename) {
	ed->cursor_x = 0;
	ed->cursor_y = 0;
	ed->offset_y = 0;
	ed->line_count = 0;
	ed->tabsize = 8;
	ed->lines = NULL;
	term_getdimensions(&ed->screen_w, &ed->screen_h);

	if (filename != NULL) {
		const int len = strlen(filename);
		ed->filename = malloc(sizeof(char) * len);
		strncpy(ed->filename, filename, len);
	}
	else ed->filename = NULL;

	if (filename != NULL && access(filename, R_OK | W_OK) != -1) {
		editor_load(ed, ed->filename);
	}
}

struct editor_line *editor_getscreenline (struct editor *ed, int pos) {
	int i = ed->offset_y + pos;
	if (ed->line_count > i) {
		return ed->lines + i;
	}
	else {
		return NULL;
	}
}

struct editor_line *editor_getline (struct editor *ed) {
	int i = ed->cursor_y + ed->offset_y;
	if (ed->line_count > i) {
		return ed->lines + i;
	}
	else {
		return NULL;
	}
}

struct editor_line *editor_getlinerealtive (struct editor *ed, int off) {
	int i = ed->cursor_y + ed->offset_y + off;
	if (ed->line_count > i) {
		return ed->lines + i;
	}
	else {
		return NULL;
	}
}

void editor_movecursor (struct editor *ed, char c) {
	if (c == 'A') {
		// ^
		if (ed->cursor_y > 0) {
			ed->cursor_y--;

			int overflow = ed->cursor_x - editor_getline(ed)->rlen;
			if (overflow > 0) {
				ed->cursor_x -= overflow;
			}
		}
		if (ed->cursor_y == 0 && ed->offset_y > 0) {
			ed->offset_y--;
		}
	}
	else if (c == 'B') {
		// V
		if (ed->lines != NULL && ed->cursor_y + ed->offset_y < ed->line_count - 1) {
			ed->cursor_y++;

			int overflow = ed->cursor_x - editor_getline(ed)->rlen;
			if (overflow > 0) {
				ed->cursor_x -= overflow;
			}
		}
		if (ed->cursor_y >= ed->screen_h) {
			ed->offset_y++;
			ed->cursor_y--;
		}
	}
	else if (c == 'C') {
		// ->
		if (ed->lines != NULL && ed->cursor_x < editor_getline(ed)->rlen) {
			ed->cursor_x++;
		}
	}
	else if (c == 'D') {
		// <-
		if (ed->cursor_x > 0) {
			ed->cursor_x--;
		}
	}

}

void editor_draw (struct editor *ed) {
	vt_clear();
	vt_goto(0, 0);

	int i = 0;

	while (i < ed->screen_h && i + ed->offset_y < ed->line_count) {
		struct editor_line *l = editor_getscreenline(ed, i);
		write(STDOUT_FILENO, l->raw_buffer, l->rlen);
		i++;

		char buf[] = "\r\n";
		write(STDOUT_FILENO, buf, sizeof(buf) / sizeof(char));
	}

	while (i < ed->screen_h) {
		if (ed->line_count == 0 && i == ed->screen_h / 2) {
			char text[] = "EDITOR de TEXTO\r\n";
			char *buf = malloc(ed->screen_w);
			int j;
			buf[0] = '~';
			for (j = 1; j < ed->screen_w / 2 - sizeof(text) / 2 + 1; j++) {
				buf[j] = ' ';
			}
			strcpy(buf + j, text);
			j += sizeof(text);

			write(STDOUT_FILENO, buf, j);
			free(buf);
		}
		else {
			char buf[] = "~\r\n";
			write(STDOUT_FILENO, buf, sizeof(buf) / sizeof(char));
		}
		i++;
	}

	int visual_x = ed->cursor_x;

	if (ed->lines != NULL) {
		struct editor_line *l = editor_getline(ed);
		for (int i = 0; i < l->rlen - 1; i++) {
			if (l->raw_buffer[i] == '\t') {
				visual_x += ed->tabsize - 1;
			}
		}
	}

	vt_goto(visual_x, ed->cursor_y);
}

void editor_processcontrol (struct editor *ed, char c) {
	if (c == '\b' && ed->lines != NULL) {
		// DEL
		if (ed->cursor_x > 0) {
			struct editor_line *l = editor_getline(ed);
			l->rlen--;
			int i;
			for (i = ed->cursor_x - 1; i < l->rlen; i++) {
				l->raw_buffer[i] = l->raw_buffer[i + 1];
			}
			l->raw_buffer[i] = '\0';
			ed->cursor_x--;
		}
		else if (ed->cursor_y > 0 && ed->cursor_x == 0) {
			struct editor_line *last_l = editor_getlinerealtive(ed, -1);
			struct editor_line *l = editor_getline(ed);
			ed->cursor_x = last_l->rlen;

			if (l->rlen > 0) {
				int size = l->rlen + last_l->rlen;
				last_l->raw_buffer = realloc(last_l->raw_buffer, size);

				for (int i = last_l->rlen, j = 0; i < size;
					 i++, j++) {
					last_l->raw_buffer[i] = l->raw_buffer[j];
				}

				last_l->rlen = size;
			}

			for (int i = ed->cursor_y + ed->offset_y; i < ed->line_count; i++) {
				ed->lines[i].rlen = ed->lines[i+1].rlen;
				ed->lines[i].raw_buffer = ed->lines[i+1].raw_buffer;
			}

			ed->cursor_y--;
			ed->line_count--;
			ed->lines = realloc(ed->lines, sizeof(struct editor_line) * ed->line_count);

			if (ed->cursor_y == 0 && ed->offset_y > 0) {
				ed->offset_y--;
				ed->cursor_y++;
			}
		}
	}
	else if (c == '\r') {
		ed->line_count++;

		int size = sizeof(struct editor_line) * ed->line_count;
		ed->lines = realloc(ed->lines, size);
		ed->lines[ed->line_count - 1].raw_buffer = NULL;

		for (int i = ed->line_count - 1; i > ed->cursor_y + ed->offset_y + 1; i--) {
			ed->lines[i].rlen = ed->lines[i - 1].rlen;
			ed->lines[i].raw_buffer = ed->lines[i - 1].raw_buffer;
		}

		struct editor_line *old_line = editor_getline(ed);
		struct editor_line *new_line = editor_getlinerealtive(ed, 1);

		int overflow = old_line->rlen - ed->cursor_x;
		if (overflow > 0) {
			new_line->raw_buffer = malloc(sizeof(char) * overflow);

			for (int i = ed->cursor_x, j = 0; i < old_line->rlen; i++, j++) {
				new_line->raw_buffer[j] = old_line->raw_buffer[i];
			}

			new_line->rlen = overflow;
			old_line->rlen = ed->cursor_x;
		}
		else {
			new_line->rlen = 0;
		}

		editor_movecursor(ed, 'B');
		ed->cursor_x = 0;
	}
	else if (c == '\t') {
		for (int i = 0; i < ed->tabsize; i++) {
			editor_insertchar(ed, ' ');
		}
	}
	else if (c == VT_CTRL('S') && ed->filename != NULL) {
		if (ed->filename != NULL &&
			(access(ed->filename, W_OK) != -1 || access(ed->filename, F_OK) == -1)) {
			editor_save(ed, ed->filename);
		}
	}
	else if (c == VT_CTRL('N')) editor_movecursor(ed, 'B');
	else if (c == VT_CTRL('P')) editor_movecursor(ed, 'A');
	else if (c == VT_CTRL('F')) editor_movecursor(ed, 'C');
	else if (c == VT_CTRL('B')) editor_movecursor(ed, 'D');
}

void editor_processescape (struct editor *ed, char c) {
	if (c == 'A' || c == 'B' || c == 'C' || c == 'D') {
		editor_movecursor(ed, c);
	}
}

void editor_insertchar (struct editor *ed, char c) {
	if (ed->line_count <= ed->cursor_y) {
		int size = sizeof(struct editor_line) * (ed->cursor_y + 1);
		ed->lines = realloc(ed->lines, size);
		ed->line_count++;
		ed->lines[ed->line_count - 1].raw_buffer = NULL;
	}

	struct editor_line *l = editor_getline(ed);

	l->rlen++;
	l->raw_buffer = realloc(l->raw_buffer, l->rlen);

	for (int i = l->rlen - 2; i >= ed->cursor_x; i--) {
		l->raw_buffer[i + 1] = l->raw_buffer[i];
	}
	l->raw_buffer[ed->cursor_x] = c;
	ed->cursor_x++;
}

int editor_process (struct editor *ed) {
	int c = getchar();

	if (isprint(c)) {
		editor_insertchar(ed, c);
	}
	else if (iscntrl(c) && c != '\x1b') {
		editor_processcontrol(ed, c);
	}
	else if (c == '\x1b'){
		int c = getchar();
		if (c  == '[') {
			c = getchar();
			editor_processescape(ed, c);
		}
	}

	return c;
}

void editor_load (struct editor *ed, char *file) {
	FILE *f = fopen(file, "r");

	for (int i = 0; i < ed->line_count; i++) {
		if (ed->lines[i].raw_buffer != NULL) {
			free(ed->lines[i].raw_buffer);
		}
	}

	ed->line_count = 0;
	if (ed->lines != NULL) {
		free(ed->lines);
		ed->lines = NULL;
	}

	struct editor_line newline = { .rlen = 256, };
	newline.raw_buffer = malloc(sizeof(char) * newline.rlen);
	int c;
	int i = 0;
	do {
		c = fgetc(f);

		if (c == '\n' || c == EOF) {
			ed->line_count++;
			ed->lines = realloc(ed->lines, sizeof(struct editor_line) * ed->line_count);
			ed->lines[ed->line_count - 1].raw_buffer = newline.raw_buffer;
			ed->lines[ed->line_count - 1].rlen = i;

			i = 0;
			newline.rlen = 256;
			newline.raw_buffer = malloc(sizeof(char) * newline.rlen);
		}
		else {
			if (i >= newline.rlen) {
				newline.rlen += 256;
				newline.raw_buffer = realloc(newline.raw_buffer, newline.rlen);
			}
			newline.raw_buffer[i++] = c;
		}
	} while (c != EOF);

	fclose(f);
}

void editor_save (struct editor *ed, char *file) {
	FILE *f = fopen(file, "w");

	for (int i = 0; i < ed->line_count; i++) {
		fwrite(ed->lines[i].raw_buffer, sizeof(char), ed->lines[i].rlen, f);
		fputc('\n', f);
	}

	fclose(f);
}
