/*
	Por: Fernando H. Ratusznei Caetano

 3. Escreva uma função char* empacotaString (char* string), que recebe
 como parâmetro um buffer contendo uma string e retorna uma cópia da
 string, mas em um espaço que tem apenas o tamanho necessário.A nova string
 deve ser alocada dentro da função, mas a responsabilidade de desalocá-la
 é do chamador.

*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

char* empacotaString (char* string);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	char s1[10] = "45|)4";
	char *s2 = empacotaString(s1);

	puts(s2);

	free(s2);
	return 0;
}

char* empacotaString (char* string) {
	int size = 1;
	char *s2;
	
	while (string[size - 1]) {
		size++;
	}

	s2 = malloc(size * sizeof(char));
	
	memcpy(s2, string, size - 1);
	s2[size - 1] = '\0';

	return s2;
}
