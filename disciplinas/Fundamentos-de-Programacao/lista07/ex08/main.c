/*
 8. O IMC (Índice de Massa Corporal) é uma medida que foi criada para
 dar uma indicação sobre a condição de peso de uma população. Por sua
 simplicidade, ele é usado – com críticas – para avaliar a condição
 de indivíduos adultos. A fórmula é: IMC = peso / (altura^2). Escreva
 um programa que leia o gênero ('m' ou 'f'), o peso e a altura de um
 adulto, e mostre uma mensagem de acordo com a sua condição. Se a
 pessoa for do sexo masculino, a mensagem é dada pela seguinte tabela:

 IMC		Mensagem
 IMC<18.5	Voc~/Programming/IF61C/aula2603/ex08e esta abaixo do peso
 18.5<=IMC<25	Voce esta com o peso normal
 25<=IMC<30	Voce esta acima do peso
 IMC>30		Voce esta obeso

 Se a pessoa for do sexo feminino, o programa deve exibir a mensagem 
 “Você está ótima!”
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	if (argc != 4) {
		fprintf(stderr, 
			"Usage: %s <genero f/m> <peso> <altura>\n\n",
			argv[0]);
		return 1;
	}

	/* Converte o char maiusculo para minucula */
	char genero = argv[1][0] >= 'A' && argv[1][0] <= 'Z'?
		argv[1][0] - 'A' + 'a':
		argv[1][0];

	double peso = atof(argv[2]);
	double altura = atof(argv[3]);
	double imc;

	if (genero != 'f' && genero != 'm') {
		fprintf(stderr, "Genero invalido!!1!!\n\n");
		return 1;
	}

	if (peso < 0 || altura < 0) {
		fprintf(stderr, "Algo errado com o peso ou altura!1!!\n\n");
		return 1;
	}


	imc = peso / (altura * altura);

	if (imc < 18.5) {
		printf("Voce esta abaixo do peso!");
	}
	else if (imc < 25) {
		printf(
			genero == 'f'?
			"Voce esta otima!!ONZE!!":
			"Voce esta com o peso normal"
		);
	}
	else if (imc < 30) {
		printf("Voce esta acima do peso!");
	}
	else {
		printf("Voce esta obeso!");
	}


	printf("\n\n");

	return 0;
}
