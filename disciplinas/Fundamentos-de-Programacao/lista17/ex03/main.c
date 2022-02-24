/*
	Por: Fernando H. Ratusznei Caetano

 3. Escreva um programa que gera dois vetores, cada um contendo N valores
 aleatórios entre 0 e 2N-1. Crie então 3 funções, que analisam os vetores
 e colocam em um vetor de saída:

 a) Apenas os valores que aparecem em ambos os vetores.
 b) Apenas os valores que aparecem em somente um dos vetores.
 c) Todos os valores que aparecem nos dois vetores.

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N_ARGS 1
#define USAGE "Usage: %s <N>\n\n"

int set_intersection (unsigned size, int *v1, int *v2, int *v1_and_v2);
int set_xou (unsigned size, int *v1, int *v2, int *out);
int set_union (unsigned size, int *v1, int *v2, int *out);

unsigned copiaSemRepeticao (unsigned size, int *in, int *out);
void printv (const char *name, unsigned size, int *v);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	const unsigned N = atoi(argv[1]);
	int *v1 = malloc(N * sizeof(int));
	int *v2 = malloc(N * sizeof(int));
	int *v3 = malloc(N * sizeof(int));

	int i;

	srand(time(NULL));
	for (i = 0; i < N; i++) {
		v1[i] = rand() % (2 * N);
		v2[i] = rand() % (2 * N);
	}

	printv("v1", N, v1);
	printv("v2", N, v2);

	i = set_intersection(N, v1, v2, v3);
	printv("v1 e v2", i, v3);

	free(v3);
	v3 = malloc(2 * N * sizeof(int));

	i = set_xou(N, v1, v2, v3);
	printv("v1 xor v2", i, v3);
	
	free(v3);
	v3 = malloc(2 * N * sizeof(int));

	i = set_union(N, v1, v2, v3);
	printv("v1 or v2", i, v3);
	
	free(v1);
	free(v2);
	free(v3);
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

void printv (const char *name, unsigned size, int *v) {
	int i;
	
	if (size == 0) {
		printf("%s = []\n", name);
		return;
	}
	
	printf("%s = [ ", name);
	
	for (i = 0; i < size; i++) {
		printf("%d, ", v[i]);
	}

	printf("\b\b ]\n");
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

int set_intersection (unsigned size, int *v1, int *v2, int *v1_and_v2) {
	int *v1_norep = NULL;
	int size1;

	int *v2_norep = NULL;
	int size2;

	int i;
	int j;
	int k = 0;

	v1_norep = malloc(size * sizeof(int));
	v2_norep = malloc(size * sizeof(int));

	size1 = copiaSemRepeticao(size, v1, v1_norep);
	size2 = copiaSemRepeticao(size, v2, v2_norep);

	for (i = 0; i < size1; i++) {
		for (j = 0; j < size2; j++) {
			if (v1_norep[i] == v2_norep[j]) {
				v1_and_v2[k++] = v1_norep[i];
				break;
			}
		}
	}

	return k;
}

int set_xou (unsigned size, int *v1, int *v2, int *v1_xor_v2) {
	int *v1_norep = NULL;
	int size1;

	int *v2_norep = NULL;
	int size2;

	int i;
	int k = 0;

	v1_norep = malloc(size * sizeof(int));
	v2_norep = malloc(size * sizeof(int));

	size1 = copiaSemRepeticao(size, v1, v1_norep);
	size2 = copiaSemRepeticao(size, v2, v2_norep);

	for (i = 0; i < size1; i++) {
		if (!isInVector(v1_norep[i], size2, v2_norep)) {
			v1_xor_v2[k++] = v1_norep[i];
		}
	}

	for (i = 0; i < size2; i++) {
		if (!isInVector(v2_norep[i], size1, v1_norep)) {
			v1_xor_v2[k++] = v2_norep[i];
		}
	}


	return k;
}

int set_union (unsigned size, int *v1, int *v2, int *v1_or_v2) {
	int i;

	int *v1_or_v2_rep;
	v1_or_v2_rep = malloc(2 * sizeof(int));

	for (i = 0; i < size; i++) {
		v1_or_v2_rep[i] = v1[i];
	}

	for (i = 0; i < size; i++) {
		v1_or_v2_rep[i + size] = v2[i];
	}


	return copiaSemRepeticao(2 * size, v1_or_v2_rep, v1_or_v2);
}

