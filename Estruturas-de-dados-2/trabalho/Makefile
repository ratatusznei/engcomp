CFLAGS = -Wall -Wextra -pedantic -std=c99 -g

PREFIX = /usr/bin
OUT = analise
OBJ = src/main.o src/lexer.o src/parser.o src/ast_tree.o

all: $(OUT)

$(OUT): $(OBJ)
	$(CC) $(CFLAGS) -o $(OUT) $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

src/main.o: src/main.c src/lexer.o src/parser.o src/ast_tree.o
src/lexer.o: src/lexer.c src/lexer.h
src/ast_tree.o: src/ast_tree.c src/ast_tree.h src/lexer.o
src/parser.o: src/parser.c src/parser.h src/lexer.o src/ast_tree.o

.PHONY: clean run

clean:
	rm -rf $(OUT) $(OBJ)

run: $(OUT)
	./$(OUT)
