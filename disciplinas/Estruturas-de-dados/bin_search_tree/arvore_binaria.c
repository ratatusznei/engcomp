/*
 * Por Fernando H. R. Caetano
 */

#include <stdio.h>
#include <stdlib.h>

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


void pre_order (Arvore* a) {
	if (a != NULL) {
		printf("%d ", a->info);
		pre_order (a->esq);
		pre_order (a->dir);
	}
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
                printf("%d, ", a->info);
                imprime_decrescente(a->esq);
        }
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

int main () {
	int i;

	Arvore *a = cria_arvore_vazia ();

	a = inserir(a, 50);
	a = inserir(a, 30);
	a = inserir(a, 90);
	a = inserir(a, 20);
	a = inserir(a, 40);
	a = inserir(a, 95);
	a = inserir(a, 10);
	a = inserir(a, 35);
	a = inserir(a, 45);


	printf("1. Monta arvore: \n");
	pre_order(a);
	printf("\n\n");

	printf("1. Remove 20 da arvore: \n");
	a = remover(a, 20);
	pre_order(a);
	printf("\n\n");

	printf("1. Remove 40 da arvore: \n");
	a = remover(a, 40);
	pre_order(a);
	printf("\n\n");

	printf("1. Busca itens na arvore: \n");
	i = 10;
	printf("%d: %s\n", i, buscar(a, i)? "TEM": "NAO TEM");
	i = 20;
	printf("%d: %s\n", i, buscar(a, i)? "TEM": "NAO TEM");
	i = 40;
	printf("%d: %s\n", i, buscar(a, i)? "TEM": "NAO TEM");
	i = 43;
	printf("%d: %s\n", i, buscar(a, i)? "TEM": "NAO TEM");
	printf("\n");

	printf("2. Imprime min e max da arvore: \n");
	min(a);
	max(a);
	printf("\n");

	printf("5. Imprime arvore decrescente: \n");
	imprime_decrescente(a);
	printf("\n\n");

	printf("6. Imprime maior caminho (ramo) da arvore: \n");
	printf("Soma do maior ramo: %d\n", maior_ramo(a));
	printf("\n");

	printf("7. Retorna o ancestral de dois nos da arvore: \n");
	printf("Arvore atual:");
	pre_order(a);
	printf("\n  Ancestral de 10 e 45: %d\n", ancestral(a, 10, 45));

	return 0;
}
