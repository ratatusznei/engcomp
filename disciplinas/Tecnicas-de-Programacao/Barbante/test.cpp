#include <stdio.h>

#include "Barbante.h"

int main (int argc, char *argv[]) {
	Barbante nome("ASDA");
	Barbante nome2("ABC");

	puts(nome.getString());
	puts(nome2.getString());

	nome = nome2;

	printf("%d\n", nome == nome2);

	nome = "RETERETE";
	puts(nome.getString());

	return 0;
}
