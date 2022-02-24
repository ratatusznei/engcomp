/*
     9. Ainda considerando o seu trabalho com caixas eletrônicos, você deve escrever um programa
    que recebe um número de conta-corrente com três dígitos e mostra o seu dígito verificador. O dígito
    verificador é calculado da seguinte forma (utilizando o número 235 como exemplo):
    - Some o número da conta com o mesmo número com os dígitos invertidos. Exemplo: 235 + 532 = 767
    (o algoritmo para realizar esta inversão foi criado em outro exercício).
    - Se a soma anterior for maior ou igual a 1000, desconsidere o milhar.
    - Separe os 3 dígitos do número resultante, multiplicando a centena por 1, a dezena por 2, e a unidade
    por 3. Some os 3 valores. Exemplo: 7 (posição 1), 6 (posição 2) e 7 (posição 3): (7 x 1) + (6 x 2) + (7 x
    3) = 7 + 12 + 21 = 40.
    - O último dígito desse resultado é o dígito verificador da conta. Exemplo: 0
*/

#include <stdio.h>
#include <stdlib.h>

// CDU -> UDC
int inverte (int n);

int main (int argc, char *argv[]) {
    int conta;
    int digito = 0;

    if (argc != 2) {
        printf("Usage: %s [conta]\n", argv[0]);
        return 1;
    }

    conta = atoi(argv[1]);
    
    if (conta > 999 || conta < 0) {
        printf("Errado\n");
        return 1;
    }

    conta += inverte(conta);
    conta %= 1000;

    digito += (conta % 10) * 3;
    conta /= 10;
    digito += (conta % 10) * 2;
    conta /= 10;
    digito += (conta % 10) * 1;

    digito %= 10;

    printf("%d\n", digito);

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
