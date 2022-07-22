#include <iostream>
#include <stdio.h>

#include "Arvore.h"

using namespace std;

void displayMenu ();

int main () {
	Arvore<int> tree;

	int choice = -1;
	bool sair = false;

	system("clear");
	while (!sair) {
		displayMenu();
		cin >> choice;

		switch (choice) {
		case 1:
			cout << "Valor: ";
			cin >> choice;
			tree.Inserir(choice);
			getchar();
			break;

		case 2:
			cout << "Valor: ";
			cin >> choice;
			tree.Remover(choice);
			getchar();
			break;

		case 3:
			cout << endl;
			tree.Apresenta();
			getchar();
			break;

		case 0:
			sair = true;
			break;

		default:
			cout << "Erro: Opcao invalida" << endl;
		}

		getchar();
		system("clear");
	}

	return 0;
}

void displayMenu () {
	cout << "1) Inserção em árvore binária" << endl;
	cout << "2) Remoção em árvore binária" << endl;
	cout << "3) Apresentação da árvore" << endl;
	cout << "0) Sair" << endl << endl;
}
