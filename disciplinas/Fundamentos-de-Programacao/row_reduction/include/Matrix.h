#ifndef MATRIX_H
#define MATRIX_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* Os indices comecao do '0' */

typedef struct {
	unsigned rows;
	unsigned cols;
	double *elements;
} Matrix_t;

/* Allocate and free memory */
Matrix_t *newMatrix (unsigned M, unsigned N);
void clearMatrix (Matrix_t *mat);

/* Easy element access */
void setElement (Matrix_t *mat, unsigned i, unsigned j, double val);
double getElement (Matrix_t *mat, unsigned i, unsigned j);

/* Formatted print */
void putm(Matrix_t *mat);

#endif /* MATRIX_H */
