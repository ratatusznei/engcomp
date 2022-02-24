#include <stdio.h>
#include <stdlib.h>

#define BRANCO 1
#define CINZA  2
#define PRETO  3
#define VERMELHO 4

/*Estrutura para um vértice em uma lista encadeada: */
typedef struct vertice {
   int d;
   int f;
   int cor;
   int pai;
   int cor_bipartido;
   int identificador; /*Identificador do vértice armazenado no nó. */
   struct vertice *proximo; /* Próximo nó na lista encadeada. */
} Vertice;

typedef struct aresta_classificada {
   int pai;
   int filho;
   int faz_parte;
   struct aresta_classificada *proximo;
} ArestaClassificada;

/*Estrutura do Grafo: */
typedef struct grafo {
   int E; /* Quantidade de arestas. */
   int V; /* Quantidade de vértices. */
   Vertice **listaAdj; /* Lista de adjacências. */
   ArestaClassificada *listaAreClasf;
} Grafo;

/* */
Grafo* criar_grafo (int tamanho) {
   int v;
   Grafo *G = (Grafo *)malloc(sizeof(Grafo));
   G->E = 0;
   G->V = tamanho;
   G->listaAdj = (Vertice **)malloc(tamanho * sizeof(Vertice *));
   for (v = 0; v < G->V; v++) {
      G->listaAdj[v] = NULL;
   }
   G->listaAreClasf = NULL;
   return G;
}

/* */
void liberar_grafo (Grafo *G) {
   int v;
   for (v = 0; v < G->V; v++) {
      if (G->listaAdj[v] != NULL) {
         free(G->listaAdj[v]);
      }
   }
   free(G->listaAdj);
   free(G);
}

/* */
void inserir_aresta (Grafo *G, int u, int v) {
   Vertice *temp, *ultimo = NULL;
   /* Verificando se o vértice v já existe na lista de adjacência de u: */
   for (temp = G->listaAdj[u]; temp != NULL; temp = temp->proximo) {
      if (temp->identificador == v) {
         return;
      }
      ultimo = temp;
   }
   /* Inserindo a aresta (u,v): */
   Vertice *novo = (Vertice *)malloc(sizeof(Vertice));
   novo->identificador = v;
   novo->proximo = NULL;
   if (ultimo != NULL) {
      /* Inserção na última posição da lista: */
      ultimo->proximo = novo;
   }
   else {
      /* Nova cabeça da lista: */
      G->listaAdj[u] = novo;
   }
   /* Incrementando o número de arestas: */
   G->E++;
}

/* */
void imprimir_grafo (Grafo *G) {
   printf("Lista de adjacência de G:\n");
   int v;
   for (v = 0; v < G->V; v++) {
      if (G->listaAdj[v] != NULL) {
         Vertice *temp;
         printf("Nó %d : ", v);
         for (temp = G->listaAdj[v]; temp != NULL; temp = temp->proximo) {
            printf(" %d ", temp->identificador);
         }
         printf("\n");
      }
   }
}

/* */
void DFS_Visit (Grafo *G, Vertice *V, int u, int *tempo, int pintaCor) {
   V[u].cor = CINZA;
   *tempo = (*tempo) + 1;
   V[u].d = (*tempo);
   Vertice *v;

   for (v = G->listaAdj[u]; v != NULL; v = v->proximo) {
      ArestaClassificada *ultima_classificao = G->listaAreClasf;

      if (G->listaAreClasf == NULL) {
	 G->listaAreClasf = (ArestaClassificada *) malloc(sizeof(ArestaClassificada));
	 G->listaAreClasf->proximo = NULL;
	 ultima_classificao = G->listaAreClasf;
      }
      else {
	 while (ultima_classificao->proximo != NULL) {
	    ultima_classificao = ultima_classificao->proximo;
	 }
	 ultima_classificao->proximo = (ArestaClassificada *) malloc(sizeof(ArestaClassificada));
	 ultima_classificao = ultima_classificao->proximo;
      }
      ultima_classificao->pai = u;
      ultima_classificao->filho = v->identificador;
      ultima_classificao->faz_parte = 0;

      if (V[v->identificador].cor == BRANCO) {
	 ultima_classificao->faz_parte = 1;

         V[v->identificador].pai = u;
         V[v->identificador].cor_bipartido = pintaCor;

	 if (pintaCor == VERMELHO) {
	    DFS_Visit (G, V, v->identificador, tempo, PRETO);
	 }
	 else {
	    DFS_Visit (G, V, v->identificador, tempo, VERMELHO);
	 }
      }
   }
   V[u].cor = PRETO;
   *tempo = (*tempo) + 1;
   V[u].f = *tempo;
}

/* */
void Busca_Profundidade (Grafo *G) {
   int u;
   int tempo = 0;
   Vertice *V = (Vertice *)malloc(G->V * sizeof(Vertice));
   for (u = 0; u < G->V; u++) {
      V[u].cor = BRANCO;
      V[u].pai = -1;
   }

   for (u = 0; u < G->V; u++) {
      if (V[u].cor == BRANCO) {
	 V[u].cor_bipartido = PRETO;
         DFS_Visit (G, V, u, &tempo, VERMELHO);
      }
   }

   printf("Eh bipartido: ");
   int eh_bipartido = 1;
   for (u = 0; u < G->V; u++) {
      Vertice *temp = G->listaAdj[u];

      while (temp != NULL) {
	 if (V[temp->identificador].cor_bipartido == V[u].cor_bipartido) {
	    eh_bipartido = 0;
	    u = G->V + 1;
	    break;
	 }

	 temp = temp->proximo;
      }
   }
   printf("%s\n", eh_bipartido == 1? "SIM": "NAO");
}

/* */
int main () {

   int tamanho = 7; /*Número de vértices!*/

   Grafo *G = criar_grafo (tamanho);

   /* Ordem dos vértices da busca em
      profundidade vista em aula:
      2  1  0  5
      3  4  7  6
   */

   /*Inserção das arestas conforme a aula: */
   inserir_aresta (G, 0, 1); /*Aresta 0-1 e 1-0*/
   inserir_aresta (G, 1, 0);
   inserir_aresta (G, 0, 5); /*Aresta 0-5 e 5-0*/
   inserir_aresta (G, 5, 0);
   inserir_aresta (G, 2, 1); /*Aresta 2-1 e 1-2*/
   inserir_aresta (G, 1, 2);
   inserir_aresta (G, 4, 1); /*Aresta 4-1 e 1-4*/
   inserir_aresta (G, 1, 4);
   inserir_aresta (G, 4, 5); /*Aresta 4-5 e 5-4*/
   inserir_aresta (G, 5, 4);
   inserir_aresta (G, 6, 3); /*Aresta 6-3 e 3-6*/
   inserir_aresta (G, 3, 6);


   imprimir_grafo (G);
   Busca_Profundidade (G);

   printf("Inserindo aresta para torna-lo não bipartido...\n");
   inserir_aresta (G, 0, 2);
   inserir_aresta (G, 2, 0);
   imprimir_grafo (G);
   Busca_Profundidade (G);

   liberar_grafo (G);

   return 0;
}

