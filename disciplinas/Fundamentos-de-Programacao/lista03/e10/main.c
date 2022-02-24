/*
        10. A Companhia de Táxi Tabajara (CTT) é uma das maiores empresas de transporte do país.
    Possui uma vasta frota de carros e opera em todas as grandes cidades. Recentemente a CTT
    modernizou a sua frota, adquirindo um lote de 500 carros bicombustíveis (carros que podem utilizar
    como combustível tanto álcool quanto gasolina). Além do maior conforto para os passageiros e o
    menor gasto com manutenção, com os novos carros é possível uma redução adicional de custo: como
    o preço da gasolina está sujeito a variações muito bruscas, pode ser vantagem, em certos momentos,
    utilizar álcool como combustível. Entretanto, os carros possuem um melhor desempenho utilizando
    gasolina, ou seja, em geral, um carro percorre mais quilômetros por litro de gasolina do que por litro de
    álcool.
    Escreva um programa que recebe o preço do litro de álcool, o preço do litro de gasolina e os
    quilômetros por litro que um carro bicombustível realiza com cada um desses combustíveis. O
    programa deve informar se é mais econômico abastecer os carros da CTT com álcool ou com
    gasolina. No caso de não haver diferença de custo entre abastecer com álcool ou gasolina, a CTT
    prefere utilizar gasolina.
*/

#include <stdio.h>

int main () {
	double precoAlcool;
	double rendimentoAlcool;
	
	double precoGas;
	double rendimentoGas;
	
	printf("Digite o preco e rendimento do alcool: ");
	scanf("%lf %lf", &precoAlcool, &rendimentoAlcool);
	
	printf("Digite o preco e rendimento da gasolina: ");
	scanf("%lf %lf", &precoGas, &rendimentoGas);

	if (rendimentoAlcool / precoAlcool >
		rendimentoGas / precoGas) 
	{
		puts("Alcool\n");	
	}
	else {
		puts("Gasolina\n");
	}

	return 0;
}
