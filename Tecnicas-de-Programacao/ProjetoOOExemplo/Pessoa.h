#pragma once

#include "Universidade.h"
#include "Departamento.h"

class Pessoa {
protected:
	int _dia;
	int _mes;
	int _ano;
	int _idade;
	char _nome[30];

public:
	void inicializa (int dia, int mes, int ano, const char nome[]);
	Pessoa (int dia, int mes, int ano, const char nome[] = "");
	Pessoa ();

	void calculaIdade (int dia_atual, int mes_atual, int ano_atual);
	int informaIdade ();
	void printIdade ();
};
