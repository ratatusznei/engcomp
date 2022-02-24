/*
 4. Escreva um programa que recebe os coeficientes a, b e c de uma equação 
 de 2o grau do tipo ax2+bx+c=0. Usando a fórmula de Bhaskara, o programa 
 deve determinar e apresentar as raizes da equação. Se a equação tiver uma 
 única raiz real, o programa deve apresentá-la uma única vez. Se não existir
 em raizes reais, o programa deve mostrar uma mensagem.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main (int argc, char *argv[]) {
	if (argc != 4) {
		fprintf(stderr, "Usage: %s <a> <b> <c>\n\n", argv[0]);
		return 1;
	}

	int a = atoi(argv[1]);
	int b = atoi(argv[2]);
	int c = atoi(argv[3]);

	double x;	
	double delta;

	/*
		x = -b +- sqrt(b*b - 4*a*c)
		    ----------------------
                            2*a
	*/

	delta = b*b - 4.0*a*c;

	if (delta < 0) {
		printf("Nao existem solucoes reais!!!\n\n");
	}
	else if (delta == 0) {
		x = -b / (2.0 * a); 
		printf("Uma solucao real:  %.2f\n\n", x);
	}
	else {
		/* Para nao calcular a raiz 2 vezes */
		delta = sqrt(delta);

		x = (-b + delta) / (2.0 * a);
		printf("Primeira solucao real:  %.2f\n", x);
		
		x = (-b - delta) / (2.0 * a);
		printf("Segunda solucao real:  %.2f\n\n", x);
	}

	return 0;
}
