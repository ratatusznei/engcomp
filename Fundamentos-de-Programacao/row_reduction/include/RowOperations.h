#ifndef ROW_OPERATIONS_H
#define ROW_OPERATIONS_H

#include "Matrix.h"

/* Type 1 elementary row op: Swap the positions of two rows */
void swapRows(Matrix_t *mat, unsigned row1, unsigned row2);

/* Type 2 elementary row op: Multiply a row by a nonzero scalar */
void multiplyRow(Matrix_t *mat, unsigned row, double scalar);

/* Type 3 elementary row op: Add to one row a scalar multiple of another */
void addRows (Matrix_t *mat, unsigned dest, unsigned source, double scalar);

/* Non elementary row operations */
char isNullRow (Matrix_t *mat, unsigned row);
unsigned getPivo (Matrix_t *mat, unsigned row, double *pivo);

#endif /* ROW_OPERATIONS_H */

