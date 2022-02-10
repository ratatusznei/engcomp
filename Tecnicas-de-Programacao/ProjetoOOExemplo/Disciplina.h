#pragma once

#include "Departamento.h"

class Disciplina {
private:
	Departamento *_departamento;

public:
	Disciplina (Departamento *dpto);
	Disciplina ();
	~Disciplina ();

	void setDepartamento (Departamento *dpto);
	Departamento *getDepartamento ();
};
