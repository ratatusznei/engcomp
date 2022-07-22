/*
	Por: Fernando H. Ratusznei Caetano

 7. Escreva um programa que lê um inteiro positivo e um dígito. O programa
 deve verificar se o número dado contém o dígito em qualquer posição. Não
 é preciso dizer qual a posição, apenas indicar se o dígito está ou não
 presente.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 2
#define USAGE "Usage: %s <numero> <digito>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int n = atoi(argv[1]);
	int d = atoi(argv[2]);

	/*
		abc -> c eh o digito?
		 ab -> b eh o digito?
		  a -> a eh o digito?
        	  0 -> acabou
	*/

	while (n > 0) {
		if (n % 10 == d) {
			break;
		}

		n /= 10;
	}	


	/*
		Se saiu do loop antes n != 0:
            p1 = [n != 0]
        Se o digito eh 0, ele saiu antes (n != 0): 
            p2 = [d == 0]
            
            p1 + p1*p2
            p1 * (1 + p2)
            p1 * 1
            p1
   	*/
	if (n != 0) {
		printf("Achou!! :D\n\n");
	}
	else {
		printf("Nao achou!! D:\n\n");
	}

	return 0;
}
