#ifndef PARSER_H
#define PARSER_H

#include "lexer.h"
#include "ast_tree.h"

struct parser {
	struct lexer *lexer;
	struct token *lookahead;
};


struct parser *new_parser (char *file);
void free_parser(struct parser *p);

struct ast_node *match (enum token_type type, char *str, struct parser *p);

struct ast_node *expr (struct parser *p);
struct ast_node *decl (struct parser *p);
struct ast_node *atrib (struct parser *p);
struct ast_node *stat (struct parser *p);
struct ast_node *block (struct parser *p);
struct ast_node *ast_if (struct parser *p);
struct ast_node *ast_while (struct parser *p);

struct ast_node *analize (struct parser *p);

#endif	/* PARSER_H */
