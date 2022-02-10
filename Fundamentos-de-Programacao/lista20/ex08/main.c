/*
	Por: Fernando H. Ratusznei Caetano

 8. Escreva um programa que recebe uma solução de um quebra-cabeça como
 uma matriz de 9x9 inteiros. O programa deve dizer se a matriz contém uma
 solução válida de acordo com as regras do Sudoku.

*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	int resposta_sudoku [9][9] =
		{{1, 2, 3, 4, 5, 8, 6, 7, 9},
		{4, 8, 6, 7, 2, 9, 1, 3, 5},
		{5, 7, 9, 1, 3, 6, 2, 8, 4},
		{2, 3, 4, 5, 6, 7, 8, 9, 1},
		{6, 5, 1, 8, 9, 2, 3, 4, 7},
		{8, 9, 7, 3, 1, 4, 5, 2, 6},
		{3, 4, 2, 6, 7, 1, 9, 5, 8},
		{9, 1, 8, 2, 4, 5, 7, 6, 3},
		{7, 6, 5, 9, 8, 3, 4, 1, 2}};

	int is_solution = 1;

	int i;
	int j;

	int freq[11] = { 0 };

	/* Checa linhas */
	for (i = 0; i < 9 && is_solution; i++) {
		for (j = 0; j < 9 && is_solution; j++) {
			int n = resposta_sudoku[i][j];

			if (freq[n]) {
				is_solution = 0;
				break;
			}

			freq[n] = 1;
		}

		for (j = 0; j < 10; j++) {
			freq[j] = 0;
		}
	}

	/* Checa colunas */
	for (i = 0; i < 9 && is_solution; i++) {
		for (j = 0; j < 9 && is_solution; j++) {
			int n = resposta_sudoku[j][i];

			if (freq[n]) {
				is_solution = 0;
			}

			freq[n] = 1;
		}

		for (j = 0; j < 10; j++) {
			freq[j] = 0;
		}
	}

	/* Checa quadradinhos 3x3 */
	for (i = 0; i < 9 && is_solution; i += 3) {
		for (j = 0; j < 9 && is_solution; j += 3) {
			int k;

			for (k = 0; k < 9; k++) {
				int a = k / 3;
				int b = k % 3;

				int n = resposta_sudoku[a][b];

				if (freq[n] == 1) {
					is_solution = 0;
					break;
				}

				freq[n] = 1;
			}

			for (k = 0; k < 10; k++) {
				freq[k] = 0;
			}
		}
	}

	printf("%s", is_solution? "Eh solucao\n": "Nao eh solucao\n");

	return 0;
}

