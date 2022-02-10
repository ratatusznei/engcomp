/*
	Por: Fernando H. Ratusznei Caetano

 8. Escreva um programa que lê 3 strings digitadas pelo usuário.
 O programa deve imprimir as strings em seguida, uma abaixo da outra.
 O usuário pode então digitar uma nova string. A cada string nova digitada,
 o programa deve “rolar” as strings, descartando a mais antiga. Uma
 restrição é que você não pode copiar o conteúdo de um buffer para outro.
 O programa deve terminar quando o usuário digitar uma string sem caracteres

*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 80

int main (int argc, char *argv[]) {
	char *s1 = NULL;
	char *s2 = NULL;
	char *s3 = NULL;

	do {
		system("clear");
		if (s1) {
			printf("%s", s1);
			free(s1);
		}
		if (s2) {
			printf("%s", s2);
		}
		if (s3) {
			printf("%s", s3);
		}

		s1 = s2;
		s2 = s3;

		s3 = malloc(MAX_SIZE);
		fgets(s3, MAX_SIZE, stdin);
	} while (strcmp(s3, "\n") != 0);

	free(s1);
	free(s2);
	free(s3);

	return 0;
}

