#include "parser.h"
#include "ast_tree.h"
#include "lexer.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void error_exit (struct parser *p, char *expected) {
	fprintf(stderr,
			"Token inesperado em L%d C%d: '%s'",
			p->lookahead->line, p->lookahead->column, p->lookahead->str);

	if (expected != NULL) {
		fprintf(stderr, ", esperando '%s'", expected);
	}

	fprintf(stderr, "\n");
	exit(1);
}

struct parser *new_parser (char *file) {
	struct parser *p = (struct parser *) malloc(sizeof(struct parser));
	p->lexer = open_lexer(file);
	p->lookahead = next_token(p->lexer);

	return p;
}

void free_parser(struct parser *p) {
	free_lexer(p->lexer);
	free(p);
}

struct ast_node *match (enum token_type type, char *str, struct parser *p) {
	/* Verifica se o tipo e a str do token sao iguais, str nula nao compara */
	if (p->lookahead->type == type) {
		if (str == NULL || strcmp(p->lookahead->str, str) == 0) {
			struct ast_node *n = new_node(NT_FOLHA, p->lookahead, 0);
			p->lookahead = next_token(p->lexer);
			return n;
		}
	}

	/* Se nao encontrou o token esperado devolve erro e fecha o programa, memoria e devolvida para o sistema */
	error_exit(p, str);
	return NULL;
}

/* Declaracao de variaveis */
struct ast_node *decl (struct parser *p) {
	struct ast_node *n = new_node(NT_DECL, NULL, 3); /* Guarda ate 3 filhos */
	int i = 0;										 /* Contador para posicionar os filhos */

	n->children[i++] = match(TK_KEYWORD, "int", p); /* Aceita a keyword de tipo */
	n->children[i++] = match(TK_IDENTIFIER, NULL, p); /* Aceita um identificador qualquer */

	/* Se o proximo char for um '=' leia a constante ou identificador depois
	   Se nao for, leia apenas o ';' */
	if (strcmp("=", p->lookahead->str) == 0) {
		match(TK_OPERATOR, "=", p);
		n->children[i++] = expr(p);
	}
	else if (strcmp(";", p->lookahead->str) == 0) {
		match(TK_SEPARATOR, ";", p);
	}
	else {
		error_exit(p, "= ou ;");
	}

	return n;
}

/* Atribuicao para variaveis */
struct ast_node *atrib (struct parser *p) {
	struct ast_node *n = new_node(NT_ATRIB, NULL, 2);
	int i = 0;

	n->children[i++] = match(TK_IDENTIFIER, NULL, p);
	match(TK_OPERATOR, "=", p);
	n->children[i++] = expr(p);

	return n;
}

struct ast_node *expr (struct parser *p) {
	struct ast_node *n = new_node(NT_EXPR, NULL, 1);

	if (p->lookahead->type == TK_CONSTANT) {
		n->children[0] = match(TK_CONSTANT, NULL, p);
	}
	else if (p->lookahead->type == TK_IDENTIFIER) {
		n->children[0] = match(TK_IDENTIFIER, NULL, p);
	}
	else {
		error_exit(p, "constante ou identificador");
	}

	return n;
}

struct ast_node *stat (struct parser *p) {
	struct ast_node *n = new_node(NT_STAT, NULL, 1);

	if (p->lookahead->type == TK_KEYWORD && strcmp(p->lookahead->str, "int") == 0) {
		n->children[0] = decl(p);
	}
	else {
		n->children[0] = atrib(p);
	}

	match(TK_SEPARATOR, ";", p);
	return n;
}

struct ast_node *block (struct parser *p) {
	struct ast_node *n = new_node(NT_BLOCK, NULL, 2);

	n->children[0] = stat(p);

	if (p->lookahead &&
		((p->lookahead->type == TK_KEYWORD && strcmp(p->lookahead->str, "int") == 0) ||
		 p->lookahead->type == TK_IDENTIFIER)) {
		n->children[1] = block(p);
	}

	return n;
}

struct ast_node *ast_if (struct parser *p) {
	struct ast_node *n = new_node(NT_IF, NULL, 3);

	match(TK_KEYWORD, "if", p);
	match(TK_SEPARATOR, "(", p);
	n->children[0] = expr(p);
	match(TK_SEPARATOR, ")", p);
	match(TK_SEPARATOR, "{", p);
	n->children[1] = block(p);
	match(TK_SEPARATOR, "}", p);
	match(TK_KEYWORD, "else", p);
	match(TK_SEPARATOR, "{", p);
	n->children[2] = block(p);
	match(TK_SEPARATOR, "}", p);

	return n;
}

struct ast_node *ast_while (struct parser *p) {
	struct ast_node *n = new_node(NT_WHILE, NULL, 2);

	match(TK_KEYWORD, "while", p);
	match(TK_SEPARATOR, "(", p);
	n->children[0] = expr(p);
	match(TK_SEPARATOR, ")", p);
	match(TK_SEPARATOR, "{", p);
	n->children[1] = block(p);
	match(TK_SEPARATOR, "}", p);

	return n;
}

struct ast_node *analize (struct parser *p) {
	if (p->lookahead->type == TK_KEYWORD) {
		if (strcmp(p->lookahead->str, "int") == 0) {
			return block(p);
		}
		else if (strcmp(p->lookahead->str, "while") == 0) {
			return ast_while(p);
		}
		else if (strcmp(p->lookahead->str, "if") == 0) {
			return ast_if(p);
		}
	}
	else if (p->lookahead->type == TK_IDENTIFIER) {
		return block(p);
	}

	error_exit(p, NULL);
	return NULL;
}
