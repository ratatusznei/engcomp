#include "ast_tree.h"

#include <stdlib.h>
#include <string.h>

struct ast_node *new_node (enum ast_node_type type, struct token *tk, int nchildren) {
	struct ast_node *node = (struct ast_node *) malloc(sizeof(struct ast_node));

	if (tk != NULL) {
		node->tk = (struct token*) malloc(sizeof(struct token));
		node->tk->column = tk->column;
		node->tk->line = tk->line;
		node->tk->type = tk->type;
		strcpy(node->tk->str, tk->str);
	}
	else {
		node->tk = NULL;
	}

	node->type = type;
	node->nchildren = nchildren;
	node->children = (struct ast_node **) calloc(sizeof(struct ast_node*), nchildren);
	return node;
}

void free_node (struct ast_node *node) {
	int i;
	for (i = 0; i < node->nchildren; i++) {
		if (node->children[i] != NULL) {
			free_node(node->children[i]);
		}
	}

	if (node->tk) free(node->tk);
	free(node);
}

void print_ast_i (struct ast_node *node, int i) {
	int n;
	int ident;
	printf("%*c[", i, '\0'); /* Imprime \0 com i chars de padding */

	switch(node->type) {
	case NT_WHILE:
		ident = printf("while");
		break;
	case NT_IF:
		ident = printf("if");
		break;
	case NT_BLOCK:
		ident = printf("block");
		break;
	case NT_STAT:
		ident = printf("statement");
		break;
	case NT_EXPR:
		ident = printf("expressao");
		break;

	case NT_ATRIB:
		ident = printf("atribuicao");
		break;

	case NT_DECL:
		ident = printf("declaracao");
		break;

	case NT_FOLHA:
		ident = printf("%s", node->tk->str);
		break;
	}

	for (n = 0; n < node->nchildren; n++) {
		if (node->children[n] != NULL) {
			printf("\n");
			print_ast_i(node->children[n], i + ident + 1);
		}
	}

	printf("]");
}

void print_ast (struct ast_node *node) {
	print_ast_i(node, 0);
	printf("\n");
}
