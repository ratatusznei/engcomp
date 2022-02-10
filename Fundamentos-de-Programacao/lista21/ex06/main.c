/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva um programa que gera uma matriz quadrada e a preenche de forma
 a gerar uma “matriz inca”. O número de linhas/colunas deve ser fornecido
 pelo usuário.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <lado>\n\n"

void geraMatrizInca (int** matriz, int lado);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int i;
	int j;
	int lado = atoi(argv[1]);

	int **inca = (int **) malloc(lado * sizeof(int *));

	for (i = 0; i < lado; i++) {
		inca[i] = (int *) malloc(lado * sizeof(int));
	}

	geraMatrizInca(inca, lado);

	for (i = 0; i < lado; i++) {
		for (j = 0; j < lado; j++) {
			printf("%4d ", inca[i][j]);
		}

		putchar('\n');
	}
	
	for (i = 0; i < lado; i++) {
		free(inca[i]);
	}

	free(inca);

	return 0;
}

void geraMatrizInca (int** matriz, int lado) {
	int i;
	int n = 1;

	int i_max = lado;
	int i_min = 0;

	while (i_max > i_min) {
		i_max--;

		/* -> */
		for (i = i_min; i <= i_max; i++) {
			matriz[i_min][i] = n++;
		}

		/* |
		   V */
		for (i = i_min + 1; i <= i_max; i++) {
			matriz[i][i_max] = n++;
		}

		/* <- */
		for (i = i_max - 1; i >= i_min; i--) {
			matriz[i_max][i] = n++;
		}

		/* A 
		   | */
		for (i = i_max - 1; i >= i_min + 1; i--) {
			matriz[i][i_min] = n++;
		}

		i_min++;
	}
}

