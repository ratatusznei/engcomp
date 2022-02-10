/*
	Por: Fernando H. Ratusznei Caetano

 2. Escreva uma função que arredonda um valor dado. O número deve ser
 arredondado para o inteiro mais próximo. Se o número for equidistante de
 dois inteiros, deve ser arredondado para o valor de maior magnitude.
 Ou seja, 1.5 é arredondado para 2, e -1.5 é arredondado para -2

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <n>\n\n"

int arredonda (double n);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	double n = atof(argv[1]);

	printf("%d\n\n", arredonda(n));

	return 0;
}

int arredonda (double n) {
	return (int) (n >= 0.0? n + 0.5: n - 0.5);
}
