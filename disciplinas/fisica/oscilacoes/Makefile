CC = gcc
DB = gdb

IDIR = ./include
CFLAGS = -I$(IDIR) -lm -std=c11 `sdl2-config --cflags --libs`

BIN = ./bin
DATA = ./data

SRCS = $(wildcard ./src/*.c) main.c
INCLUDE = $(wildcard ./include/*.h)
OUT = Modos-Normais.out

$(BIN)/$(OUT): $(SRCS) $(INCLUDE) $(BIN)
	$(CC) $(SRCS) -o $(BIN)/$(OUT) $(CFLAGS)

$(BIN):
	mkdir $(BIN)

run: $(BIN)/$(OUT)
	$(BIN)/$(OUT)

debug:
	$(CC) -g $(SRCS) -o $(BIN)/$(OUT) $(CFLAGS)

clean:
	rm -rf $(BIN)

