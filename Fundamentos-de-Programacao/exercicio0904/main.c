/*
	Por: Fernando H. Ratusznei Caetano
	
	Busca binaria
*/

#include <stdio.h>
#include <stdlib.h>

#define MIN (0)
#define MAX ((int) 1e6)

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	printf("Diga se maior (>), menor (<) ou igual (=)\n");	

	char choice = 0;
	
	int guess;
	unsigned n_guess = 0;

	int lower_guess = MIN;
	int upper_guess = MAX;

	while (choice != '=') {
		guess = (lower_guess + upper_guess) / 2;
		printf("Chute: %d ", guess);
		scanf(" %c", &choice);

		if (choice == '>') {
			lower_guess = guess;
			n_guess++;
		}
		else if (choice == '<') {
			n_guess++;
			upper_guess = guess;
		}
		else if (choice == '=') {
			break;
		}
		else {
			printf("Resposta invalida!\n");
		}
	}

	printf("\nO numero eh: %d\nNum tentativas: %u\n\n", guess, n_guess);

	return 0;
}

