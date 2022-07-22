/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva um programa que mostra todos os valores a, b e c tal que 
 a+b+c = n, sendo que n é dado e todos os valores são inteiros maiores que 0

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <n>\n\n"

void printFatores (int n);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int n = atoi(argv[1]);

	printFatores(n);

	return 0;
}

void printFatores (int n) {
	int a;
	int b;

	for (a = 1; a < n; a++) {
		for (b = 1; b < n - a; b++) {
			printf("%d + %d + %d = %d\n", a, b, n - a - b, n);
		}
	}
	
	putchar('\n');
}

