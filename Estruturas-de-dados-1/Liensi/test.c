/*
	Por: Fernando H. Ratusznei Caetano
        	Pedro Vicente Alves Sokulski
*/

#include <stdio.h>
#include <stdlib.h>

#include "Liensi.h"

#if defined(WIN32) || defined(_WIN32) || defined(__WIN32) && !defined(__CYGWIN__)
#define CLEAR "cls"
#else
#define CLEAR "clear"
#endif

void printChoices ();
void printList (List_t *lista);

int main () {
	List_t lista;
	liensi_create(&lista);

	int choice = -1;
	int data;

	while (choice != 0) {
		system(CLEAR);

		printChoices();
		scanf(" %d", &choice);

		switch (choice) {
		case 0:
			liensi_destroy(&lista);
			break;

		case 1:
			printf("Valor: ");
			scanf("%d", &data);

			liensi_prepend(&lista, data);
			break;

		case 2:
			printf("Valor: ");
			scanf("%d", &data);

			liensi_append(&lista, data);
			break;

		case 3:
			if (liensi_premove(&lista)) {
				fprintf(stderr,
					"\nErro: Remocao em lista vazia\n");
			}
			break;

		case 4:
			if (liensi_remove(&lista)) {
				fprintf(stderr,
					"\nErro: Remocao em lista vazia\n");
			}
			break;

		case 5:
			printList(&lista);
			break;

		default:
			fprintf(stderr, "\nErro: Opcao invalida\n");
		}

		printf("\nDigite ENTER para continuar...");
		getchar();
		getchar();
	}

	printf("Bye!\n\n");

	return 0;
}

void printChoices () {
        printf("Escolha uma opcao:\n\n"
                "1. Inclusao no inicio da lista\n"
                "2. Inclusao no fim da lista\n"
                "3. Remocao do inicio da lista\n"
                "4. Remocao do fim da lista\n"
                "5. Impressao da lista\n"
                "0. Sair\n\n> ");
}

void printList (List_t *lista) {
        Cell *iterator = *lista;
	int i = 1;

        printf("\nTopo: %p, Endereço do topo: %p\n", *lista, lista);

        while (iterator != NULL) {
                printf("No %d: Endereço: %p Valor: %d Próximo: %p\n",
                        i, iterator, iterator->data, iterator->next);

                iterator = iterator->next;
		i++;
        }
}
