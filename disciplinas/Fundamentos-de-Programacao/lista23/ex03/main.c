/*
	Por: Fernando H. Ratusznei Caetano

 3. Escreva uma versão da função anterior que ordena os valores já
 colocados em uma variável passada por referência. Os valores são dados
 em uma ordem arbitrária, e reordenados pela função.

 void classifica (MaMeMe* valores);

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

void classifica (MaMeMe* valores);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	MaMeMe a;

	a.maior = atof(argv[1]);
	a.meio = atof(argv[2]);
	a.menor = atof(argv[3]);

	classifica(&a);

	printf("Maior = %.2f\n", a.maior);
	printf("Meio = %.2f\n", a.meio);
	printf("Menor = %.2f\n", a.menor);
	
return 0;
}

void classifica (MaMeMe* valores) {
	float aux;

	/* Bubble sort */
	if (valores->menor > valores->meio) {
		aux = valores->menor;
		valores->menor = valores->meio;
		valores->meio = aux;
	}
	if (valores->meio > valores->maior) {
		aux = valores->meio;
		valores->meio = valores->maior;
		valores->maior = aux;
	}
	if (valores->menor > valores->meio) {
		aux = valores->menor;
		valores->menor = valores->meio;
		valores->meio = aux;
	}
}

