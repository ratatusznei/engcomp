#ifndef TESTE_H
#define TESTE_H

#include <stdio.h>
#include <stdlib.h>

#define ORDENADO    0
#define EMBARALHADO 1

#include "arrays.h"

int verifica_array (int *const a, const int n) {
	int i;
	for (i = 0; i < n - 1; i++) {
		if (a[i] > a[i+1]) {
			return EMBARALHADO;
		}
	}

	return ORDENADO;
}

void testa (
	char *const name,
	void (*const sort_strategy) (int *const, const int),
	int *const a,
	const int n
) {
	printf("%s ... ", name);
	fflush(stdout);

	sort_strategy(a, n);

	if (verifica_array(a, n) == EMBARALHADO) {
		fprintf(stderr, "Erro na a1\n");
		exit(1);
	}
	else {
		puts("OK");
	}
}

#endif /* TESTE_H */
