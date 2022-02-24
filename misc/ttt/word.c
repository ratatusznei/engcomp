#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "terminal.h"
#include "word.h"
#include "words.h"

void word_clear (struct word w) {
	term_goto(w.x, w.y);
	char buf[512] = "";
	for (int i = 0; i < w.len; i++) {
		buf[i] = ' ';
	}
	write(STDOUT_FILENO, buf, w.len);
}

void word_print (struct word w) {
	char buf[512] = "\x1b[7m";
	memcpy(buf + 4, w.letters, w.i);
	memcpy(buf + 4 + w.i, "\x1b[m", 3);
	memcpy(buf + 4 + w.i + 3, w.letters + w.i, w.len - w.i);

	term_goto(w.x, w.y);
	write(STDOUT_FILENO, buf, 4 + w.len + 3);
}

void word_create (struct word *pw, int width) {
	strcpy(pw->letters, WORDS[rand() % (sizeof(WORDS) / sizeof(WORDS[0]))]);
	pw->len = strlen(pw->letters);
	pw->i = 0;
	pw->y = 0;
	pw->x = rand() % (width - pw->len - 1) + 1;
}
