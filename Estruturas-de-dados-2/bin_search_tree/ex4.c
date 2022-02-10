/*
 * Por Fernando H. R. Caetano
 *
 * Explicação no comentário do ex3.c
 *
 * Saida para N 100.000, tempo de execução 0.047s:
   $ gcc ex4.c && time ./a.out
   Achou: NAO
   ./a.out  0.04s user 0.00s system 99% cpu 0.047 total
*/

#include <stdio.h>
#include <stdlib.h>

#define N 100000

typedef struct arvore {
	int info;
	struct arvore *esq;
	struct arvore *dir;
} Arvore;

Arvore* cria_arvore_vazia (void) {
	return NULL;
}

void arvore_libera (Arvore* a) {
	if (a != NULL) {
		arvore_libera (a->esq);
		arvore_libera (a->dir);
		free(a);
	}
}


Arvore* inserir (Arvore *a, int v) {
	if (a == NULL) {
		a = (Arvore*) malloc(sizeof(Arvore));
		a->info = v;
		a->esq = NULL;
		a->dir = NULL;
	}
	else if (v < a->info) {
		a->esq = inserir(a->esq, v);
	}
	else if (v > a->info) {
		a->dir = inserir(a->dir, v);
	}

	return a;
}

Arvore* remover (Arvore *a, int v) {
        if (a == NULL) {
                return NULL;
        }
        else {
                if (v < a->info) {
                        a->esq = remover(a->esq, v);
                }
                else if (v > a->info) {
                        a->dir = remover(a->dir, v);
                }
                else { // v == a->info
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


                                a->info = tmp->info; // a->info eh v aqui
                                tmp->info = v;

                                a->esq = remover(a->esq, v);
                        }
                }
        }

	return a;
}


int buscar (Arvore *a, int v) {
        if (a == NULL) {
                return 0;
        }
        else if (v < a->info) {
                return buscar(a->esq, v);
        }
        else if (v > a-> info) {
                return buscar(a->dir, v);
        }
        else { // i == a->info
                return 1;
        }
}

int main () {
	int i;
	Arvore* a = NULL;

	for (i = 0; i < N; i++) {
		a = inserir(a, rand() % N);
	}

	i = buscar(a, N);
	printf("Achou: %s\n",
		i? "SIM": "NAO"
	);
	return 0;
}
