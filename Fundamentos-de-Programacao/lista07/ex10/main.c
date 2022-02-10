/*
	Por: Fernando H. Ratusznei Caetano

 10. O PIB (Produto Interno Bruto) anual de um país é a soma do valor de
 todos os bens e serviços finais produzidos pelo país durante um ano. Ele é
 um dos indicadores mais usados para avaliar o “tamanho” da economia de um
 país. Outro fator importante é o crescimento do PIB, ou seja, o quanto a
 economia “cresceu” de um ano para o outro. 

 Por exemplo, em 2012, o PIB dos EUA (o maior do mundo) foi de US$ 15.7
 trilhões e da China (o segundo maior) foi de US$ 8.2 trilhões. O 
 crescimento do PIB dos EUA foi de 2.2%, enquanto o da China foi de 7.8%.
 Se as taxas de crescimento permanecessem iguais indefinidamente, em 2013
 os PIBs dos EUA e da China seriam, respectivamente, US$ 16.05 e 8.84
 trilhões. Em 2014, os valores iriam para US$ 16.4 e 9.53 trilhões. Com
 este crescimento linear, em 13 anos, a China superaria os EUA como a
 maior economia do mundo! 

 Escreva um programa que recebe como entradas os PIBs (em trilhões de
 dólares) e as taxas de crescimento anuais (em %) de dois países, e mostre
 quantos anos serão necessários para que o PIB do segundo país supere o do
 primeiro, ou um aviso se isso nunca ocorrer. O programa deve partir do
 pressuposto (absurdo) que as taxas de crescimento de cada país permanecerão
 as mesmas indefinidamente.

 @params:
	PIB1, taxa de crescimento 1,
	PIB2, taxa de crescimento 2

 @return:
	Quanto tempo em anos para PIB2 > PIB1

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 4
#define USAGE "Usage: %s <PIB1triU$$> <taxa1%%> <PIB2triU$$> <taxa2%%>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	double pib1 = atof(argv[1]);
	double taxa1 = atof(argv[2]) / 100 + 1;

	double pib2 = atof(argv[3]);
	double taxa2 = atof(argv[4]) / 100 + 1;

	int t = 0;

        /* 
	    pib2 supera pib1 <=> 
	    taxa2 > taxa1 ou se (pib2 > pib1 no inicio)
	*/

	if (pib2 >= pib1) {
		printf("PIB 2 ja eh maior que PIB1\n\n");
	}
	else if (taxa2 > taxa1) {
		while (pib2 < pib1) {
			pib1 *= taxa1;
			pib2 *= taxa2;

			t++;
		}

		printf("PIB 2 superara PIB 1 em %d anos\n\n", t);
	}
	else {
		printf("PIB 2 nuca superara PIB1!!\n\n");
	}

	return 0;
}

