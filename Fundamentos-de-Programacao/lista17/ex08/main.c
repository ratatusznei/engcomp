/*
	Por: Fernando H. Ratusznei Caetano

 8. Escreva uma função que recebe como parâmetro apenas uma string, e
 retorna o número de palavras que existem nela, supondo que uma palavra
 contém apenas letras – ou seja, números, espaços, pontuação e quaisquer
 outros caracteres são tratados como divisores entre palavras

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s \"str\"\n\n"

char isAlpha (char c);
int wordCount (char *str);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	printf("%d\n\n", wordCount(argv[1]));

	return 0;
}

char isAlpha (char c) {
	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

int wordCount (char *str) {
	int i;
	int n_words = 0;

	while (str[i] != '\0') {
		if (isAlpha(str[i])) {
			n_words++;

			do {
				i++;
			} while (isAlpha(str[i]));
		}
		else {
			i++;
		}
	}

	return n_words;
}

