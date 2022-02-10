#include <stdio.h>
#include "selectionsort.h"

int main () {
	#define N 20
	int a[N] = {
		9,   8,  7, 6, 15,  4,  3, 20,  2, 19,
		18, 17, 16, 5, 14, 13, 12, 11, 10,  1,
	};

	int i;

	printf("Embaralhado: ");
	for (i = 0; i < N; i++) {
		printf("%2d, ", a[i]);
	}
	puts("\b\b ");

	selectionsort(a, N);

	printf("Ordenado:    ");
	for (i = 0; i < N; i++) {
		printf("%2d, ", a[i]);
	}
	puts("\b\b ");

	return 0;
}
