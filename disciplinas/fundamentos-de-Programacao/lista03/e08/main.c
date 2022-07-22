/*
     8. Suponha que você está programando um módulo contador de cédulas para caixas eletrônicos.
    Escreva um programa que informa com quantas cédulas de Real podemos representar um dado valor,
    considerando que existem cédulas de 1, 2, 5, 10, 20, 50 e 100 Reais. Exemplo de resposta: R$ 218 =
    2 cédulas de 100, 1 cédula de 10, 1 cédula de 5, 1 cédula de 2 e 1 cédula de 1. O número de cédulas
    usadas deve ser o menor possível. Desconsidere valores com centavos, e suponha que a máquina
    sempre tem disponíveis as cédulas necessárias
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
    int total;
    int n100;
    int n50;
    int n20;
    int n10;
    int n5;
    int n2;

    if (argc != 2) {
        printf("Usage: %s [money]\n", argv[0]);
        return 1;
    }

    total = atoi(argv[1]);

    n100 = total / 100;
    total -= 100 * n100;
    
    n50 = total / 50;
    total -= 50 * n50;

    n20 = total / 20;
    total -= 20 * n20;

    n10 = total / 10;
    total -= 10 * n10;

    n5 = total / 5;
    total -= 5 * n5;
    
    n2 = total / 2;
    total -= 2 * n2;

    printf("Notas de 100: %d\n", n100);
    printf("Notas de 50: %d\n", n50);
    printf("Notas de 20: %d\n", n20);
    printf("Notas de 10: %d\n", n10);
    printf("Notas de 5: %d\n", n5);
    printf("Notas de 2: %d\n", n2);
    printf("Notas de 1: %d\n", total);

	return 0;
}
