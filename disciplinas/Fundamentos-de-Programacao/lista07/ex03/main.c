/*
 3. Escreva um programa que lê uma entrada na forma a●b, onde a e b são
 números e ● é uma das 4 operações básicas (+, -, *, ou /). Não devem haver
 espaços entre os números e o operador. O programa deve imprimir o resultado
 da conta dada, ou informar que a entrada é inválida. Dica: para saber qual
 operação realizar, leia-a como um caractere, usando a sequência de escape 
 %c.
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	int a;
	int b;
	char operacao;
	float resultado;

	printf(">>  ");
	scanf("%d%c%d", &a, &operacao, &b);

	switch (operacao) {
	case '+':
		resultado = a + b;
		break;
	case '-':
		resultado = a - b;
		break;
	case '*':
		resultado = a * b;
		break;
	case '/':
		resultado = (float) (a) / b;
		break;
	default:
		fprintf(stderr, "Opecao invalida!!!\n\n");
		return 1;
	}

	printf("%d %c %d = %.2f\n\n", a, operacao, b, resultado);

	return 0;
}
