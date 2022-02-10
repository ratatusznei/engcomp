/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva uma função que recebe como parâmetros um vetor de inteiros e o
 seu tamanho, e retorna o tamanho da maior sequência não decrescente
 encontrada

*/

#include <stdio.h>
#include <stdlib.h>

#define SIZE 12

int tamMaiorSeqNDec (int* val, int n, int* inicio, int* fim);

int main (int argc, char *argv[]) {

	int v[SIZE] = { 1, 5, 6, 4, 9, 13, 13, 13, 55, 54, 40, 28 };
	//int v[SIZE] = { 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };

	int inicio = 0;
	int fim = 0;
	int tam = tamMaiorSeqNDec(v, SIZE, &inicio, &fim);

	while (inicio <= fim) {
		printf("%d, ", v[inicio++]);
	}

	printf("\b\b \n%d\n", tam);
	

	return 0;
}

int tamMaiorSeqNDec (int* val, int n, int* inicio, int* fim) {
	int i = 0;
	int tam = 1;

	*inicio = 0;
	*fim = 0;

	while (i < n) {
		for (tam = 1; tam < n - i; tam++) {
			if (val[i + tam] < val[i + tam - 1]) {
				break;
			}
		}

		if (tam > (*fim - *inicio)) {
			*inicio = i;
			*fim = i + tam - 1;
		}

		i += tam;
	}

	return *fim - *inicio + 1;
}

