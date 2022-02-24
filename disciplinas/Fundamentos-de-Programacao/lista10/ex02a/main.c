/*
	Por: Fernando H. Ratusznei Caetano

 2. Em 1937, o matemático Lothar Collatz propôs a seguinte conjetura, ainda não
 provada: dado um número natural arbitrário a 0, a sequência gerada por:

 ai = a(i-1) / 2, se a(i-1) par
 ai = 3 * a(i-1) + 1, se a(i-1) impar

 representam o último elemento produzido para a sequência e o próximo valor a
 ser gerado, respectivamente, sempre chegará ao valor 1, independente do valor
 inicial escolhido para a 0

 Por exemplo, a sequência de Collatz para 
    a0 = 7 é: 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2 e 1.

 Escreva um programa que leia o primeiro elemento de uma sequência de Collatz e
 imprima na tela a sequência a partir do elemento dado, até que se alcance o
 valor 1. O programa deve também mostrar o número de elementos da sequência
 gerada. Se o programa receber o valor 7, por exemplo, deve mostrar os 17
 elementos listados acima, e dizer que gerou 17 elementos.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <a0>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	return 0;
}
