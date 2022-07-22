/*
	Por: Fernando H. Ratusznei Caetano

 1. O número 3025 possui a seguinte característica: 
  30 + 25 = 55; 55 * 55 = 3025.

 Escreva um programa para obter todos os números de 4 algarismos com a mesma
 característica do número 3025.

*/

#include <stdio.h>

int main (int argc, char *argv[]) {
	/*
		n = numero de 4 algarismos que nem o num 3025

		n quadrado perfeito
			maior e menor quadrado perfeito no intervalo [1000, 9999]
				32 * 32 = 1024
				99 * 99 = 9801	
	*/

	unsigned raiz;
	unsigned candidato;
	unsigned soma;


	/* Verificar os numeros canditados com as raizes no intervalo [32, 99] */
	for (raiz = 32; raiz <= 99; raiz++) {
		candidato = raiz * raiz;
		soma = candidato / 100 + candidato % 100;

		if (soma == raiz) {
			printf("%d\n", candidato);
		}
	}
	
	putchar('\n');

	return 0;
}
