#pragma once

#include "Pessoa.h"

class Aluno: public Pessoa {
private:
	int _RA;

public:
	Aluno (int dia, int mes, int ano, int RA, const char nome[] = "");
	~Aluno ();

	int getRA ();
};