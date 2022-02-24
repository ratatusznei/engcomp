/*
	Por: Fernando H. Ratusznei Caetano

 9. Escreva uma função que recebe um número com uma quantidade arbitrária
 de dígitos, e retorna o número com os dígitos invertidos. Por exemplo, se
 a função receber o valor 1234, deve retornar 4321. Zeros à esquerda devem
 ser ignorados – portanto, se a função receber o valor 1400,
 deve retornar 41.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <n>\n\n"

unsigned int inverteNum (unsigned int n);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	printf("%u\n\n", inverteNum(atoi(argv[1])));

	return 0;
}


unsigned int inverteNum (unsigned int n) {
	unsigned invertido = 0;

	while (n > 0) {
		invertido *= 10;
		invertido += n % 10;
		n /= 10;
	}
	
	return invertido;
}

