#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <unistd.h>

#include "terminal.h"
#include "word.h"

#ifndef INIT_WORD_COUNT
#	define INIT_WORD_COUNT 1
#endif

#ifndef MAX_WORDS
#	define MAX_WORDS 64
#endif

#ifndef NEXT_WORD_MULTIPLIER
#	define NEXT_WORD_MULTIPLIER 8
#endif

struct {
	int term_width;
	int term_heigh;
	int pontos;
	int next_word_count;
	int n_words;
	struct word words[MAX_WORDS];
} G;

void init_G () {
	term_getsize(&G.term_width, &G.term_heigh);
	term_clear();

	char buf[] = "\x1b[?25l";
	write(STDOUT_FILENO, buf, sizeof(buf));

	G.pontos = 0;
	G.next_word_count = 3;
	G.n_words = INIT_WORD_COUNT;
}

int main () {
	term_set();
	srand(time(NULL));
	init_G();

	for (int i = 0; i < G.n_words; i++) {
		word_create(&G.words[i], G.term_width);
	}

	int running = 1;
	while (running) {
		char c = 0;

		if (read(STDIN_FILENO, &c, 1) < 1) {
			c = 0;
		}

		for (int i = G.n_words - 1; i >= 0; i--) {
			word_clear(G.words[i]);

			if (c == G.words[i].letters[G.words[i].i]) {
				G.words[i].i += 1;

				if (G.words[i].i == G.words[i].len) {
					G.next_word_count--;
					G.pontos += G.words[i].len;
					word_create(&G.words[i], G.term_width);
				}
			}
			else {
				G.words[i].i = 0;
				G.words[i].y += 1;
			}
		}

		if (G.n_words < MAX_WORDS && G.next_word_count <= 0) {
			G.next_word_count = G.n_words * NEXT_WORD_MULTIPLIER;
			word_create(&G.words[G.n_words], G.term_width);
			G.n_words++;
		}

		for (int i = 0; i < G.n_words; i++) {
			word_print(G.words[i]);

			if (G.words[i].y > G.term_heigh - 2) {
				running = 0;
				break;
			}
		}

		term_goto(0, G.term_heigh - 1);
		char *pontos_buf = calloc(4 + G.term_width + 4, sizeof(char));
		sprintf(pontos_buf, "\x1b[7mPontos: %d", G.pontos);
		int len = strlen(pontos_buf);

		int i;
		for (i = len; i < 4 + G.term_width; i++) {
			pontos_buf[i] = ' ';
		}
		pontos_buf[i++] = '\x1b';
		pontos_buf[i++] = '[';
		pontos_buf[i++] = '0';
		pontos_buf[i++] = 'm';

		write(STDOUT_FILENO, pontos_buf, 4 + G.term_width + 4);
		free(pontos_buf);
	}

	char *fim_buf = malloc(sizeof(G.term_width));
	sprintf(fim_buf, "FIM DE JOGO | Pontos: %d", G.pontos);
	int len = strlen(fim_buf);

	term_goto((G.term_width - len) / 2, G.term_heigh / 2);
	write(STDOUT_FILENO, fim_buf, len);

	term_goto(G.term_width - 1, G.term_heigh - 1);
	term_reset();
	int c;
	while ((c = getchar()) != '\r' && c != '\n' && c != EOF)
		;

	return 0;
}
