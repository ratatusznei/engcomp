#include "Universidade.h"
#include "Departamento.h"

#include <string.h>
#include <stdlib.h>

Departamento::Departamento (const char *nome) {
	_nome = (char *) malloc(sizeof(char) * strlen(nome));
	strcpy(_nome, nome);
}

Departamento::~Departamento () {
	free(_nome);
}

const char *Departamento::getNome () {
	return (const char*) _nome;
}

void Departamento::afiliaUniversidade (Universidade *uni) {
	_universidade = uni;
}
