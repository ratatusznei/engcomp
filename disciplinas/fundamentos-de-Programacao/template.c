/*
	Por: Fernando H. Ratusznei Caetano

*/

#include <stdio.h>
#include <stdlib.h>

#define N_ARGS 0
#define USAGE "Usage: %s <args>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	return 0;
}

