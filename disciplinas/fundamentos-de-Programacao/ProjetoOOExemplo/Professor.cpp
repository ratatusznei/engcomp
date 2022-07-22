#include <stdio.h>

#include "Professor.h"

Professor::Professor (int dia, int mes, int ano, const char nome[]):
Pessoa (dia, mes, ano, nome) {
	_universidade = NULL;
	_departamento = NULL;
}

Professor::Professor () {
	_universidade = NULL;
	_departamento = NULL;
}

Professor::~Professor () {

}

void Professor::afiliaUniversidade (Universidade *uni) {
	_universidade = uni;
}

void Professor::afiliaDepartamento (Departamento *dpto) {
	_departamento = dpto;
}

void Professor::printOndeTrabalha () {
	printf("%s: Trabalho no departamento %s da universidade %s\n", 
		_nome, _departamento->getNome(),
		_universidade->getNome());
}
