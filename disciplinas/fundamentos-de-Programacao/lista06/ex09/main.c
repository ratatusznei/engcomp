/*
	9. Em uma competição de saltos ornamentais, 6 juízes dão suas notas, que podem variar entre 0 e
	10 (incluindo valores “quebrados”). A nota final do atleta deve excluir a maior e a menor nota 
	dos juízes e é composta pela média das quatro notas restantes. Faça um programa que lê do
	usuário as seis notas dos juízes e informa a nota final do atleta.
*/

#include <stdio.h>
#include <float.h>

#define N_JUIZES 6

int main (int argc, char *argv[]) {
	int i = 0;
	float maior = -666;
	float menor = 666;
	float soma = 0;
	float nota;

	while (i++ < N_JUIZES) {
		printf("Digite a nota do %dº juiz:  ", i);
		scanf("%f", &nota);

		if (nota < 0 || nota > 10) {
			printf("\nNota invalida!!!!!!! Tente novamente\n\n");
			i--;
			continue;		
		}

		if (nota > maior) {
			maior = nota;
		}
		
		if (nota < menor) {
			menor = nota;
		}

		soma += nota;
	}

	soma -= menor + maior;
	
	printf("Maior nota:  %.2f\n", maior);
	printf("Menor nota:  %.2f\n", menor);
	printf("Nota final:  %.2f\n\n", soma / (N_JUIZES - 2));

	return 0;
}
