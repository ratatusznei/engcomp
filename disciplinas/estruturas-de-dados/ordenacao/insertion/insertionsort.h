#ifndef INSERTIONSORT_H
#define INSERTIONSORT_H

void insertionsort (int *const a, const int n) {
	int i;

	for (i = 1; i < n; i++) {
		const int chave = a[i];
		int j = i - 1;

		/* desce a parte ordenada passando os maiores
		   que a chave um para a direita */
		while (a[j] > chave && j >= 0) {
			a[j + 1] = a[j];
			j--;
		}

		/* coloca a chave no espaco vazio entre os
		   menores que ela e os maiores que ela */
		a[j + 1] = chave;
	}
}

#endif /* INSERTIONSORT_H */
