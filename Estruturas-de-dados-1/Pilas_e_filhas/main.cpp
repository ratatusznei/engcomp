#include <iostream>

#include "PilhaEn.h"
#include "Row.h"

using namespace std;

void printChoices();

int main (int argc, char *argv[]) {
	int choice = -1;
	bool run = true;

	PilhaEn<int> pilha;
	Row fila;


	while (run) {
		printChoices();
		cin >> choice;
		cout << '\n';

		switch (choice) {
		case 0:
			run = false;
			break;

		case 1:
			cout << "Valor: ";
			cin >> choice;
			pilha.enqueue(choice);
			break;

		case 2:
			if (pilha.isEmpty()) {
				cout << "Erro: Pilha vazia\n";
				break;
			}

			choice = pilha.peek();

			if (fila.entraNaFila(choice)) {
				cout << "Erro: Fila cheia\n";
				break;
			}

			cout << "Valor movido: " << choice << '\n';
			pilha.dequeue();
			break;

		case 3:
			if (pilha.isEmpty()) {
				cout << "Pilha vazia\n";
			}
			else {
				cout << "Topo pilha: " << pilha.peek() << '\n';
			}

			if (fila.isVazia()) {
				cout << "Fila vazia\n";
			}
			else {
				cout << "Topo fila: " <<
					fila.quemTaNaVez() << '\n';
			}
			break;

		case 4:
			if (fila.isVazia()) {
				cout << "Fila vazia\n";
			}
			else {
				cout << "Valor removido: " <<
					fila.saiDaFila() << '\n';
			}
			break;

		default:
			cout << "Erro: Comando invalido\n";
			break;
		}

		getchar();
		getchar();
		system("clear");
	}

	return 0;
}

void printChoices () {
	cout << "\n1. Inserir valor em uma pilha encadeada\n";
	cout << "2. Mover valor da pilha para uma fila sequencial (matrizes)\n";
	cout << "   com 5 posições (mostrar o valor movido)\n";
	cout << "3. Consultar o valor do topo da pilha e da fila\n";
	cout << "4. Remover valor da fila (mostrar valor removido)\n";
	cout << "0. Sair\n\n> ";
}
