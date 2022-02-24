/*
	Por: Fernando H. Ratusznei Caetano

 7. Escreva um programa que gera e mostra um vetor contendo N elementos
 aleatórios. O usuário pode informar uma  posição do vetor. O programa
 deve então remover o elemento na posição informada, “puxando” todos os
 elementos das posições posteriores uma posição para “trás”. Após a
 remoção, o programa deve mostrar como o vetor ficou e pedir uma nova
 entrada ao usuário. O programa termina quando o vetor ficar vazio ou se o
 usuário selecionar uma posição que estaria fora do vetor.

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

#define N 10

void putv (int *vetor, int size);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	srand(time(NULL));

	int i;
	int vetor[N];
	int size = N;

	for (i = 0; i < size; i++) {
		vetor[i] = random() % 10;
	}


	while (size > 0) {
		putv(vetor, size);

		printf("Remover: ");
		scanf("%d", &i);
		
		if (i < 0 && i > size - 1) {
			break;
		}

		size--;
		while (i < size) {
			vetor[i] = vetor[i + 1];
			i++;
		}
	}

	return 0;
}


void putv (int *vetor, int size) {
	int i;
	
	printf("[ ");
	
	for (i = 0; i < size - 1; i++) {
		printf("%d, ", vetor[i]);
	}

	printf("%d ]\n", vetor[i]);
}

