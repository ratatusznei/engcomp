/*
    6. Escreva um programa que atribua um número entre 0 e 999 a uma variável e o imprima
    invertido, na ordem UDC (Unidade Dezena Centena). (Exemplo: se a entrada é 123, a saída é 321).
    Atenção: os dígitos não devem ser informados separadamente.
*/

#include <stdio.h>

// CDU -> UDC
int inverte (int n);

int main () {
	int ni;
	int no;

	scanf("%d", &ni);

    if (ni > 999 || ni < 0) {
        printf("Errado\n");
        return 1;
    }

    no = inverte(ni);

	printf("%d\n", no);

	return 0;
}

int inverte (int n) {
    int no = 0;
    
    no += n % 10;
	no *= 10;
	n /= 10;

	no += n % 10;
	no *= 10;
	n /= 10;

	no += n % 10;
	n /= 10;

    return no;
}
