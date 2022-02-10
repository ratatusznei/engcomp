/*
  FERNANDO HENRIQUE RATUSZNEI CAETANO 2021/1
  ESSE ARQUIVO FAZ PARTE DE UM TRABALHO PARA A DISCIPLINA "ESTRUTURA DE DADOS II"
*/

#include "lexer.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const char keywords[][8] = {
	"else", "if", "int", "while",
};

static const char operators[][8] = {
	"=", "+", "=="
};

static const char separators[][8] = {
	"(", ")", "[", "]", "{", "}",
	";", ",", ".", ":",
};

BOOL iskeyword (char *s, int len) {
	int n_keywords = sizeof(keywords) / sizeof(keywords[0]);
	int i;
	for (i = 0; i < n_keywords; i++) {
		if (strncmp(keywords[i], s, len + 1) == 0) {
			return TRUE;
		}
	}

	return FALSE;
}

BOOL isoperator (char *s, int len) {
	int n_operators = sizeof(operators) / sizeof(operators[0]);
	int i;
	for (i = 0; i < n_operators; i++) {
		if (strncmp(operators[i], s, len + 1) == 0) {
			return TRUE;
		}
	}

	return FALSE;
}

BOOL isseparator (char *s, int len) {
	int n_separators = sizeof(separators) / sizeof(separators[0]);
	int i;
	for (i = 0; i < n_separators; i++) {
		if (strncmp(separators[i], s, len + 1) == 0) {
			return TRUE;
		}
	}

	return FALSE;
}

BOOL isidentifier (char *s, int len) {
	if (len == 0 || isdigit(s[0])) {
		return FALSE;
	}

	int i;
	for (i = 0; i < len; i++) {
		if (!( isalnum(s[i]) || s[i] == '_' )) {
			return FALSE;
		}
	}

	return TRUE;
}

BOOL isrealnum (char *s, int len) {
	BOOL has_dot = FALSE;
	int i;
	for (i = 0; i < len; i++) {
		if (s[i] == '.') {
			if (has_dot) {
				return FALSE;
			}
			else {
				has_dot = TRUE;
			}
		}
		else if (!isdigit(s[i])) {
			return FALSE;
		}
	}

	return TRUE;
}

struct token *try_tokenize (char *s, int len, struct lexer *l) {
	enum token_type type = TK_NONE;

	if (iskeyword(s, len)) {
		type = TK_KEYWORD;
	}
	else if (isoperator(s, len)) {
		type = TK_OPERATOR;
	}
	else if (isseparator(s, len)) {
		type = TK_SEPARATOR;
	}
	else if (isidentifier(s, len)) {
		type = TK_IDENTIFIER;
	}
	else if (isrealnum(s, len)) {
		type = TK_CONSTANT;
	}

	if (type != TK_NONE) {
		struct token *tk = (struct token *) calloc(sizeof(struct token), 1);
		tk->type = type;
		strncpy(tk->str, s, len);

		if (l != NULL) {
			tk->line = l->line;
			tk->column = l->column - len;
		}
		return tk;
	}
	else {
		return NULL;
	}
}

struct lexer *open_lexer (char *file) {
	struct lexer *l = (struct lexer *) malloc(sizeof(struct lexer));
	l->f = fopen(file, "r");
	if (l->f == NULL) {
		perror("open_lexer");
		exit(1);
	}

	l->column = 1;
	l->line = 1;
	l->lookahead_char = ' ';
	return l;
}

void free_lexer (struct lexer *l) {
	fclose(l->f);
	free(l);
}

int next_char (struct lexer *l) {
	l->lookahead_char = fgetc(l->f);

	if (l->lookahead_char == '\n') {
		l->column = 1;
		l->line++;
	}
	else {
		l->column++;
	}

	return l->lookahead_char;
}

struct token *next_token (struct lexer *l) {
	while (isspace(l->lookahead_char)) {
		next_char(l);
	}

	if (l->lookahead_char == EOF) {
		return NULL;
	}

	int len = 0;
	char buf[MAX_SYMBOL_LEN] = "";

	struct token *last_token = NULL;
	struct token *new_token = NULL;

	/* Tratamento para strings */
	if (l->lookahead_char == '\"') {
		buf[len++] = l->lookahead_char;

		new_token = (struct token *) malloc (sizeof(struct token));
		new_token->column = l->column - 1; /* Compensa pelo primeiro " */
		new_token->line = l->line;

		do {
			next_char(l);
			buf[len++] = l->lookahead_char;
		} while (l->lookahead_char != '\"');

		strncpy(new_token->str, buf, len);
		new_token->str[len] = 0;
		new_token->type = TK_CONSTANT;

		next_char(l);
		return new_token;
	}

	/* Tratamento para constantes de caracteres */
	if (l->lookahead_char == '\'') {
		buf[len++] = l->lookahead_char;

		new_token = (struct token *) malloc (sizeof(struct token));
		new_token->column = l->column - 1; /* Compensa pelo primeiro ' */
		new_token->line = l->line;

		do {
			next_char(l);
			buf[len++] = l->lookahead_char;
		} while (l->lookahead_char != '\'');

		strncpy(new_token->str, buf, len);
		new_token->str[len] = 0;

		next_char(l);
		return new_token;
	}

	/*
	  Tratamento para outros tokens
	  Usa o método "greddy", verificando tokens validos cada vez maiores
	  e retornando o ultimo valido
	*/
	buf[len++] = l->lookahead_char;
	new_token = try_tokenize(buf, len, l);

	while (new_token != NULL) {
		if (last_token != NULL) {
			free(last_token);
		}
		last_token = new_token;

		next_char(l);
		buf[len++] = l->lookahead_char;
		new_token = try_tokenize(buf, len, l);
	}

	if (last_token == NULL) {
		fprintf(stdout, "[ERRO] Sequencia invalida em L%d C%d: \"%s\"\n", l->line, l->column - len, buf);
	}

	return last_token;
}
