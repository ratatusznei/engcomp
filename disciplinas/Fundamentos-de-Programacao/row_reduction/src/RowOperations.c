#include "RowOperations.h"

/* Type 1: Swap the positions of two rows */
void swapRows (Matrix_t *mat, unsigned row1, unsigned row2) {
	double temp;
	unsigned j;

	for (j = 0; j < mat->cols; j++) {
		temp = getElement(mat, row1, j);
		setElement(mat, row1, j, getElement(mat, row2, j));
		setElement(mat, row2, j, temp);
	}
}

/* Type 2: Multiply a row by a nonzero scalar */
void multiplyRow (Matrix_t *mat, unsigned row, double scalar) {
	int j;
	for (j = 0; j < mat->cols; j++) {
		setElement(mat, row, j, scalar * getElement(mat, row, j));
	}
}

/* Type 3: Add to one row a scalar multiple of another */
void addRows (Matrix_t *mat, unsigned dest, unsigned source, double scalar) {
	double temp;
	unsigned j;

	for (j = 0; j < mat->cols; j++)	{
		temp = getElement(mat, source, j) * scalar;
		temp += getElement(mat, dest, j);
		setElement(mat, dest, j, temp);
	}
}

/* Non elementary row operations */

char isNullRow(Matrix_t *mat, unsigned row) {
        int j = 0;
        for (j = 0; j < mat->cols; j++) {
                if (getElement(mat, row, j) != 0) {
                        return 0;
                }
        }

        return 1;
}

unsigned getPivo(Matrix_t *mat, unsigned row, double *pivo) {
        int j = 0;
        double el;

        for (j = 0; j < mat->cols; j++) {
                el = getElement(mat, row, j);
                if (el != 0) {
                        if (pivo) {
                                *pivo = el;
                        }

                        return j;
                }
        }

        return -1;
}

