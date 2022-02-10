/*
	Por: Fernando H. Ratusznei Caetano

 9. Zeca está organizando um bolão de futebol. Segundo suas regras, os
 apostadores informam o placar do jogo e ganham 10 pontos se acertarem o
 vencedor ou se foi empate, e ganham mais 5 pontos para o placar de cada
 time que acertarem.

 Escreva um programa que requisita do usuário o placar apostado e depois o
 placar do jogo e informa quantos pontos o apostador fez.

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 2 
#define USAGE "Usage: %s <placar apostado AxB> <placar do jogo AxB>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}
	
	int aposta_time1;
	int aposta_time2;
	int placar_time1;
	int placar_time2;

	int pontos = 0;

	sscanf(argv[1], "%dx%d", &aposta_time1, &aposta_time2);
	sscanf(argv[2], "%dx%d", &placar_time1, &placar_time2);

	/* +5 pts para cada placar de time que acertar */
	if (aposta_time1 == placar_time1) {
		pontos += 5;
	}
	if (aposta_time2 == placar_time2) {
		pontos += 5;
	}

	/* +10 pts por acertar vencedor ou empate */
	char time1_vencedor = placar_time1 > placar_time2 && aposta_time1 > aposta_time2;
	char time2_vencedor = placar_time1 < placar_time2 && aposta_time1 < aposta_time2;
	char empate = placar_time1 == placar_time2 && aposta_time1 == aposta_time2;

	/* Se o chute (haha) acertou algum desses */
	if (time1_vencedor || time2_vencedor || empate) {
		pontos += 10;
	}

	printf("Pontuacao final:  %d\n\n", pontos);
	

	return 0;
}
