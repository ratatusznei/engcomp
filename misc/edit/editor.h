#ifndef EDITOR_H
#define EDITOR_H

struct editor_line;

struct editor {
	int cursor_x;
	int cursor_y;
	int offset_y;
	int screen_h;
	int screen_w;
	int line_count;
	int tabsize;
	struct editor_line *lines;
	char *filename;
};

void editor_init (struct editor *, const char *);
void editor_draw (struct editor *);

void editor_processcontrol (struct editor *, char);
void editor_insertchar (struct editor *, char);
void editor_processescape (struct editor *, char);
int editor_process (struct editor *);
void editor_load (struct editor *, char *);
void editor_save (struct editor *, char *);

#endif /* EDITOR_H */
