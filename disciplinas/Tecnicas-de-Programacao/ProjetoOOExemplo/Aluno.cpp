#include "Aluno.h"

Aluno::Aluno (int dia, int mes, int ano, int RA, const char nome[]):
Pessoa (dia, mes, ano, nome){
	_RA = RA;
}

Aluno::~Aluno () {

}

int Aluno::getRA () {
	return _RA;
}