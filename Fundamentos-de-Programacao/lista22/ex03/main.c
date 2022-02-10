/*
	Por: Fernando H. Ratusznei Caetano

 3. Escreva um programa que usa struct's para armazenar dados de um
 estacionamento. Use uma struct para armazenar a placa e o modelo de um
 carro, assim como o horário de entrada e saída do estacionamento, com
 horas e minutos. Defina e preencha 1 variável do tipo da struct
 (= 1 carro), e mostre os dados do carro junto com o valor devido ao
 estacionamento (preços: R$5,00 a primeira hora, R$2,00 para cada hora
 extra, valores proporcionais ao tempo para horas incompletas).

*/

#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int horas;
	int mins;
	int segs;
} Horario_t;

typedef struct {
	char modelo[80];
	char placa[7];

	Horario_t horario_entrada;
	Horario_t horario_saida;
} Carro_t;

void cadastraCarro (Carro_t *carro, char *modelo, char *placa,
	int hora_entrada, int min_entrada, int seg_hora,
	int hora_saida, int min_saida, int seg_saida);

int main (int argc, char *argv[]) {
	Carro_t carro;
	long delta;
	float preco = 0;

	cadastraCarro(&carro, "TEMPRA", "AAA1234",
		12, 12, 12,
		16, 20, 0);

	printf("Entrada: %02d:%02d:%02d\n",
		carro.horario_entrada.horas,
		carro.horario_entrada.mins,
		carro.horario_entrada.segs);

	printf("Saida:   %02d:%02d:%02d\n",
		carro.horario_saida.horas,
		carro.horario_saida.mins,
		carro.horario_saida.segs);
	
	delta = 
		(((carro.horario_saida.horas * 60)
			+ carro.horario_saida.mins) * 60
			+ carro.horario_saida.segs)
		- (((carro.horario_entrada.horas * 60)
			+ carro.horario_entrada.mins) * 60
			+ carro.horario_entrada.segs);

	printf("Delta t: %ld s\n", delta);

	if (delta > 3600) {
		preco += 5.00;
		delta -= 3600;
	}

	preco += delta * 2.00 / 3600.0;

	printf("Preco:   R$ %.2f\n", preco);

	return 0;
}

void cadastraCarro (Carro_t *carro, char *modelo, char *placa,
	int hora_entrada, int min_entrada, int seg_entrada,
	int hora_saida, int min_saida, int seg_saida) {

	int i;

	for (i = 0; i < 80 && modelo[i] != '\0'; i++) {
		carro->modelo[i] = modelo[i];
	}

	for (i = 0; i < 7; i++) {
		carro->modelo[i] = placa[i];
	}

	carro->horario_entrada.horas = hora_entrada;
	carro->horario_entrada.mins = min_entrada;
	carro->horario_entrada.segs = seg_entrada;

	carro->horario_saida.horas = hora_saida;
	carro->horario_saida.mins = min_saida;
	carro->horario_saida.segs = seg_saida;

}

