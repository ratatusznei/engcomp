/* 
10.	 Era uma vez o tolo herdeiro de uma grande fortuna, que procurava um 
	jardineiro para cuidar do seu jardim. Diante dos altos salários exigidos
	pelos candidatos, o milionário estava prestes a desistir, quando surge 
	um rapaz de aparência simplória com uma proposta diferente: o seu 
	pagamento seria de R$1,00 para o primeiro dia, e a cada novo dia de 
	trabalho, o pagamento do dia anterior seria dobrado. O milionário 
	rapidamente pensou: R$1,00 pelo primeiro dia, R$2,00 pelo segundo dia,
	R$4,00 pelo terceiro dia... R$7,00 por três dias de trabalho – uma 
	pechincha! Contrato assinado, o milionário passou a fazer mais e mais
	exigências, “esticando” o número de dias de trabalho, criando novas
	tarefas e se aproveitando – acreditava ele – do simplório rapaz.

	Após alguns dias, o milionário foi convocado por seu contador, que
	desesperado o avisou que o pagamento devido ao jardineiro já era maior
	do que o seu saldo bancário!!! 

	Escreva um programa que receba como entrada o valor da fortuna e 
	mostre na saída o número de dias para que a dívida supere a fortuna,
	assim como a dívida final. Por simplicidade,
	considere apenas dados do tipo int e não se preocupe com overflow.
	Também suponha que o valor da fortuna não muda.
*/


#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <fortuna>\n", argv[0]);
		return 1;
	}

	int fortuna = atoi(argv[1]);
	int dias = 0;
	int pagamentoDoDia = 1;
	int divida = 0;

	while (divida < fortuna) {
		divida += pagamentoDoDia;
		pagamentoDoDia *= 2;
		dias++;
	}

	printf("Fortuna:  R$%d.00\n", fortuna);
	printf("Divida:  R$%d.00\n", divida);
	printf("Dias de trabalho:  %d\n\n", dias);
	return 0;
}
