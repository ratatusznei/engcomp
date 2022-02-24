/* (defun mycompile () "Compile and change to window" (interactive) (compile "make") (windmove-down))
   (global-set-key [f1] 'mycompile) */
#include <stdio.h>

#include "editor.h"
#include "terminal.h"
#include "vt100.h"

int main (int argc, char **argv) {
	term_set();

	struct editor ed;

	if (argc > 1) editor_init(&ed, argv[1]);
	else          editor_init(&ed, NULL);

	int c;

	editor_draw(&ed);
	do {
		c = editor_process(&ed);
		editor_draw(&ed);
	} while (c != EOF && c != VT_CTRL('Q'));
}
