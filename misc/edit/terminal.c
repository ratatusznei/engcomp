#include "terminal.h"
#include "vt100.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

struct termios t0;

void term_set () {
	if (0 != tcgetattr(STDIN_FILENO, &t0)) {
		perror(__func__);
		exit(EXIT_FAILURE);
	}

	struct termios t = t0;
	cfmakeraw(&t);

	if (0 != tcsetattr(STDIN_FILENO, TCSAFLUSH, &t)) {
		perror(__func__);
		exit(EXIT_FAILURE);
	}

	atexit(term_reset);
}

void term_reset () {
	if (0 != tcsetattr(STDIN_FILENO, TCSAFLUSH, &t0)) {
		perror(__func__);
		exit(EXIT_FAILURE);
	}

	vt_clear();
}

void term_getdimensions (int *w, int *h) {
	struct winsize size;
	ioctl(STDOUT_FILENO, TIOCGWINSZ, &size);
	*w = size.ws_col - 1;
	*h = size.ws_row - 1;
}
