/*
	Por: Fernando H. Ratusznei Caetano

 10. Você deve implementar uma função que recebe um número e retorna 1 se
 ele é primo, ou 0 do contrário (lembrando que, na linguagem C, 0 equivale
 a “falso” e qualquer outro valor equivale a “verdadeiro”). Você pode
 pressupor que n é sempre maior ou igual a 2. Duas dicas que podem melhorar
 o desempenho da sua função

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define N_ARGS 1
#define USAGE "Usage: %s <n>\n\n"

int ehPrimo (long long n);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	long long n = atoll(argv[1]);

	int eh_ou_nao;
	float inicio;
	float fim;

	inicio = (1000.0 * clock()) / CLOCKS_PER_SEC;
	eh_ou_nao = ehPrimo(n); 
	fim = (1000.0 * clock()) / CLOCKS_PER_SEC;

	printf("Inicio:  %f ms\n", inicio);
	printf("Fim:     %f ms\n", fim); 
	printf("Delta t: %f ms\n", fim - inicio);
	printf("Entrada: %llu\n", n);
	printf("Saida:   %d\n\n", eh_ou_nao);

	return 0;
}


int ehPrimo (long long n) {
	long long rt_n = sqrt(n);
	int i;
	
	if (n == 1 || (n % 2 == 0 && n != 2)) {
		return 0;
	}

	for (i = 3; i < rt_n + 1; i += 2) {
		if (n % i == 0) {
			return 0;
		}
	}

	return 1;
}

