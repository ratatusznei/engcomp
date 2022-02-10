/*
	Por: Fernando H. Ratusznei Caetano

 4. Escreva um programa que aloca um vetor do tipo Horario (com campos
 para hora, minutos e segundos), com n_blocos posições. O valor de
 n_blocos deve ser fornecido pelo usuário. O programa deve dividir as
 24 horas de um dia em n_blocos blocos, atribuindo a cada posição do
 vetor o início de um bloco. O primeiro elemento terá sempre 0h0m0s.

*/

#include <stdio.h>
#include <stdlib.h>

#define SEGUNDOS_NO_DIA (24 * 60 * 60)

#define N_ARGS 1
#define USAGE "Usage: %s <n blocos>\n\n"

typedef struct {
	char hor;
	char min;
	char seg;
} Horario;

Horario *divideDia (int n_blocos);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	Horario *blocos;
	int i;

	int n_blocos = atoi(argv[1]);

	blocos = divideDia(n_blocos);

	for (i = 0; i < n_blocos; i++) {
		printf("%02d:%02d:%02d\n",
			blocos[i].hor, blocos[i].min, blocos[i].seg);
	}

	free(blocos);
	return 0;
}

Horario *divideDia (int n_blocos) {
	int delta_h;
	int delta_m;
	int delta_s;
	int i;

	Horario *blocos = (Horario *) malloc(n_blocos * sizeof(Horario));

	blocos[0].hor = 0;
	blocos[0].min = 0;
	blocos[0].seg = 0;

	delta_s = SEGUNDOS_NO_DIA / n_blocos;

	delta_m = delta_s / 60;
	delta_s %= 60;

	delta_h = delta_m / 60;
	delta_m %= 60;

	for (i = 1; i < n_blocos; i++) {
		blocos[i].seg = blocos[i - 1].seg + delta_s;
		blocos[i].min = blocos[i - 1].min + delta_m +
			blocos[i].seg / 60;
		blocos[i].hor = blocos[i - 1].hor + delta_h +
			blocos[i].min / 60;

		blocos[i].seg %= 60;
		blocos[i].min %= 60;
	}

	return blocos;
}

