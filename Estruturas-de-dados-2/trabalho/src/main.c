#include <stdio.h>
#include <stdlib.h>

#include "parser.h"
#include "ast_tree.h"

int main (int argc, char *argv[]) {
	if (argc < 2) {
		printf("Uso: %s <arquivo>\n", argv[0]);
		exit(1);
	}

	struct parser *p = new_parser(argv[1]);
	struct ast_node *t = analize(p);

	print_ast(t);

	free_parser(p);
	free_node(t);

	return 0;
}
