/*
	Por: Fernando H. Ratusznei Caetano
		Pedro Vicente Alves Sokulski
*/

#ifndef LIENSI_H
#define LIENSI_H

#ifndef LIST_TYPE
#define LIST_TYPE int
#endif /* LIST_TYPE */

typedef struct Cell {
	LIST_TYPE data;
	struct Cell *next;
} Cell;

typedef Cell* List_t;

void liensi_create (List_t *head);
void liensi_destroy (List_t *head);

void liensi_prepend (List_t *head, LIST_TYPE data);
void liensi_append (List_t *head, LIST_TYPE data);
int liensi_premove (List_t *head);
int liensi_remove (List_t *head);

#endif /* LIENSI_H */
