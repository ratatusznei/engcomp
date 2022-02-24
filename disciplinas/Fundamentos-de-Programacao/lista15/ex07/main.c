/*
	Por: Fernando H. Ratusznei Caetano

 7. Em jogos de tempo real, o tempo é dividido em game ticks - intervalos
 de tempo entre um evento e outro. Em jogos como os da série Street
 Fighter, quando o jogador faz um movimento de pulo, o computador calcula
 a posição do personagem a cada game tick, seguindo uma trajetória
 parabólica.

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define G 9.8
#define M_PI 3.14159265358979323846
#define DELTA_T 0.5

#define N_ARGS 2
#define USAGE "Usage: %s <v0> <theta>\n\n"

int jumpPosition (double v0, double theta, double t, double* x, double* y);

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	double t = 0;
	double v0 = atof(argv[1]);
	double theta = atof(argv[2]) * 2.0 * M_PI / 360.0;
	double x;
	double y;
	
	printf("t\tx\ty\n");
	do {
		printf("% 4.2lf\t% 4.2lf\t% 4.2lf\n", t, x, y);
		t += DELTA_T;
	} while (jumpPosition(v0, theta, t, &x, &y));
	
	return 0;
}

int jumpPosition (double v0, double theta, double t, double* x, double* y) {
	/*
		r(t) = V(0) * t + t^2/2 * a
		V(0) = (v0 * cos theta, v0 * sin theta)
		a = (0, -G)
	*/

	double v0x = v0 * cos(theta);
	double v0y = v0 * sin(theta);

	*x = t * v0x;
	*y = t * v0y - G * t * t / 2.0;

	/* A função deve retornar 0 se o personagem já tiver retornado
	   ao solono tempo t, ou 1 do contrário. */
	return *y >= 0;
}

