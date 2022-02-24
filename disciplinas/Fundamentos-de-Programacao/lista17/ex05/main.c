/*
	Por: Fernando H. Ratusznei Caetano

 5. Cebolinha é um personagem de história em quadrinhos que quando fala,
 troca o R pelo L. Escreva uma função stling, que recebe uma string s e um
 buffer (um vetor capaz de armazenar outra string com o mesmo tamanho de s)
 e armazene no buffer uma versão de s  com todos os R's trocados por L's,
 exceto quando o R é a última letra de uma palavra. Dois R's seguidos devem
 ser substituídos por um único L. Lembre-se de manter as letras maiúsculas
 e minúsculas como no texto original.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s \"frase\"\n\n"

int stling(int size, char *str, char *stl);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	char *str;
	char *stl;

	int i;
	int size = 0;

	while (argv[1][size++] != '\0') {
		/**/	
	}

	str = malloc(size * sizeof(char));
	stl = malloc(size * sizeof(char));

	for (i = 0; i < size; i++) {
		str[i] = argv[1][i];
	}

	size = stling(size, str, stl);

	for (i = 0; i < size; i++) {
		putchar(stl[i]);
	}
	putchar('\n');


	free(str);
	free(stl);
	return 0;
}

char isAlpha (char c) {
	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

int stling(int size, char *str, char *stl) {
	int ri;
	int li = 0;

	for (ri = 0; ri < size; ri++, li++) {
		if (!isAlpha(str[ri + 1])) {
			stl[li] = str[ri];
			continue;
		}

		if (str[ri] == 'r' || str[ri] == 'R') {
			stl[li] = str[ri] - ('r' - 'l');

			if (str[ri + 1] == 'r' || str[ri + 1] == 'R') {
				ri++;
			}
		}
		else {
			stl[li] = str[ri];
		}
	}

	stl[li++] = '\0';
	
	return li;
}

