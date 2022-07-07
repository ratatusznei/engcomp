CC = gcc
DB = gdb

IDIR = ./include
CFLAGS = -I$(IDIR) -lm -std=c11 `sdl2-config --cflags --libs`

BIN = ./bin
DATA = ./data

SRCS = ./src/*.c 
MAIN = main.c
OUT = Ballreto.out

all: 
	$(CC) $(SRCS) $(MAIN) -o $(BIN)/$(OUT) $(CFLAGS)

run:
	$(BIN)/$(OUT) 22 1000 500

debug:
	$(CC) -g $(SRCS) $(MAIN) -o $(BIN)/$(OUT) $(CFLAGS)


clean:
	rm $(BIN)/*

