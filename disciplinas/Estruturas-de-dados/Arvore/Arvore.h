#pragma once

#include <stdlib.h>
#include <iostream>
#include <list>

using namespace std;

template <typename T>
class Arvore {
private:
	class No {
	private:
		T _data;
		No *_filho_esq;
		No *_filho_dir;
	public:
		No (T data) {
			_data = data;
			_filho_esq = NULL;
			_filho_dir = NULL;
		}

		~No () {

		}

		T GetData () {
			return _data;
		}

		void SetData (T data) {
			_data = data;
		}

		No *GetFilhoDir () {
			return _filho_dir;
		}

		No *GetFilhoEsq () {
			return _filho_esq;
		}

		void SetFilhoDir (No *dir) {
			_filho_dir = dir;
		}

		void SetFilhoEsq (No *esq) {
			_filho_esq = esq;
		}

		void Familicidio () {
			if (_filho_esq != NULL) {
				delete _filho_esq;
			}

			if (_filho_dir != NULL) {
				delete _filho_dir;
			}
		}

		bool InsereFilho (No *_filho) {
			if (_filho->GetData() < _data) {
				if (_filho_esq == NULL) {
					_filho_esq = _filho;
					return false;
				}
				else {
					return _filho_esq->InsereFilho(_filho);
				}
			}
			else if (_filho->GetData() > _data){
				if (_filho_dir == NULL) {
					_filho_dir = _filho;
					return false;
				}
				else {
					return _filho_dir->InsereFilho(_filho);
				}
			}
			else {
				cout << "Erro: No ja existente, chave ";
				cout << _data << endl;
				return true;
			}
		}
	};

	No *_raiz;

public:
	Arvore () {
		_raiz = NULL;
	}

	~Arvore () {
		if (_raiz != NULL) {
			_raiz->Familicidio();
			delete _raiz;
		}
	}

	int Inserir (T data) {
		No *novo = new No(data);

		if (_raiz == NULL) {
			_raiz = novo;
			return false;
		}
		else {
			return _raiz->InsereFilho(novo);
		}
	}

	void Remover (T data) {
		if (_raiz == NULL) {
			cout << "Erro: Arvore vazia" << endl;
			return;
		}

		No *atual = _raiz;
		No *a_remover = NULL;
		No *pai_do_atual = NULL;
		bool eh_filho_da_direita;

		// Atual vai para no selecionado
		while (atual != NULL) {
			if (data < atual->GetData()) {
				pai_do_atual = atual;
				eh_filho_da_direita = false;

				atual = atual->GetFilhoEsq();
			}
			else if (data > atual->GetData()) {
				pai_do_atual = atual;
				eh_filho_da_direita = true;

				atual = atual->GetFilhoDir();
			}
			else {
				a_remover = atual;
				break;
			}
		}

		if (atual == NULL) {
			cout << "Erro: Remocao de no inexistente" << endl;
			return;
		}

		if (atual->GetFilhoDir() == NULL && atual->GetFilhoEsq() == NULL) {
		}
		else if (atual->GetFilhoDir() != NULL && atual->GetFilhoEsq() == NULL) {
			if (eh_filho_da_direita) {
				pai_do_atual->SetFilhoDir(atual->GetFilhoDir());
			}
			else {
				pai_do_atual->SetFilhoEsq(atual->GetFilhoDir());
			}
		}
		else if (atual->GetFilhoDir() == NULL && atual->GetFilhoEsq() != NULL) {
			if (eh_filho_da_direita) {
				pai_do_atual->SetFilhoDir(atual->GetFilhoEsq());
			}
			else {
				pai_do_atual->SetFilhoEsq(atual->GetFilhoEsq());
			}
		}
		else {
			pai_do_atual = atual;
			atual = atual->GetFilhoDir();

			while (atual->GetFilhoEsq() != NULL) {
				pai_do_atual = atual;
				atual->GetFilhoEsq();
			}

			a_remover->SetData(atual->GetData());
		}

		if (atual == _raiz) {
			_raiz = NULL;
		}

		delete atual;
	}

	void Apresenta () {
		/*
			Coloca raiz na lista de fronteira
			Coloca filhos na lista
			Apresenta raiz

			Apresenta filho e coloca seus filhos no fim da lista
			Repete enquanto ter filhos
		*/

		list <No*> fronteira;
		No *atual;
		No *filho_esq;
		No *filho_dir;

		if (_raiz != NULL) {
			atual = _raiz;
			filho_esq = atual->GetFilhoEsq();
			filho_dir = atual->GetFilhoDir();
			cout << "Raiz: " << atual->GetData() << "\t";
		}
		else {
			cout << "Lista vazia";
			cout << endl;
			return;
		}

		if (filho_esq != NULL) {
			fronteira.push_back(filho_esq);
			cout << "\tFE: " << filho_esq->GetData() << "\t";
		}
		else {
			cout << "\tFE: NULL";
		}
		if (filho_dir != NULL) {
			fronteira.push_back(filho_dir);
			cout << "\tFD: " << filho_dir->GetData();
		}
		else {
			cout << "\tFD: NULL";
		}
		cout << endl;

		while (!fronteira.empty()) {
			atual = fronteira.front();
			filho_esq = atual->GetFilhoEsq();
			filho_dir = atual->GetFilhoDir();

			fronteira.pop_front();

			cout << "No: " << atual->GetData() << "\t";

			if (filho_esq != NULL) {
				fronteira.push_back(filho_esq);
				cout << "\tFE: " << filho_esq->GetData() << "\t";
			}
			else {
				cout << "\tFE: NULL";
			}

			if (filho_dir != NULL) {
				fronteira.push_back(filho_dir);
				cout << "\tFD: " << filho_dir->GetData();
			}
			else {
				cout << "\tFD: NULL";
			}

			cout << endl;
		}
	}
};
