/*
	Por: Fernando H. Ratusznei Caetano

 1. Escreva um programa que aloque memória para dois vetores, com tamanhos
 diferentes, dados pelo usuário. Os vetores devem ser preenchidos com
 valores aleatórios no intervalo [0, 10]. O programa deve então criar um
 terceiro vetor, capaz de conter todos os elementos Vi*Vj, onde Vi é um
 elemento do primeiro vetor e Vj é um elemento do segundo vetor.
 A multiplicação elemento-a-elemento dos dois vetores deve ser calculada,
 e os valores obtidos devem ser apresentados.
 Dica: você pode usar uma ou mais funções para organizar o seu código.

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N_ARGS 2
#define USAGE "Usage: %s <tamanho1> <tamanho2>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	const int size1 = atoi(argv[1]);
	const int size2 = atoi(argv[2]);
	const int size3 = size1 * size2;

	const int bigger_size = (size1 > size2)? size1: size2;

	char *v1 = (char *) malloc(size1 * sizeof(char));
	char *v2 = (char *) malloc(size2 * sizeof(char));
	char *v3 = (char *) malloc(size3 * sizeof(char));

	int i;
	int j;

	srand(time(NULL));
	
	for (i = 0; i < bigger_size; i++) {
		if (i < size1) {
			v1[i] = rand() % 11;
		}
		if (i < size2) {
			v2[i] = rand() % 11;
		}
	}

	for (i = 0; i < size1; i++) {
		for (j = 0; j < size2; j++) {
			v3[i * size2 + j] = v1[i] * v2[j];
		}
	}

	printf("v1: ");
	for (i = 0; i < size1; i++) {
		printf("%d ", v1[i]);
	}

	printf("\nv2: ");
	for (i = 0; i < size2; i++) {
		printf("%d ", v2[i]);
	}

	printf("\nv3: ");
	for (i = 0; i < size3; i++) {
		printf("%d ", v3[i]);
	}

	printf("\n\n");

	free(v1);
	free(v2);
	free(v3);
	return 0;
}

