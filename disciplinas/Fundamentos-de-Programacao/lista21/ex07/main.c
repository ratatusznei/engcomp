/*
	Por: Fernando H. Ratusznei Caetano

 7. Escreva uma função que recebe uma matriz quadrada, alocada
 dinamicamente, e retorna 1 se ela é um quadrado mágico, ou 0 do contrário.

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N_ARGS 1
#define USAGE "Usage: %s <lado>\n\n"

int isMagicSquare (int **square, int side);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int i;
	int j;

	int side = atoi(argv[1]);

	int **magic = (int **) malloc(side * sizeof(int *));

	for (i = 0; i < side; i++) {
		magic[i] = (int *) malloc(side * sizeof(int));
	}

	srand(time(NULL));
	for (i = 0; i < side; i++) {
		for (j = 0; j < side; j++) {
			magic[i][j] = rand() % 100;

			printf("%2d ", magic[i][j]);
		}

		putchar('\n');
	}

	printf("\nIs magic:  %d\n\n", isMagicSquare(magic, side));

	for (i = 0; i < side; i++) {
		free(magic[i]);
	}
	free(magic);

	return 0;
}

int isMagicSquare (int **square, int side) {
	int i;
	int j;

	int principal_sum = 0;
	int sum = 0;

	/* Diagonal principal */
	for (i = 0; i < side; i++) {
		principal_sum += square[i][i];
	}

	/* Diagonal secundaria */
	for (i = 0; i < side; i++) {
		sum += square[i][side - 1 - i];
	}
	
	if (sum != principal_sum) {
		return 0;
	}
	
	for (i = 0; i < side; i++) {
		/* Linha */
		sum = 0;

		for (j = 0; j < side; j++) {
			sum += square[i][j];
		}

		if (sum != principal_sum) {
			return 0;
		}

		/* Coluna */
		sum = 0;

		for (j = 0; j < side; j++) {
			sum += square[j][i];
		}

		if (sum != principal_sum) {
			return 0;
		}
	}

	return 1;
}
