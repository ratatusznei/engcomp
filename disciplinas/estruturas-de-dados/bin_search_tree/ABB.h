#ifndef ABB_H
#define ABB_H

typedef struct arvore {
	int info;
	struct arvore* esq;
	struct arvore* dir;
} Arvore;

void imprimir_in_order (Arvore* a);
void imprime_decrescente (Arvore* a);

Arvore* inserir (Arvore* a, int i);
int buscar (Arvore* a, int i);
Arvore* remover (Arvore* a, int i);

int min (Arvore* a);
int max (Arvore* a);

int maior_ramo (Arvore* a);
int ancestral (Arvore* a, int e1, int e2);

#endif /* ABB_H */
