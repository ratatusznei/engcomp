#include <stdio.h>
#include <string.h>

#include "Pessoa.h"

void Pessoa::inicializa (int dia, int mes, int ano, const char nome[]) {
	_dia = dia;
	_mes = mes;
	_ano = ano;

	strcpy(_nome, nome);
}

Pessoa::Pessoa (int dia, int mes, int ano, const char nome[]) {
	inicializa(dia, mes, ano, nome);
}

Pessoa::Pessoa () {
	inicializa(-1, -1, -1, "");
}

void Pessoa::calculaIdade (int dia_atual, int mes_atual, int ano_atual) {
	_idade = ano_atual - _ano;

	if (_mes > mes_atual) {
		_idade = _idade - 1;
	}
	else {
		if (_mes == mes_atual) {
			if (_dia > dia_atual) {
				_idade = _idade - 1;
			}
		}
	}
}

int Pessoa::informaIdade () {
	return _idade;
}

void Pessoa::printIdade () {
	printf("%s: Tenho %d anos\n", _nome, _idade);
}
