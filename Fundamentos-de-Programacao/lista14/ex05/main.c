/*
	Por: Fernando H. Ratusznei Caetano

 5. Escreva uma função que retorna 1 se os valores em um vetor de inteiros
 dado estiverem em ordem crescente, ou 0 do contrário. Procure fazer a
 função retornar tão logo quanto possível, evitando testes desnecessários.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

char ehCrescente (int *vals, int n);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int v1[10] = {0, 1, 2, 5, 6, 7, 8, 9, 10, 11};
	int v2[10] = {1, 0, 6, 5, 6, 7, 8, 9, 10, 11};

	printf("V1: %d\nV2: %d\n\n",ehCrescente(v1,10),ehCrescente(v2,10));

	return 0;
}


char ehCrescente (int *vals, int n) {
	int i;
	for (i = 1; i < n; i++) {
		if(vals[i] <= vals[i-1]) {
			return 0;
		}
	}

	return 1;
}

