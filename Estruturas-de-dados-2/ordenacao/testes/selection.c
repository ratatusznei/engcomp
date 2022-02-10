#include "teste.h"
#include "../selection/selectionsort.h"

int main () {
	puts("Teste selectionsort");

	testa("A1", selectionsort, a1, N1);
	testa("A2", selectionsort, a2, N2);
	testa("A3", selectionsort, a3, N3);
	return 0;
}
