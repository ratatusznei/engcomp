/*
	Por: Fernando H. Ratusznei Caetano

 8. Em algumas tarefas de programação de software básico ou embarcado
 (software de “baixo nível”), a troca de dados com periféricos é feita
 lendo e escrevendo valores diretamente em endereços pré-determinados de
 memória – essa estrutura é conhecida como DMA (Direct Memory Acess).
 Suponha que temos ligado ao processador um painel que possui 128 colunas
 de LEDs, cada coluna contendo 8 LEDs. Podemos criar padrões escrevendo
 dados nos 128 bytes a partir do endereço de memória 0x1000. Cada byte se
 refere a uma coluna, cada bit em um byte define o estado de um LED da
 coluna, com o bit mais significativo se referindo ao primeiro LED de cima
 para baixo e cada bit subsequente se referindo ao LED abaixo.

*/

#include <stdio.h>
#include <stdlib.h>

#define LED_BASE_ADDR 0x1000
#define N_LEDS 128

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

void ntostr (char n, char buffer[9]);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	short pattern = 0x80;
	int i;
	
	printf("--------\n");
	for (i = 0; i < N_LEDS; i++) {
		//*(LED_BASE_ADDR + i) = pattern;
		char buffer[9];
		ntostr(pattern, buffer);
		puts(buffer);

		pattern >>= 1;
		if (pattern == 0x00) {
			pattern = 0x80;
		}
	}
	printf("--------\n");

	return 0;
}

void ntostr (char n, char buffer[9]) {
	int i;

	for (i = 0; i < 8; i++) {
		buffer[8 - i - 1] = (n & 0x01)? '1': '0';
		n >>= 1;
	}

	buffer[8] = '\0';
}
