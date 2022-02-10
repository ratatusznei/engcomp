#include "teste.h"
#include "../insertion/insertionsort.h"

int main () {
	puts("Teste insertionsort");

	testa("A1", insertionsort, a1, N1);
	testa("A2", insertionsort, a2, N2);
	testa("A3", insertionsort, a3, N3);
	return 0;
}
