#include "Matrix.h"

Matrix_t *newMatrix (unsigned rows, unsigned cols) {
	Matrix_t *mat = (Matrix_t *) malloc(sizeof(Matrix_t));
	if (!mat) {
		return NULL;
	}

	mat->rows = rows;
	mat->cols = cols;
	
	mat->elements = (double *) malloc(rows * cols * sizeof(double));
	if (!(mat->elements)) {
		return NULL;
	}

	int i;
	for (i = 0; i < rows * cols; i++) {
		mat->elements[i] = 0;
	}

	return mat;
}

void clearMatrix(Matrix_t *mat) {
	free(mat->elements);
	free(mat);
}

void setElement(Matrix_t *mat, unsigned i, unsigned j, double val) {
	if (i >= mat->rows || j >= mat->cols) {
		fprintf(stderr, "Matrix error: index out of range\n");
		return;
	}

	mat->elements[i * mat->cols + j] = val;
}

double getElement(Matrix_t *mat, unsigned i, unsigned j) {
	if (i >= mat->rows || j >= mat->cols) {
		fprintf(stderr, "Matrix error: index out of range\n");
		return NAN;
	}

	return mat->elements[i * mat->cols + j];
}

void putm(Matrix_t *mat) {
	int i;
	int j;
	double aux;
	double diff;
	for (i = 0; i < mat->rows; i++) {
		for (j = 0; j < mat->cols; j++) {
			aux = getElement(mat, i, j);

			if (aux > 0) {
				diff = aux - (int) (aux + 0.5);
			}
			else {
				diff = aux + (int) (aux + 0.5);
			}
			if (diff < 0) {
				diff = -diff;
			}

			if (diff < 1e-6) {
				printf("% d ", (int) (aux + 0.5));
			}
			else {
				printf("% lf ", aux == 0? 0: aux);
			}
		}

		putchar('\n');
	}
}

