#ifndef TERMINAL_H
#define TERMINAL_H

void term_set ();
void term_reset ();
void term_getsize (int *width, int *heigh);

void term_clear ();
void term_goto (int x, int y);

#endif /* TERMINAL_H */
