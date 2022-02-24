#include "vt100.h"
#include <string.h>
#include <stdio.h>
#include <unistd.h>

void vt_clear () {
	char buf[] = "\x1b[2J";
	write(STDOUT_FILENO, buf, sizeof(buf) / sizeof(char));
}

void vt_goto (int x, int y) {
	char buf[128];
	sprintf(buf, "\x1b[%d;%df", y + 1, x + 1);
	int len = strlen(buf);
	write(STDOUT_FILENO, buf, strlen(buf));
}
