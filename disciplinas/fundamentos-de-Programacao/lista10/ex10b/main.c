/*
	Por: Fernando H. Ratusznei Caetano

*/

#include <stdio.h>

#define PICO 'P'
#define VALE 'V'
#define SUBIDA 'S'
#define DESCIDA 'D'

int leProximoDado ();
void registraPadrao (int posicao, int tipo);

int main (int argc, char *argv[]) {
	/*
		ler 1o dado
		ler 2o
		ler 3o
		repete ate achar -1:
			se 2o >= 1o: pode ser subida ou pico
				se 3o >= 2o: subida
				se nao: pico
			se 2o < 1o: pode ser descida ou vale
				se 3o <= 2o: descida
				se nao: vale

			1o = 2o
			2o = 3o
			ler novo 3o
	
		Considera reto como subida Ex: 5, 5, 5
		Considera descida+reto descida Ex: 5, 2, 2
		Considera reto+descida pico Ex: 3, 3, 2
	*/

	int primeiro = leProximoDado();
	int segundo = leProximoDado();
	int terceiro = leProximoDado();
	int i = 1;

	while (primeiro != -1 && segundo != -1 && terceiro != -1) {
		if (segundo >= primeiro) {
			if (terceiro >= segundo) {
				registraPadrao(i, SUBIDA);
			}
			else {
				registraPadrao(i, PICO);
			}
		}
		else {
			if (terceiro <= segundo) {
				registraPadrao(i, DESCIDA);
			}
			else {
				registraPadrao(i, VALE);
			}
		}

		primeiro = segundo;
		segundo = terceiro;
		terceiro = leProximoDado();
		i++;
	}

	printf("\n\n");
	return 0;
}

int leProximoDado () {
	static int i = 0;
	static int dados[] = {1, 2, 3, 4, 5, 4, 3, 2, 1, 6, -1};	

	return dados[i++];
}

void registraPadrao (int posicao, int tipo) {
	printf("%c ", tipo);
}

