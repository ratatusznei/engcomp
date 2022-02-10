/*
	Por: Fernando H. Ratusznei Caetano

 1. Escreva programas para gerar e mostrar N valores aleatórios, onde N é
 uma constante dada,sendo que:

 c) Os valores são do tipo int e estão no intervalo [0, 100].
 d) Os valores são do tipo int e estão no intervalo [50, 100].
 e) Os valores são do tipo double e estão no intervalo [0, 1].
 f) Os valores são do tipo float e estão no intervalo [-40, 40].

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

double drand(double min, double max);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}
	
	srand(time(NULL));

	int i;
	
	for (i = 0; i < 100; i++) {
		printf("(int) [0, 100] = %d\n", (int) drand(0, 100));
		printf("(int) [50, 100] = %d\n", (int) drand(50, 100));
		printf("(double) [0, 1] = %lf\n", drand(0, 1));
		printf("(float) [-40, 40] = %f\n\n", (float)drand(-40, 40));
	}
	return 0;
}


double drand(double min, double max) {
	return (rand() * (max - min)) / (float) (RAND_MAX) + min;
}
