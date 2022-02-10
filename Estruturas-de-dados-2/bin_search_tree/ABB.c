#include "ABB.h"
#include <stdio.h>
#include <stdlib.h>

// ERD
void imprimir_in_order (Arvore* a) {
	if (a != NULL) {
		imprimir_in_order(a->esq);
		printf("%d\n", a->info);
		imprimir_in_order(a->dir);
	}
}

// DRE?
void imprime_decrescente (Arvore* a) {
	if (a != NULL) {
		imprime_decrescente(a->dir);
		printf("%d\n", a->info);
		imprime_decrescente(a->esq);
	}
	
}

Arvore* inserir (Arvore* a, int i) {
	if (a == NULL) {
		a = (Arvore*) malloc(sizeof(Arvore));
		a->info = i;
		a->esq = NULL;
		a->dir = NULL;
	}
	else if (i < a->info) {
		a->esq = inserir(a->esq, i);
	}
	else if (i > a->info) {
		a->dir = inserir(a->dir, i);
	}

	return a;
}

int buscar (Arvore* a, int i) {
	if (a == NULL) {
		return 0;
	}
	else if (i < a->info) {
		return buscar(a->esq, i);
	}
	else if (i > a-> info) {
		return buscar(a->dir, i);
	}	
	else { // i == a->info
		return 1;
	}
}

Arvore* remover (Arvore* a, int i) {
	if (a == NULL) {
		return NULL;
	}
	else {
		if (i < a->info) {
			a->esq = remover(a->esq, i);
		}
		else if (i > a->info) {
			a->dir = remover(a->dir, i);
		}
		else { // i == a->info
			if (a->esq == NULL && a->dir == NULL) {
				free(a);
				a = NULL;
			}
			else if (a->dir == NULL) {
				Arvore* tmp = a;
				a = a->esq;
				free(tmp);
			}
			else if (a->esq == NULL) {
				Arvore* tmp = a;
				a = a->dir;
				free(tmp);
			}
			else {
				Arvore* tmp = a->esq;
				while (tmp->dir != NULL) {
					tmp = tmp->dir;
				}

				a->info = tmp->info; // a->info eh i aqui
				tmp->info = i;
				remover(a->esq, i);
			}
		}
	}

	return a;
}

int min (Arvore* a) {
	while (a->esq != NULL) {
		a = a->esq;
	}

	printf("min: %d\n", a->info);
	return a->info;
}

int max (Arvore* a) {
	while (a->dir != NULL) {
		a = a->dir;
	}

	printf("max: %d\n", a->info);
	return a->info;
}

int maior_ramo (Arvore* a) {
	if (a == NULL) {
		return 0;
	}
	else {
		int max_esq = maior_ramo(a->esq) + a->info;
		int max_dir = maior_ramo(a->dir) + a->info;

		if (max_esq > max_dir) {
			return max_esq;
		}
		else {
			return max_dir;
		}
	}
}

int ancestral (Arvore* a, int e1, int e2) {
	// O ancestral N é quando e1 > N.info > e2 ou a1 < N.info < e2
	if (a == NULL) {
		return 0;
	}
	else if (e1 < a->info && e2 < a->info) {
		return ancestral(a->esq, e1, e2);
	}
	else if (e1 > a->info && e2 > a->info) {
		return ancestral(a->dir, e1, e2);
	}
	else {
		// Quando N.info nao eh maior que ambos ou quando N.info nao eh menor que ambos
		return a->info;
	}
}
