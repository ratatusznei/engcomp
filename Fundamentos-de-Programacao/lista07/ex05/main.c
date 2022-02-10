/*
 5. Escreva um programa que lê duas entradas no formato “hora:minuto:segundo” 
 e as soma. O número de segundos e minutos deve ficar sempre entre 0 e 59. 
 O programa deve testar as entradas, para conferir se elas não são inválidas.
*/

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
	int hora1 = 0;
	int min1 = 0;
	int seg1 = 0;

	int hora2 = 0;
	int min2 = 0;
	int seg2 = 0;

	int resultado_hora = 0;
	int resultado_min = 0;
	int resultado_seg = 0;

	printf("Digite o 1° horario [hh:mm:ss]:  ");
	scanf("%d:%d:%d", &hora1, &min1, &seg1);

	if (
		hora1 < 0 || /* Hora positiva */
		min1 < 0 || min1 >= 60 || /* 0 <= min < 60 */
		seg1 < 0 || seg1 >= 60 /* 0 <= seg < 60 */
	) {
		fprintf(stderr, "Horario invalido!!!! >:(\n\n");
		return 1;
	}

	printf("Digite o 2° horario [hh:mm:ss]:  ");
	scanf("%d:%d:%d", &hora2, &min2, &seg2);

	if (
		hora2 < 0 || /* Hora positiva */
		min2 < 0 || min2 >= 60 || /* 0 <= min < 60 */
		seg2 < 0 || seg2 >= 60 /* 0 <= seg < 60 */
	) {
		fprintf(stderr, "Horario invalido!!!! >:(\n\n");
		return 1;
	}

	resultado_seg = seg1 + seg2;

	/* Minutos = resto dos segundos + minutos1 + minutos2 */
	resultado_min = resultado_seg / 60 + min1 + min2;
	resultado_seg %= 60;

	/* Horas = resto dos minutos + horas1 + horas2 */
	resultado_hora = resultado_min / 60 + hora1 + hora2;
	resultado_min %= 60;

	printf("\n%02d:%02d:%02d", hora1, min1, seg1);
	printf(" + %02d:%02d:%02d", hora2, min2, seg2);
	printf(" = %02d:%02d:%02d\n\n", resultado_hora, resultado_min, resultado_seg);

	return 0;
}










