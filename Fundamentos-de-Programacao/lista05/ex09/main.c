#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	if (argc != 2) {
		printf("Usage: %s consumo\n", argv[0]);
		return 1;
	}

	int preco = 7;
	int consumo = atoi(argv[1]);

	if (consumo > 10) {
		preco += (consumo > 30? 20: consumo - 10) * 1;
	}
	if (consumo > 30) {
		preco += (consumo > 100? 70: consumo - 30) * 2;
	}
	if (consumo > 100) {
		preco += (consumo - 100) * 5;
	}

	printf("R$ %d.00\n\n", preco);
	
	return 0;
}
