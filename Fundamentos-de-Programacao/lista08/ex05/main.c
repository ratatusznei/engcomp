/*
	Por: Fernando H. Ratusznei Caetano

 5. Escreva um programa que calcule o quociente e o resto da divisão de dois
 números inteiros positivos dados, usando apenas as operações de soma e/ou
 subtração.

 @params:
	x, y

 @return:
	Divisao de x por y e resto

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 2
#define USAGE "Usage: %s <dividendo> <divisor>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int x = atoi(argv[1]);
	int y = atoi(argv[2]);

	int divisao = 0;
	int resto = x;

	while (resto > y) {
		resto -= y;
		divisao++;
	}

	printf("%d / %d = %d com resto %d\n\n", x, y, divisao, resto);

	return 0;
}
