/*
	Por: Fernando H. Ratusznei Caetano

 7. Implemente uma função que cria uma tabela usando o algoritmo do Crivo
 de Erastótenes. A função deve alocar uma tabela grande, com mais de 1
 milhão de valores. A responsabilidade de desalocá-la é do chamador.

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define N_ARGS 1
#define USAGE "Usage: %s <n max>\n\n"

char *sieve (unsigned max);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int max = atoi(argv[1]) + 1;
	char *table = sieve(max);
	int i;

	for (i = 2; i < max; i++) {
		if (table[i - 2]) {
			/* Formmated for 80 char console */
			printf("%6d, ", i);
		}
	}

	printf("\b \n\n");

	free(table);
	return 0;
}

char *sieve (unsigned max) {
	printf("Allocating...\n");
	char *table = malloc((max - 2) * sizeof (char));
	printf("Computing...\n");

	int i;
	int j;
	int sqrt_max = sqrt((double) max) + 1;

	for (i = 2; i < max; i++) {
		table[i-2] = 1;
	}

	for (i = 2; i < sqrt_max; i++) {
		if (table[i - 2] == 0) {
			continue;
		}

		for (j = i * i; j < max; j += i) {
			table[j - 2] = 0;
		}
	}

	return table;
}

