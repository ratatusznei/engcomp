#pragma once

#include "Pessoa.h"

class Professor: public Pessoa {
private:
	Universidade *_universidade;
	Departamento *_departamento;

public:
	Professor (int dia, int mes, int ano, const char nome[] = "");
	Professor ();
	~Professor ();

	void afiliaUniversidade (Universidade *uni);
	void afiliaDepartamento (Departamento *dpto);

	void printOndeTrabalha ();
};