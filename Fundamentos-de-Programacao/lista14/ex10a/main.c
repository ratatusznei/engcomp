/*
	Por: Fernando H. Ratusznei Caetano

 a) Escreva uma função que recebe um número n de 16 bits (sem sinal) e um
 buffer de 17 bytes, e coloca no buffer uma string representando a
 sequência binária correspondente ao valor de n, terminada em '\0'.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

void ntostr (unsigned short n, char buffer[17]);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	char str[17];
	unsigned short i;
	
	for (i = 0; i < 256; i += 5) {
		ntostr(i, str);
		printf("%d = %s\n", i, str);
	}

	return 0;
}

void ntostr (unsigned short n, char buffer[17]) {
	int i;

	for (i = 0; i < 17; i++) {
		buffer[17 - i - 1] = (n & 0x01)? '1': '0';
		n >>= 1;
	}

	buffer[i] = '\0';
}
