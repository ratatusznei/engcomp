/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva um programa que gera duas matrizes A e B, respectivamente com
 MxN e NxM posições, e ambas contendo valores aleatórios. O programa deve
 mostrar o resultado da multiplicação A·B

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define M 2
#define N 2

void putm(int *m, int rows, int cols);

int main (int argc, char *argv[]) {
	int a[M][N];
	int b[N][M];
	int c[M][M];

	int i;
	int j;
	int k;

	srand(time(NULL));

	for (i = 0; i < M * N; i++) {
		a[i / M][i % M] = rand() % 10;
		b[i / N][i % N] = rand() % 10;
	}

	/*
		a[M][N] * b[N][M] = c[M][M]

		cij = aix . bxj = ai1 * b1j + ai2 * b2j ...
	*/

	for (i = 0; i < M; i++) {
		for (j = 0; j < M; j++) {
			int cij = 0;

			for (k = 0; k < N; k++) {
				cij += a[i][k] * b[k][j];
			}

			c[i][j] = cij;
		}
	}

	printf("A = \n");
	putm(&a[0][0], M, N);

	printf("\nB = \n");
	putm(&b[0][0], N, M);

	printf("\nC = \n");
	putm(&c[0][0], M, M);

	return 0;
}

void putm(int *m, int rows, int cols) {
	int i;

	printf("\t");

	for (i = 0; i < rows * cols; i++) {
		printf("%2d", m[i]);

		if ((i + 1) % cols == 0) {
			printf("\n\t");
		}
		else {
			printf(", ");
		}
	}

	printf("\n");
}
