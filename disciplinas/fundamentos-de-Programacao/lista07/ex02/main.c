/*
 2. Escreva um programa que lê o salário fixo e o valor das vendas efetuadas
 por um vendedor de uma empresa. O programa deve calcular e escrever o seu
 salário total, sabendo que além do salário fixo, ele recebe uma comissão de
 3% sobre o total das vendas até R$ 1.500,00, e uma comissão de 5% sobre o
 total das vendas acima de R$ 1.500,00. Por exemplo, se o salário fixo é de
 R$ 1.000,00 e as vendas foram de R$ 2.000,00, o salário total é de 
 R$ 1.070,00.
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	if (argc != 3) {
		fprintf(stderr, "Usage: %s <salario> <vendas>\n", argv[0]);
		return 1;
	}

	// Os valores vao ser calculados em centavos
	int salario = 100 * atoi(argv[1]);
	int vendas = 100 * atoi(argv[2]);
	int salario_total;

	if (vendas > 1500 * 100) {
		salario_total = salario + (5 * (vendas - 1500 * 100)) / 100;
		salario_total += salario + (3 * 1500 * 100) / 100;
	}
	else {
		salario_total = salario + 3 * vendas / 100;
	}
	
	printf("O salario total eh:  R$%.2f\n\n", salario_total / 100.0);
	
	return 0;
}

