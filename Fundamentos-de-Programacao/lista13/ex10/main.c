/*
	Por: Fernando H. Ratusznei Caetano

 10. Suponha que dois números formam um par de Foolano se ambos têm os
 mesmos dígitos, na mesma quantidade, desconsiderando-se os zeros à
 esquerda. Por exemplo, os pares abaixo são pares de Foolano: 
  1234 e 4321; 1122 e 1212; 101 e 101; 344 e 443.
 Já os pares abaixo não são pares de Foolano:
  123 e 124; 221 e 112; 022 e 220. Escreva uma função que retorna 1 se 2
 números dados formam um par de Foolano, ou 0 do contrário.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 2
#define USAGE "Usage: %s <n1> <n2>\n\n"

int ehParDeFoolano (unsigned int n1, unsigned int n2);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}
	
	int eh = ehParDeFoolano(atoi(argv[1]), atoi(argv[2]));

	printf(eh? "Sao foolanos": "Nao sao foolanos");
	puts("\n");

	return 0;
}

int ehParDeFoolano (unsigned int n1, unsigned int n2) {
	char freq1[10] = "";
	char freq2[10] = "";

	int digito;
	int i;

	while (n1 > 0) {
		digito = n1 % 10;
		n1 /= 10;

		freq1[digito]++;
	}
	
	while (n2 > 0) {
		digito = n2 % 10;
		n2 /= 10;

		freq2[digito]++;
	}	
	
	for (i = 0; i < 10; i++) {
		if (freq1[i] != freq2[i]) {
			return 0;
		}
	}
	
	return 1;
}

