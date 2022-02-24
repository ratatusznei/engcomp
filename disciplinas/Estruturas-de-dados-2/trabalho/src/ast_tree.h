#ifndef AST_TREE_H
#define AST_TREE_H

#include "lexer.h"

enum ast_node_type {
	NT_FOLHA,
	NT_DECL,
	NT_ATRIB,
	NT_EXPR,
	NT_STAT,
	NT_BLOCK,
	NT_IF,
	NT_WHILE,
};

struct ast_node {
	enum ast_node_type type;
	int nchildren;
	struct token *tk;
	struct ast_node **children;
};

struct ast_node *new_node (enum ast_node_type type, struct token *tk, int nchildren);
void free_node (struct ast_node *node);
void print_ast (struct ast_node *node);

#endif	/* AST_TREE_H */
