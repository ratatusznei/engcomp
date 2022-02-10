/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva um programa que recebe um número e mostra na tela o maior
 divisor do número dado(exceto o próprio número!). A entrada de dados deve
 ser feita por meio da função scanf. Procure realizar o menor número de
 comparações possível.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <numero>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int n = atoi(argv[1]);
	int max_divisor = n/2 + 1;
	
	/*
		Comeca em n/2
		Vai conferindo se eh divisivel ate 1
	*/

	while (max_divisor > 1) {
		if (n % max_divisor == 0) {
			break;
		}

		max_divisor--;
	}

	printf("Maior divisor:  %d\n\n", max_divisor);

	return 0;
}
