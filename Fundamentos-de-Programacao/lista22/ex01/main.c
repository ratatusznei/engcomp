/*
	Por: Fernando H. Ratusznei Caetano

 1. Crie um tipo para representar um mês. O tipo deve ter campos para
 armazenar o número do mês, um nome abreviado de 3 letras, e o número
 de dias. Monte um programa que preenche um vetor do tipo criado com
 12 posições, uma para cada mês do ano. O programa deve então receber
 como entrada o número de um mês, e mostrar na saída o nome abreviado
 e o número de dias daquele mês. Considere que Fevereiro tem 28 dias.

*/

#include <stdio.h>
#include <stdlib.h>

typedef struct {
	char nome[4];
	int dias;
} Mes_t;

int main (int argc, char *argv[]) {
	Mes_t meses[12];

	int dias[] = {31, 28, 31, 30, 31, 30, 31,
		31, 30, 31, 30, 31};

	char nomes[12][3] = {
		"jan", "fev", "mar", "abr", "mai", "jun",
		"jul", "ago", "set", "out", "nov", "dez"
	};

	int i;

	for (i = 0; i < 12; i++) {
		meses[i].nome[0] = nomes[i][0];
		meses[i].nome[1] = nomes[i][1];
		meses[i].nome[2] = nomes[i][2];
		meses[i].nome[3] = '\0';

		meses[i].dias = dias[i];
	}

	printf("Selecione o numero de um mes:  ");
	scanf("%d", &i);

	i--;

	if (i >= 0 && i <= 12) {
		printf("%s, %d dias\n\n", meses[i].nome, meses[i].dias);
	}

	return 0;
}

