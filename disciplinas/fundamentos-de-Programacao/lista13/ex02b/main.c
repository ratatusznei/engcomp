/*
	Por: Fernando H. Ratusznei Caetano

 Qual o valor da constante RAND_MAX para o seu compilador?

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	printf("%u\n\n", RAND_MAX);

	return 0;
}
