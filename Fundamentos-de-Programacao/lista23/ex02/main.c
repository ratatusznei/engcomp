/*
	Por: Fernando H. Ratusznei Caetano

 2. Escreva uma função que recebe 3 float's e retorna uma struct que tem 3
 campos do tipo float: menor, maior e meio. A função deve analisar os
 valores preencher a struct.

 MaMeMe classifica (float n1, float n2, float n3);
*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 3
#define USAGE "Usage: %s <n1> <n2> <n3>\n\n"

typedef struct {
	float maior;
	float meio;
	float menor;
} MaMeMe;

MaMeMe classifica (float n1, float n2, float n3);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	float n1 = atof(argv[1]);
	float n2 = atof(argv[2]);
	float n3 = atof(argv[3]);

	MaMeMe classificado = classifica(n1, n2, n3);

	printf("Maior = %.2f\n", classificado.maior);
	printf("Meio = %.2f\n", classificado.meio);
	printf("Menor = %.2f\n", classificado.menor);

	return 0;
}
   
MaMeMe classifica (float n1, float n2, float n3) {
	MaMeMe classificado;

	if (n1 > n2 && n1 > n3) {
		classificado.maior = n1;

		if (n2 > n3) {
			classificado.meio = n2;
			classificado.menor = n3;
		}
		else {
			classificado.meio = n3;
			classificado.menor = n2;
		}
	}
	else if (n2 > n1 && n2 > n3) {
		classificado.maior = n2;

		if (n1 > n3) {
			classificado.meio = n1;
			classificado.menor = n3;
		}
		else {
			classificado.meio = n3;
			classificado.menor = n1;
		}
	}
	else {
		classificado.maior = n3;

		if (n1 > n2) {
			classificado.meio = n1;
			classificado.menor = n2;
		}
		else {
			classificado.meio = n2;
			classificado.menor = n1;
		}
	}

	return classificado;
}

