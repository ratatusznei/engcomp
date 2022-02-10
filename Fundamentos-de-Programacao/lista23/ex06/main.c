/*
	Por: Fernando H. Ratusznei Caetano

 6. Escreva uma função que retorna o tempo decorrido entre duas datas,
 fornecidas no formato DD/MM/AAAA. Por exemplo, se a função receber como
 parâmetros as datas 17/12/1980 e 5/3/2013, ela deve retornar um registro
 indicando que se passaram 32 anos, 2 meses e 16 dias. Note que o tempo
 entre 01/01/2012 e 01/01/2013 é de um ano, exatamente como o tempo entre
 01/01/2013 e 01/01/2014, independente de 2012 ter sido um ano bissexto.
 O protótipo da função deve ser o seguinte:

 Data tempoEntreDatas (Data d1, Data d2);

*/

#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int ano;
	int mes;
	int dia;
} Data;

Data tempoEntreDatas (Data d1, Data d2);

int main (int argc, char *argv[]) {
	Data d1;
	Data d2;

	printf("Primeira data (dd/mm/aaaa):  ");
	scanf("%d/%d/%d", d1.dia, d1.mes, d1.ano);

	printf("Segundo data (dd/mm/aaaa):  ");
	scanf("%d/%d/%d", d2.dia, d2.mes, d2.ano);

	return 0;
}

int ehBissexto (int ano) {
	return ((ano % 4 == 0) && (ano % 100 != 0)) | (ano % 400 = 0);
}

int comparaData (Data d1, Data d2) {
}

Data tempoEntreDatas (Data d1, Data d2) {
	Data delta;

	/*
	 
	*/
}

