#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "Universidade.h"

Universidade::Universidade (const char nome[]) {
	_nome = (char *) malloc(sizeof(char) * strlen(nome));
	strcpy(_nome, nome);

	_dpto_count = 0;
}

Universidade::~Universidade () {
	free(_nome);
}

char *Universidade::getNome () {
	return _nome;
}

void Universidade::afiliaDepartamento (Departamento *dpto) {
	if (_dpto_count < 50) {
		_departamentos[_dpto_count] = dpto;
		_dpto_count++;

		dpto->afiliaUniversidade(this);
	}
	else {
		printf("Erro: Numero maximo de departamentos excedidos em %s\n",
			_nome);
	}
}

void Universidade::printDepartamentos () {
	printf("Departamentos de %s:\n", _nome);

	for (int i = 0; i < _dpto_count; i++) {
		printf("\t%s\n", _departamentos[i]->getNome());
	}

	putchar('\n');
}
