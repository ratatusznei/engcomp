/*
	Por: Fernando H. Ratusznei Caetano

 2. Escreva uma função que recebe um vetor de inteiros e um vetor de saída
 com a mesma capacidade. A função deve colocar no vetor de saída os
 elementos do vetor de entrada, mas sem repetições, e retornar o número de
 elementos inseridos no vetor de saída

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 12

unsigned copiaSemRepeticao (unsigned size, int *in, int *out);

int main (int argc, char *argv[]) {
	int v1[SIZE];
	int v2[SIZE];
	int i;
	int v2_size;

	srand(time(NULL));

	printf("v1 = { ");
	for (i = 0; i < SIZE; i++) {
		v1[i] = rand() % 10;
		printf("%d, ", v1[i]);
	}
	printf("\b\b }\n");

	v2_size = copiaSemRepeticao(SIZE, v1, v2);

	printf("v2 = { ");
	for (i = 0; i < v2_size; i++) {
		printf("%d, ", v2[i]);
	}
	printf("\b\b }\n");

	return 0;
}

char isInVector(int n, unsigned size, int *v) {
	int i;

	for (i = 0; i < size; i++) {
		if (v[i] == n) {
			return 1;
		}
	}

	return 0;
}

unsigned copiaSemRepeticao (unsigned size, int *in, int *out) {
	int i;
	int j;

	for (i = 0; i < size; i++) {
		out[i] = 0;
	}

	for (i = 0, j = 0; i < size; i++) {
		if (!isInVector(in[i], j, out)) {
			out[j] = in[i];
			j++;
		}
	}

	return j;
}

