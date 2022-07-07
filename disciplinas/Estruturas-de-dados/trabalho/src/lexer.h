#ifndef LEXER_H
#define LEXER_H

#include "common.h"
#include <stdio.h>
#include <ctype.h>

enum token_type {
	TK_NONE,
	TK_KEYWORD,
	TK_IDENTIFIER,
	TK_CONSTANT,
	TK_OPERATOR,
	TK_SEPARATOR,
	TK_WHITESAPCE,
	TK_STRING,
};

struct lexer {
	FILE *f;
	int line;
	int column;
	int lookahead_char;
};

struct token {
	enum token_type type;
	int line;
	int column;
	char str[MAX_SYMBOL_LEN];
};

struct token *try_tokenize (char *s, int len, struct lexer *l);

struct lexer *open_lexer (char *file);
void free_lexer (struct lexer *l);
struct token *next_token (struct lexer *l);

#endif	/* LEXER_H */
