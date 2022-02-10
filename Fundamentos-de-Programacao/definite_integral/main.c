/*
	Por: Fernando H. Ratusznei Caetano

	Calcula a integral definida de f (x) de A até B

	 |\B
	 |
	 |  f(x) * dx
	\|A

*/

#include <stdio.h>
#include <math.h>

#define A 0.25
#define B 1.25

#define N_STEPS 10000000.0
#define dx ((A + B) / N_STEPS) 

double f (double x) {
	return exp(-4 * x * x);
}

int main (int argc, char *argv[]) {
	double area = 0;

	double i = A;
	double fi = f(A);
	double fi_plusdx = f(A + dx);

	while (i <= B) {
		area += (fi + fi_plusdx);
		
		fi = fi_plusdx;

		i += dx;
		fi_plusdx = f(i);
	}
	area *= 0.5 * dx;

	printf("%lf\n\n", area);

	return 0;
}

