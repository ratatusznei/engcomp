/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva uma função que recebe uma string e mostra o número de
 ocorrências de cada letra nela. A contagem não deve fazer diferenciação
 entre maiúsculas e minúsculas, então a string “A vida eh assim” tem 3
 ocorrências da letra a.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 1
#define USAGE "Usage: %s <string>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	char *str = argv[1];
	int freq['z' - 'a' + 1] = { 0 };
	int i = 0;

	while (str[i] != '\0') {
		if (str[i] >= 'a' && str[i] <= 'z') {
			freq[str[i] - 'a']++;
		}
		else if (str[i] >= 'A' && str[i] <= 'Z') {
			freq[str[i] - 'A']++;
		}

		i++;
	}

	for (i = 0; i < 'z' - 'a' + 1; i++) {
		if (freq[i] != 0) {
			printf("%c: %d\n", i + 'A', freq[i]);
		}
	}

	putchar('\n');

	return 0;
}
