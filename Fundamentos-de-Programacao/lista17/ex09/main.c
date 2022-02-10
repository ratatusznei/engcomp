/*
	Por: Fernando H. Ratusznei Caetano

 9. Escreva uma função que inverte uma string, deixando o texto de trás para
 a frente. A função deve receber como parâmetro apenas a string, e colocar 
 o resultado no próprio buffer de entrada.Suponha que a string é terminada
 em '\0', e não use funções da biblioteca-padrão. Os tamanhos da string e
 do buffer que a contém são desconhecidos a priori.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s \"str\"\n\n"

char *mirrorString (char *str);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	printf("%s\n\n", mirrorString(argv[1]));

	return 0;
}

char *mirrorString (char *str) {
	int size = 0;
	int i;

	while (str[size] != '\0') {
		size++;
	}

	for (i = 0; i < size >> 1; i++) {
		str[i] ^= str[size - i - 1];
		str[size - i - 1] ^= str[i];
		str[i] ^= str[size - i - 1];
	}

	return str;
}

