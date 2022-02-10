#pragma once

class Universidade;

class Departamento {
private:
	char *_nome;
	Universidade *_universidade;

public:
	Departamento (const char *nome);
	~Departamento ();

	const char *getNome ();

	void afiliaUniversidade (Universidade *uni);
};
