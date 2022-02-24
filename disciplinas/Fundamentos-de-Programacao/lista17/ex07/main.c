/*
	Por: Fernando H. Ratusznei Caetano

 7. Um problema recorrente em aplicações como editores de texto ei
 compiladores é obalanceamento de parênteses: dada uma string, precisamos
 apontar as correspondências entre oscaracteres '(' e ')' encontrados.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s \"str\"\n\n"

void balanceamentoDeParenteses (char* str, int* parenteses);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int parenteses[20];
	int i = 0;

	balanceamentoDeParenteses(argv[1], parenteses);

	while (argv[1][i] != '\0') {
		printf("%2d ", parenteses[i]);
		i++;
	}

	printf("\n\n");

	return 0;
}

void balanceamentoDeParenteses (char* str, int* parenteses) {
	int *stack;
	int sp = 0;

	int size = 0;
	int i;
	
	while (str[size] != '\0') {
		size++;
	}

	stack = malloc (size * sizeof (int));

	for (i = 0; i < size; i++) {
		if (str[i] == '(') {
			stack[sp++] = i;
			parenteses[i] = -1;
		}
		else if (str[i] == ')') {
			if (sp != 0) {
				parenteses[i] = stack[--sp];
				parenteses[stack[sp]] = i;
			}
			else {
				parenteses[i] = -1;
			}
		}
		else {
			parenteses[i] = 0;
		}
	}
}

