/*
	Trabalho 2 Fundamentos de programacao
	Professor: Bogdan T. Nassu

	Por: Fernando H. Ratusznei Caetano
	RA: 1607774
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "wavfile.h"
#include "trabalho2.h"

#define SIZE 20

int isEqual (double *v1, double *v2, int size);
void copy (double *dest, double *src, int size);

int main () {
	double dados[SIZE] = {
		0.4917,
		0.5101,
		0.7431,
		0.0179,
		0.2358,
		0.3397,
		0.1866,
		0.5740,
		0.0364,
		0.6743,
		0.3815,
		0.4888,
		0.0922,
		0.9211,
		0.0993,
		0.5235,
		0.9672,
		0.9956,
		0.6618,
		0.4295,
	};

	/* + 2 */
	double atraso1[SIZE] = {
		0,
		0,
		0.4917,
		0.5101,
		0.7431,
		0.0179,
		0.2358,
		0.3397,
		0.1866,
		0.5740,
		0.0364,
		0.6743,
		0.3815,
		0.4888,
		0.0922,
		0.9211,
		0.0993,
		0.5235,
		0.9672,
		0.9956,
	};

	/* - 2 */
	double atraso2[SIZE] = {
		0.7431,
		0.0179,
		0.2358,
		0.3397,
		0.1866,
		0.5740,
		0.0364,
		0.6743,
		0.3815,
		0.4888,
		0.0922,
		0.9211,
		0.0993,
		0.5235,
		0.9672,
		0.9956,
		0.6618,
		0.4295,
		0,
		0,
	};

	/* Janela = 5 */
	double filtrado[SIZE] = {
		0.4917,
		0.5101,
		0.39972,
		0.36932,
		0.30462,
		0.2708,
		0.2745,
		0.3622,
		0.37056,
		0.431,
		0.33464,
		0.51158,
		0.39658,
		0.42498,
		0.52066,
		0.70134,
		0.64948,
		0.71552,
		0.6618,
		0.4295,
	};

	double v1[SIZE];
	double v2[SIZE];
	int i;
	double d;

	srand(clock());

	/* Ganho */
	for (d = -50; d < 50; d += ((float) rand()) / RAND_MAX)  {
		copy(v1, dados, SIZE);
		mudaGanho(v1, SIZE, d);

		for (i = 0; i < SIZE; i++) {
			v2[i] = dados[i] * d;
		}

		if (!isEqual(v1, v2, SIZE)) {
			printf("Calculado - Teste - Indice\n");

			for (i = 0; i < SIZE; i++) {
				if (v1[i] != v2[i]) {
					printf("%lf - %lf - %d\n", v1[i], v2[i], i);
				}
			}
			printf("Erro ganho\n");
			return 1;
		}
	}

	printf("Ganho ok\n");

	/* Mistura */
	misturaDados(atraso1, atraso2, v1, SIZE);
	for (i = 0; i < SIZE; i++) {
		v2[i] = atraso2[i] + atraso1[i];
	}

	if (!isEqual(v1, v2, SIZE)) {
		printf("Calculado - Teste - Indice\n");

		for (i = 0; i < SIZE; i++) {
			if (v1[i] != v2[i]) {
				printf("%lf - %lf - %d\n", v1[i], v2[i], i);
			}
		}

		printf("Erro mistura\n");
		return 1;
	}

	printf("Mistura ok\n");

	/* Inverte */
	copy(v1, dados, SIZE);

	inverteSinal(v1, SIZE);

	for (i = 0; i < SIZE; i++) {
		v2[i] = dados[SIZE - i - 1];
	}

	if (!isEqual(v1, v2, SIZE)) {
		printf("Calculado - Teste - Indice\n");

		for (i = 0; i < SIZE; i++) {
			if (v1[i] != v2[i]) {
				printf("%lf - %lf - %d\n", v1[i], v2[i], i);
			}
		}

		printf("Inverte erro\n");
		return 1;
	}

	printf("Inverte ok\n");

	/* Atraso */
	copy(v1, dados, SIZE);
	atrasaSinal(v1, SIZE, +2);

	if (!isEqual(v1, atraso1, SIZE)) {
		printf("Calculado - Teste - Indice\n");

		for (i = 0; i < SIZE; i++) {
			if (v1[i] != atraso1[i]) {
				printf("%lf - %lf - %d\n", v1[i], atraso1[i], i);
			}
		}

		printf("Atraso erro +\n");
		return 1;
	}


	copy(v1, dados, SIZE);
	atrasaSinal(v1, SIZE, -2);

	if (!isEqual(v1, atraso2, SIZE)) {
		printf("Calculado - Teste - Indice\n");

		for (i = 0; i < SIZE; i++) {
			if (v1[i] != atraso2[i]) {
				printf("%lf - %lf - %d\n", v1[i], atraso2[i], i);
			}
		}

		printf("Atraso erro -\n");
		return 1;
	}

	printf("Atraso ok\n");

	/* Filtro */
	copy(v1, dados, SIZE);

	filtroDaMedia(v1, SIZE, 5);
	
	if (!isEqual(v1, filtrado, SIZE)) {
		printf("Calculado - Teste - Indice\n");

		for (i = 0; i < SIZE; i++) {
			if (v1[i] != filtrado[i]) {
				printf("%lf - %lf - %d\n", v1[i], filtrado[i], i);
			}
		}

		printf("Filtro erro\n");
		return 1;
	}

	printf("Filtro ok\n");	

	return 0;
}


int isEqual (double *v1, double *v2, int size) {
	int i;
	double d;

	for (i = 0; i < size; i++) {
		d = v1[i] - v2[i];
		d = d > 0? d: -d;

		if (d > 0.0000001) {
			return 0;
		}
	}

	return 1;
}

void copy (double *dest, double *src, int size) {
	int i;

	for (i = 0; i < size; i++) {
		dest[i] = src[i];
	}
}
