/*
	Por: Fernando H. Ratusznei Caetano
		Pedro Vicente Alves Sokulski
*/

#include <stdlib.h>

#include "Liensi.h"

Cell *allocCell () {
	return (Cell *) malloc (sizeof(Cell *));
}

void liensi_create (List_t *head) {
	*head = NULL;
}

void liensi_destroy (List_t *head) {
	if (*head == NULL) {
		return;
	}

	Cell *to_destroy = *head;
	Cell *next = to_destroy->next;

	free(to_destroy);

	while (next) {
		to_destroy = next;
		next = to_destroy->next;

		free(to_destroy);
	}
}

void liensi_prepend (List_t *head, LIST_TYPE data) {
	Cell *new_cell = allocCell();

	new_cell->data = data;
	new_cell->next = *head;

	*head = new_cell;
}

void liensi_append (List_t *head, LIST_TYPE data) {
	Cell *last_cell = *head;
	Cell *new_cell = allocCell();

	new_cell->data = data;
	new_cell->next = NULL;

	if (*head == NULL) {
		*head = new_cell;
	}
	else {
		/* Chega na ultima celula */
		while (last_cell->next) {
			last_cell = last_cell->next;
		}

		last_cell->next = new_cell;
	}
}

int liensi_premove (List_t *head) {
	if (*head == NULL) {
		return 1;
	}

	Cell *to_destroy = *head;
	*head = to_destroy->next;

	LIST_TYPE removed_data = to_destroy->data;
	free(to_destroy);

	return 0;
}

int liensi_remove (List_t *head) {
	if (*head == NULL) {
		return 1;
	}

	Cell *last_cell = *head;
	Cell *previous = NULL;
	LIST_TYPE removed_data;

	/* Chega na penultima celula */
	while (last_cell->next) {
		previous = last_cell;
		last_cell = last_cell->next;
	}

	removed_data = last_cell->data;
	free(last_cell);

	if (previous) {
		previous->next = NULL;
	}
	else {
		*head = NULL;
	}

	return 0;
}
