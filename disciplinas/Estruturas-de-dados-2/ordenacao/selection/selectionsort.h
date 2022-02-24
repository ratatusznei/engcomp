#ifndef SELECTIONSORT_H
#define SELECTIONSORT_H

void selectionsort (int *const a, const int n) {
	const int nm1 = n - 1;

	int menor_i;
	int i;

	for (i = 0; i < nm1; i++) {
		menor_i = i;

		/* acha o menor ainda não ordenado */
		int j;
		for (j = i + 1; j < n; j++) {
			if (a[j] < a[menor_i]) menor_i = j;
		}

		/* troca com o 1o apos a parte ordenada */
		int x = a[menor_i];
		a[menor_i] = a[i];
		a[i] = x;
	}
}

#endif /* SELECTIONSORT_H */
