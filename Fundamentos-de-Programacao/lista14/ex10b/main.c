/*
	Por: Fernando H. Ratusznei Caetano

 Escreva uma função que faz o oposto da questão a: recebe uma string de 17
 bytes contendo caracteres 0 e 1 (mais o '\0' na última posição) e retorna
 um número de 16 bits sem sinal contendo o valor que temos interpretando
 os caracteres da string como se fossem dígitos de um número binário.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

unsigned short strton (char str[17]);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}
	
	/*                               1   1   1   1  */
	printf("0x0010 = %d\n", strton("0000000000010000"));
	printf("0x0110 = %d\n", strton("0000000100010000"));
	printf("0x0011 = %d\n", strton("0000000000010001"));
	printf("0x0013 = %d\n", strton("0000000000010011"));

	return 0;
}

unsigned short strton (char str[17]) {
	unsigned short n = 0;
	int i;

	for (i = 0; i < 17 - 1; i++) {
		n <<= 1;

		n |= str[i] - '0';
	}

	return n;
}

