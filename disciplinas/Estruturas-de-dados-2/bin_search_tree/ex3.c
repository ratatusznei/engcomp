/*
 * Por Fernando H. R. Caetano
 *
 * Existe uma diferença de tempo considerável entre a inserção em ordem
 * e a inserção de elementos aleatória
 *
 * Isso acontece pois ao inserir itens de em ordem crescente na árvore
 * eles são sempre inseridos como um filho à direita. Isso resulta em
 * uma árvore com a mesma estrutura de uma linta linkada, que possui
 * busca de complexidade linear.
 * Já na inserção aleatória a árvore é melhor balanceada, possibilitando
 * a busca binária de complexidade log. de base 2.
 *
 * Saida usando N = 100.000, tempo de execução 2min e 7.63s:
   $ gcc ex3.c && time ./a.out
   Achou: NAO
   ./a.out  127.60s user 0.02s system 99% cpu 2:07.63 total
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
		a = inserir(a, i);
	}

	i = buscar(a, N);
	printf("Achou: %s\n",
		i? "SIM": "NAO"
	);
	return 0;
}
