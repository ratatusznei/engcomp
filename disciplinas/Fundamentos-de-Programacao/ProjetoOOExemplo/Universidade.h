#pragma once

#include "Departamento.h"

class Universidade {
private:
	char *_nome;

	Departamento *_departamentos[50];
	int _dpto_count;

public:
	Universidade (const char nome[] = "");
	~Universidade ();

	char *getNome ();

	void afiliaDepartamento (Departamento *dpto);
	void printDepartamentos ();
};
