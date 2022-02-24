#ifndef WORD_H
#define WORD_H

struct word {
	char letters[32];
	int len;
	int x;
	int y;
	int i;
};

void word_clear (struct word w);
void word_print (struct word w);
void word_create (struct word *pw, int x);

#endif /* WORD_H */
