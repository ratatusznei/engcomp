#include "teste.h"
#include "../merge/mergesort.h"

int main () {
	puts("Teste mergesort");

	testa("A1", mergesort, a1, N1);
	testa("A2", mergesort, a2, N2);
	testa("A3", mergesort, a3, N3);
	return 0;
}
