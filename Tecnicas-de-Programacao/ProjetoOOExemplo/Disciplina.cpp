#include "Disciplina.h"

Disciplina::Disciplina (Departamento *dpto) {
	_departamento = dpto;
}

Disciplina::Disciplina () {

}

Disciplina::~Disciplina () {

}

void Disciplina::setDepartamento (Departamento *dpto) {
	_departamento = dpto;
}

Departamento *Disciplina::getDepartamento () {
	return _departamento;
}
