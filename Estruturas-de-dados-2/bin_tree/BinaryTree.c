#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "BinaryTree.h"

Arvore* cria_arv_vazia () {
   return NULL;
}

void destroi_arv (Arvore *arv) {
   if (arv != NULL) {
      destroi_arv (arv->esq);
      destroi_arv (arv->dir);
      free(arv);
   }
}

Arvore* constroi_arv (char v, Arvore* e, Arvore* d) {
	Arvore* node = (Arvore*) malloc(sizeof(Arvore));
	node->v = v;
	node->esq = e;
	node->dir = d;
	return node;
}

void percorreRED (Arvore* arvore, void (* onNode)(Arvore*)) {
	if (arvore != NULL) {
		onNode(arvore);
		percorreRED(arvore->esq, onNode);
		percorreRED(arvore->dir, onNode);
	}
}

void percorreERD (Arvore* arvore, void (* onNode)(Arvore*)) {
	if (arvore != NULL) {
		percorreERD(arvore->esq, onNode);
		onNode(arvore);
		percorreERD(arvore->dir, onNode);
	}
}

void percorreEDR (Arvore* arvore, void (* onNode)(Arvore*)) {
	if (arvore != NULL) {
		percorreEDR(arvore->esq, onNode);
		percorreEDR(arvore->dir, onNode);
		onNode(arvore);
	}
}

static void printNodeValue (Arvore* node) {
	if (node != NULL) {
		printf("%c ", node->v);
	}
	else {
		printf("\nERR: Arvore nula\n");
	}
}

void printPreOrder (Arvore* arvore) {
	printf("Pre order: ");
	percorreRED(arvore, printNodeValue);
	putchar('\n');
}

void printInOrder (Arvore* arvore) {
	printf("In order:  ");
	percorreERD(arvore, printNodeValue);
	putchar('\n');
}

void printPosOrder (Arvore* arvore) {
	printf("Pos order: ");
	percorreEDR(arvore, printNodeValue);
	putchar('\n');
}

void imprime_arv_marcadores (Arvore* a) {
	if (a != NULL) {
		putchar('<');
		putchar(a->v);
		imprime_arv_marcadores(a->esq);
		imprime_arv_marcadores(a->dir);
		putchar('>');
	}
	else {
		printf("<>");
	}
}

int pertence_arv (Arvore* a, char c) {
	if (a == NULL) {
		return 0;
	}
	else if (a->v == c) {
		return 1;
	}

	return pertence_arv(a->esq, c) || pertence_arv(a->dir, c);
}

int conta_nos (Arvore* a) {
	if (a == NULL) {
		return 0;
	}
	else {
		return conta_nos(a->esq) + conta_nos(a->dir) + 1;
	}
}

int calcula_altura_arvore (Arvore* a) {
	if (a == NULL) {
		return -1;
	}
	else if (a->dir == NULL && a->esq == NULL) {
		return 0;
	}

	int he = calcula_altura_arvore(a->esq) + 1;
	int hd = calcula_altura_arvore(a->dir) + 1;

	if (he > hd) {
		return he;
	}
	else {
		return hd;
	}
}

int conta_nos_folha (Arvore* a) {
	if (a == NULL) {
		return 0;
	}
	else if (a->esq == NULL && a->dir == NULL) {
		return 1;
	}

	return conta_nos_folha(a->esq) + conta_nos_folha(a->dir);
}

int ex1 () {
	printf("---- Inicio Ex 1: Imprime percursos PreOrdem, InOrdem e PosOrdem\n");
	printf("Arvore de teste:\n"
	       "  +----a----+\n"  
	       "+-b-+     +-c-+\n"  
	       "    d     e   f\n");

	Arvore* arv = constroi_arv('a',
		constroi_arv('b',
			NULL,
			constroi_arv('d', NULL, NULL)
		),
		constroi_arv('c',
			constroi_arv('e', NULL, NULL),
			constroi_arv('f', NULL, NULL)
		)
	);

	printPreOrder(arv);
	printInOrder(arv);
	printPosOrder(arv);

	return 0;
}


int ex2 () {
	printf("---- Inicio Ex 2: Imprime arvore com marcadores <>\n");
	printf("Arvore de teste:\n"
	       "  +----a----+\n"  
	       "+-b-+     +-c-+\n"  
	       "    d     e   f\n");
	Arvore* arv = constroi_arv('a',
		constroi_arv('b',
			NULL,
			constroi_arv('d', NULL, NULL)
		),
		constroi_arv('c',
			constroi_arv('e', NULL, NULL),
			constroi_arv('f', NULL, NULL)
		)
	);

	imprime_arv_marcadores(arv);

	putchar('\n');
	return 0;
}


int ex3 () {
	printf("---- Inicio Ex 3: Verifica se o caractere ocorre na arvore\n");
	printf("Arvore de teste:\n"
	       "  +----a----+\n"  
	       "+-b-+     +-c-+\n"  
	       "    d     e   f\n");
	Arvore* arv = constroi_arv('a',
		constroi_arv('b',
			NULL,
			constroi_arv('d', NULL, NULL)
		),
		constroi_arv('c',
			constroi_arv('e', NULL, NULL),
			constroi_arv('f', NULL, NULL)
		)
	);

	char testes[] =	"abcdefghimn0156";
	int n = strlen(testes);
	int i;

	for (i = 0; i < n; i++) {
		printf(
			"Procura '%c': %s\n",
			testes[i],
			pertence_arv(arv, testes[i])? "TEM NA ARVORE": "NAO TEM"
		);
	}

	return 0;
}

int ex4 () {
	printf("---- Inicio Ex 4: Conta o numemro de nos em uma arvore\n");
	printf("Arvore de teste:\n"
	       "  +----a----+\n"  
	       "+-b-+     +-c-+\n"  
	       "    d     e   f\n");
	Arvore* arv = constroi_arv('a',
		constroi_arv('b',
			NULL,
			constroi_arv('d', NULL, NULL)
		),
		constroi_arv('c',
			constroi_arv('e', NULL, NULL),
			constroi_arv('f', NULL, NULL)
		)
	);

	int n = conta_nos(arv); 
	printf("Numero de nos: %d\n", n);
	return 0;
}

int ex5 () {
	printf("---- Inicio Ex 5: Calcula a altura da arvore\n");
	printf("Arvore de teste:\n"
	       "  +----a----+\n"  
	       "+-b-+     +-c-+\n"  
	       "    d     e   f\n");
	Arvore* arv = constroi_arv('a',
		constroi_arv('b',
			NULL,
			constroi_arv('d', NULL, NULL)
		),
		constroi_arv('c',
			constroi_arv('e', NULL, NULL),
			constroi_arv('f', NULL, NULL)
		)
	);

	int h = calcula_altura_arvore(arv); 
	printf("Altura: %d\n", h);
	return 0;
}

int ex6 () {
	printf("---- Inicio Ex 6: Conta a quantidade de nos folha em uma arvore\n");
	printf("Arvore de teste:\n"
	       "  +----a----+\n"  
	       "+-b-+     +-c-+\n"  
	       "    d     e   f\n");
	Arvore* arv = constroi_arv('a',
		constroi_arv('b',
			NULL,
			constroi_arv('d', NULL, NULL)
		),
		constroi_arv('c',
			constroi_arv('e', NULL, NULL),
			constroi_arv('f', NULL, NULL)
		)
	);

	int n = conta_nos_folha(arv);
	printf("Num de nos folhas: %d\n", n);
	return 0;
}

int main () {
	ex1();
	ex2();
	ex3();
	ex4();
	ex5();
	ex6();
	return 0;
}
