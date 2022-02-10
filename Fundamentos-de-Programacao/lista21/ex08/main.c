/*
	Por: Fernando H. Ratusznei Caetano

 8. Jogo: Cacador de esmeraldas. Deveria ter usado struct.

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ESMERALD_COLOR "\x001B[32m"
#define PLAYER_COLOR "\x001B[33m"
#define CLEAR_COLOR "\x001B[0m"

#define N_ARGS 3
#define USAGE "Usage: %s <largura> <altura> <n esmeraldas>\n\n"

void printTabuleiro (char **tabuleiro, int length, int height,
	int player_i, int player_j);

void geraTabuleiro (char * **tabuleiro, int *player_i, int *player_j,
	int length, int height, int n_esmeraldas);

void movePlayer (char **tabuleiro, int *player_i, int *player_j, char dir,
	int length, int height, int *esmeraldas);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int length = atoi(argv[1]);
	int height = atoi(argv[2]);
	int n_esmeraldas = atoi(argv[3]);

	char **tabuleiro = NULL;

	int player_i = 0;
	int player_j = 0;
	int esmeraldas = 0;

	int movimentos = 0;
	int melhor_movimentos = -1;

	int quit = 0;
	char choice = '\0';

	while (!quit) {
		geraTabuleiro(&tabuleiro, &player_i, &player_j,
			length, height, n_esmeraldas);

		while (esmeraldas < n_esmeraldas && !quit) {
			printTabuleiro(tabuleiro, length, height,
				player_i, player_j);

			printf("Controles: wasd (movimento) q (sair)\n");
			printf("Esmeraldas:  %d / %d\n",
				esmeraldas, n_esmeraldas);
			printf("Movimentos:  %d\n", movimentos);

			if (melhor_movimentos != -1) {
				printf("Melhor jogada:  %d\n",
					melhor_movimentos);
			}

			do { 
				choice = getchar();
			} while (choice == '\n');

			if (choice == 'q') {
				quit = 1;
				continue;
			}

			movePlayer(tabuleiro, &player_i, &player_j, choice,
				length, height, &esmeraldas);

			movimentos++;
		}

		if ((movimentos < melhor_movimentos 
			|| melhor_movimentos == -1)
			&& movimentos > 0) {

			melhor_movimentos = movimentos;
		}

		system("clear");
		printf("Voce fez %d movimentos! Parabens!\n", movimentos);

		if (melhor_movimentos > 0) {
			printf("Melhor jogada:  %d\n", melhor_movimentos);
		}

		printf("\nJogar novamente? (q para sair)\n");
		/* \n */
		getchar();
		choice = getchar();

		if (choice == 'q') {
			quit = 1;
		}
		else {
			esmeraldas = 0;
			movimentos = 0;
		}
	}

	return 0;
}

void printTabuleiro (char **tabuleiro, int length, int height,
	int player_i, int player_j ) {

	int i;
	int j;

	system("clear");

	for (i = 0; i < height; i++) {
		for (j = 0; j < 4 * length + 1; j++) {
			putchar('-');
		}

		putchar('\n');

		for (j = 0; j < length; j++) {
			char c = tabuleiro[i][j];

			printf("\b| ");

			if (i == player_i && j == player_j) {
				printf(PLAYER_COLOR);
				putchar('*');
				printf(CLEAR_COLOR);
			}
			else if (c == ' ') {
				putchar(c);
			}
			else {
				printf(ESMERALD_COLOR);
				printf("%c", c);
				printf(CLEAR_COLOR);
			}

			printf(" |");
		}

		putchar('\n');
	}

	for (j = 0; j < 4 * length + 1; j++) {
		putchar('-');
	}

	putchar('\n');
}

void geraTabuleiro (char * **tabuleiro, int *player_i, int *player_j,
	int length, int height, int n_esmeraldas) {

	int i;
	int j;

	srand(clock());

	*tabuleiro = (char **) malloc(height * sizeof(char *));
	for (i = 0; i < height; i++) {
		(*tabuleiro)[i] = (char *) malloc(length * sizeof(char));
	}

	/* Limpa o tabuleiro */
	for (i = 0; i < height; i++) {
		for (j = 0; j < length; j++) {
			(*tabuleiro)[i][j] = ' ';
		}
	}

	/* Posiciona as esmeraldas */
	i = 0;
	while(i < n_esmeraldas) {
		char *quadradinho = 
			&((*tabuleiro)[rand() % height][rand() % length]);

		if (*quadradinho == ' ') {
			*quadradinho = '1';
			i++;
		}
		else {
			*quadradinho += 1;
			i++;
		}
	}

	/* Posiciona o jogador */
	do {
		*player_i = rand() % height;
		*player_j = rand() % length;
	} while ((*tabuleiro)[*player_i][*player_j] != ' ');
}

void movePlayer (char **tabuleiro, int *player_i, int *player_j, char dir,
	int length, int height,	int *esmeraldas) {

	char *c;

	/* Move o jogador */
	switch (dir) {
	case 'w': case 'W':
		if (*player_i > 0) {
			(*player_i)--;
		}
		break;

	case 's': case 'S':
		if (*player_i < height) {
			(*player_i)++;
		}
		break;

	case 'a': case 'A':
		if (*player_j > 0) {
			(*player_j)--;
		}
		break;

	case 'd': case 'D':
		if (*player_j < length) {
			(*player_j)++;
		}
	}

	/* Pega esmeraldas na posica do jogador */
	c = &tabuleiro[*player_i][*player_j];
	if (*c != ' ') {
		*esmeraldas += *c - '0';
		*c = ' ';
	}
}

