#include <stdio.h>
#include <limits.h>

int pai (int i) {
   return (i - 1)/2;
}

int esquerda (int i) {
   return 2 * (i + 1) - 1;
}

int direita (int i) {
   return 2 * (i + 1) - 1 + 1;
}

void trocar (int V[], int a, int b) {
   int aux = V[a];
   V[a] = V[b];
   V[b] = aux;
}

void imprimir (int V[], int size) {
   int i;
   for (i = 0; i < size; i++) {
      printf("%d ", V[i]);
   }
   printf("\n");
}

void min_heapify (int V[], int size, int i) {
   int e = esquerda(i);
   int d = direita(i);
   int menor = i;

   if (e < size && V[e] < V[menor]) {
      menor = e;
   }

   if (d < size && V[d] < V[menor]) {
      menor = d;
   }


   if (menor != i) {
	  trocar(V, i, menor);
      min_heapify(V, size, menor);
   }
}

void build_min_heap (int V[], int size) {
   int i;
   for (i = size / 2; i >= 0; i--) {
      min_heapify(V, size, i);
   }
}

int heap_minimum (int V[]) {
	return V[0];
}

int heap_extract_min (int V[], int size) {
	if (size < 1) {
		printf("Erro: heap underflow\n");
		return 0;
	}

	int aux = V[0];
	V[0] = V[size - 1];
	size = size - 1;

	min_heapify(V, size, 0);
	return aux;
}

void heap_decrease_key (int V[], int i, int chave) {
	if (chave > V[i]) {
		printf("Erro: Chave maior que a atual\n");
		return;
	}

	V[i] = chave;

	while (i > 0 && V[pai(i)] > V[i]) {
		trocar(V, pai(i), i);
		i = pai(i);
	}
}

void min_heap_insert (int V[], int size, int chave) {
	size = size + 1;
	V[size - 1] = INT_MAX;
	heap_decrease_key(V, size - 1, chave);
}

int main () {
   int i;

   int size = 10;

   int V[] = {4, 1, 3, 2, 16, 9, 10, 14, 8, 7};

   printf("Vetor inicial                : ");
   imprimir (V, size);

   printf("Vetor apos build-min-heap    : ");
   build_min_heap(V, size);
   imprimir (V, size);

   printf("Vetor apos heap-extract-min  : ");
   heap_extract_min(V, size);
   size--;
   imprimir (V, size);

   printf("Vetor apos heap-decrease-key : ");
   heap_decrease_key(V, size - 1, 1);
   imprimir (V, size);

   printf("Vetor apos min-heap-insert   : ");
   min_heap_insert(V, size, 0);
   size++;
   imprimir (V, size);

   return 0;
}
