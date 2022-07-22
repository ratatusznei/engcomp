/*
	Por: Fernando H. Ratusznei Caetano

 7. Escreva um programa no qual uma matriz é preenchida com caracteres
 (use a inicialização direta, com chaves). O programa deve mostrar na tela
 o padrão espelhado nos 2 eixos.
*/

#include <stdio.h>
#include <stdlib.h>

#define ROWS 5

int main (int argc, char *argv[]) {
	char pattern [ROWS][10] = {
		"ABCDE",
		" BCDE",
		"  CDE",
		"   DE",
		"    E",
	};

	int i;
	int j;
	int dir = 1;

	for (i = 0; i >= 0; i += dir) {
		j = 0;

		while (pattern[i][j] != '\0') {
			putchar(pattern[i][j++]);
		}

		while (j > 0) {
			putchar(pattern[i][--j]);
		}

		putchar('\n');

		if (i == ROWS - 1) {
			dir = -1;
		}
	}

	return 0;
}

