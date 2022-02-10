#include <stdio.h>

#include "Matrix.h"
#include "RowOperations.h"

int main () {
	unsigned M;
	unsigned N;
        Matrix_t *mat;

        unsigned i;
        unsigned j;
        unsigned k;
        unsigned lastNotNullRow = -1;

	/* Le os parametros da matriz */
	scanf("%u %u", &M, &N);
	mat = newMatrix(M, N);
        
        if (!mat) {
                fprintf(stderr, "Could not allocate matrix\n");
                return 1;
        }

        for (i = 0; i < M; i++) {
                for (j = 0; j < N; j++) {
			double aux;
			scanf("%lf", &aux);
                        setElement(mat, i, j, aux);
                }
        }

        /* Acha ultima linha nao nula */
        for (i = M - 1; i >= 0 && lastNotNullRow == -1; i--) {
                for (j = 0; j < N && lastNotNullRow == -1; j++) {
                        if (getElement(mat, i, j) != 0) {
                                lastNotNullRow = i;
                        }
                }
        }

        for (i = 0; i < mat->rows; i++) {
	        double pivo;
	        unsigned pivo_pos;
	        unsigned last_pivo_pos;

                /* 1. Se Li nulo trocar com ultima linha nao nula */
                if (isNullRow(mat, i)) {
                        swapRows(mat, i, lastNotNullRow--);
                }

                /* 2. Se pivo != 1, dividir linha pelo pivo */
                pivo_pos = getPivo(mat, i, &pivo);
		if (pivo_pos == -1) {
			// As proximas operacoes precisao do pivo
			continue;
		}
                if (pivo != 1.0) {
                        multiplyRow(mat, i, 1 / pivo);
                }

                /* 3. Se o pivo nao esta a direita do pivo de cima */
                /*    Mandar essa linha Li pra cima até dar certo */
                j = i;
		while (j > 0) {
                        last_pivo_pos = getPivo(mat, j - 1, NULL);

			if (last_pivo_pos > pivo_pos) {
				swapRows(mat, j, j - 1);
				j--;
			}
			else {
				break;
			}
		}
                // O indice da linha vai estar em j depois disso ^

                /* 4. Zerar os outros elementos da mesma coluna do pivo */
                for (k = 0; k < M; k++) {
                        if (getElement(mat, k, pivo_pos) == 0 || k == j) {
                                continue;
                        }

			/* Lk -> Lk - ak[pivopos] * Lj */
                        addRows(mat, k, j, -getElement(mat, k, pivo_pos));
                }
        }

	printf("%d %d\n", mat->rows, mat->cols);
        putm(mat);

        clearMatrix(mat);
        return 0;
}

