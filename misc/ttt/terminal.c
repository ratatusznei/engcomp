#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <signal.h>

#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>

#include "terminal.h"

#define DIEIF(X) do { if (X) { fprintf(stderr, "%s, %d: %s\n", __FILE__, __LINE__, strerror(errno)); raise(SIGINT); } } while(0)

static struct termios t0;

void term_set () {
	DIEIF(-1 == tcgetattr(STDOUT_FILENO, &t0));
	struct termios new_term = t0;
	new_term.c_lflag &= ~(ECHO | ICANON);
	new_term.c_cc[VTIME] = 5;
	new_term.c_cc[VMIN] = 0;
	DIEIF(-1 == tcsetattr(STDOUT_FILENO, TCSAFLUSH, &new_term));

	atexit(term_reset);
	signal(SIGINT, term_reset);
}

void term_reset () {
	char buf[] = "\x1b[?25h";
	write(STDOUT_FILENO, buf, sizeof(buf));
	DIEIF(-1 == tcsetattr(STDOUT_FILENO, TCSAFLUSH, &t0));
}


void term_getsize (int *width, int *height) {
	struct winsize winsize;
	ioctl(STDOUT_FILENO, TIOCGWINSZ, &winsize);
	*height = winsize.ws_row;
	*width = winsize.ws_col;
}

void term_clear () {
	char buf[] = "\x1b[2J\x1b[H";
	write(STDOUT_FILENO, buf, sizeof(buf));
}

void term_goto (int x, int y) {
	char buf[512] = "";
	snprintf(buf, 512, "\x1b[%d;%dH", y + 1, x + 1);
	write(STDOUT_FILENO, buf, sizeof(buf));
}
