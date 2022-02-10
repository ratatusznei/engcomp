/*
	Por: Fernando H. Ratusznei Caetano

 3. Escreva uma função que recebe uma string e retorna 1 se ela contém um
 palíndromo, ou 0 do contrário. Um palíndromo é uma sequência que pode ser
 lida igualmente da esquerda para a direita ou da direita para esquerda.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <palindromo>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	char *str = argv[1];
	int size = 0;
	int i;
	char ehPalindromo = 1;

	while (str[size]) {
        /* Aproveita a contagem e converte tudo para uppercase */
		str[size] += (str[size] >= 'a' && str[size] <= 'z')?
			 'A' - 'a' : 0;
		size++;
	}

	for (i = 0; i < size / 2; i++) {
		if (str[i] != str[size-i-1]) {
			ehPalindromo = 0;
			break;
		}
	}

	printf("%d\n\n", ehPalindromo);

	return 0;
}
