#pragma once

#include "Professor.h"
#include "Universidade.h"

class MainClass {
private:
	int dia;
	int mes;
	int ano;

	Professor Simao;
	Professor Einstein;
	Professor Newton;

	Universidade utfpr;
	Departamento dainf;
	Departamento daeln;
	Departamento dafis;

	Universidade princeton;
	Departamento prin_fis;

	Universidade cambridge;
	Departamento cam_mat;

public:
	MainClass ();

	void loop ();
};
