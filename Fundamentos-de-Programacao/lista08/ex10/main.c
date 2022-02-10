/*
	Por: Fernando H. Ratusznei Caetano

 10. A sequência de Fibonacci é uma sequência de números naturais na qual
 os primeiros termos são 0 e 1, e cada termo subsequente é a soma dos dois
 termos anteriores. Desta forma, o terceiro termo é 0+1=1, o quarto termo
 é 1+1=2, o quinto termo é 1+2=3, o sexto termo é 2+3=5 e assim por diante.
 
 Os 10 primeiros números da sequência são: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34

 Os números da sequência de Fibonacci são usados em certos algoritmos para
 codificação, compressão e ordenamento de dados. Eles também podem ser
 usados em computação gráfica, na geração de transições suaves de cores e
 de objetos com aspecto natural (por exemplo, em animações cinematográficas)

 Escreva um programa que mostra os n primeiros números de Fibonacci, com n
 dado pelo usuário. Pressuponha que n será sempre maior ou igual a 3, mas
 nunca grande o suficiente para causar overflow em variáveis do tipo int.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <n>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	/*
		fib (n + 1) = fib(n) + fib(n - 1)
		fib (n) = fib(n + 1) - fib(n - 1)
		
		fib_n = fib_n(0) + fib_nmenos1(0)

		fib_nmenos1 = fib_n - fib_nmenos1(0)
			= fib_n(0) + fib_nmenos1(0) - fib_nmenos1(0)
			= fib_n(0)
	*/
	
	long long fib_nmenos1 = 0;
	long long fib_n = 1;
	int max_n = atoi(argv[1]);
	int n;

	printf("0\n1\n");
 
	for (n = 0; n < max_n; n++) {
		fib_n = fib_n + fib_nmenos1;
		fib_nmenos1 = fib_n - fib_nmenos1;

		printf("%lld\n", fib_n);
	}	

	printf("\nA proporcao AUREA eh %lf\n\n", (double) (fib_n) / fib_nmenos1);

	return 0;
}

