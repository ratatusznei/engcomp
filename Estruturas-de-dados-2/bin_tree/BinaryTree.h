#ifndef _BINARYTREE
#define _BINARYTREE

typedef struct _arvore {
	char v;
	struct _arvore* esq;
	struct _arvore* dir;
} Arvore;

Arvore* cria_arv_vazia ();
Arvore* constroi_arv (char v, Arvore* e, Arvore* d);
void destroi_arv (Arvore *arv);

void percorreRED (Arvore* arvore, void (* onNode)(Arvore*));
void percorreERD (Arvore* arvore, void (* onNode)(Arvore*));
void percorreEDR (Arvore* arvore, void (* onNode)(Arvore*));

void printPreOrder (Arvore* arvore);
void printInOrder (Arvore* arvore);
void printPosOrder (Arvore* arvore);

void imprime_arv_marcadores (Arvore* a);
int pertence_arv (Arvore* a, char c);
int conta_nos (Arvore* a);
int calcula_altura_arvore (Arvore* a);
int conta_nos_folha (Arvore* a);

#endif /* _BINARYTREE */
