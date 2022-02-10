#ifndef MERGESORT_H
#define MERGESORT_H

#include <stdlib.h>

void merge (int *a, int p, int q, int r) {
	int *buffer = malloc(sizeof(int) * (r - p + 1));
	int ib = 0;
	int i1 = p;
	int i2 = q;

	while (i1 < q && i2 < r) {
		if (a[i1] < a[i2]) {
			buffer[ib++] = a[i1++];
		}
		else {
			buffer[ib++] = a[i2++];
		}
	}

	while (i1 < q) {
		buffer[ib++] = a[i1++];
	}

	while (i2 < r) {
		buffer[ib++] = a[i2++];
	}

	for (ib = 0; ib < (r - p); ib++) {
		a[p + ib] = buffer[ib];
	}

	free(buffer);
}

void mergesort (int *a, int n) {
	if (n > 1) {
		int q = n / 2;
		mergesort(a + 0, q);
		mergesort(a + q, n - q);
		merge(a, 0, q, n);
	}
}

#endif /* MERGESORT_H */
