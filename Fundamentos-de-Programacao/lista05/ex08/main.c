/*
8. Escreva um programa que recebe 3 valores e verifica se eles podem ser os comprimentos dos
lados de um triângulo. Em caso positivo, escrever uma mensagem informando se é um triângulo
isósceles, equilátero ou escaleno. Obs.: o comprimento de um lado do triângulo é sempre menor do
que a soma dos outros dois.
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	if (argc != 4) {
		printf("Usage: %s n1 n2 n3\n", argv[0]);
		return 1;
	}

	int n1 = atoi(argv[1]);
	int n2 = atoi(argv[2]);
	int n3 = atoi(argv[3]);

	if (n1 + n2 < n3 || n1 + n3 < n2 || n2 + n3 < n1) {
		printf("Nao eh triangulo\n");
	}
	else if (n1 == n2 && n2 == n3){
		printf("Eh triangulo equilatero\n");
	}
	else if (n1 == n2 || n1 == n3 || n2 == n3) {
		printf("Eh triangulo isosceles\n");
	}
	else {
		printf("Eh triangulo escaleno\n");
	}

	putchar('\n');	

	return 0;
}
