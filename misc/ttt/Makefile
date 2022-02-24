CFLAGS = -Wall -Wextra -pedantic -std=c99

PREFIX = /usr/bin
OUT = ttt
OBJ = main.o terminal.o word.o

all: $(OUT)
install: $(OUT)
	install -m 755 $(OUT) $(PREFIX)
uninstall:
	rm $(PREFIX)/$(OUT)

$(OUT): $(OBJ)
	$(CC) $(CFLAGS) -o $(OUT) $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

main.o: main.c word.h terminal.h
word.o: word.c word.h words.h terminal.h

.PHONY: clean run
clean:
	rm -rf $(OUT) $(OBJ)

run: $(OUT)
	./$(OUT)
