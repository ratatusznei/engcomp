CC = gcc
DB = gdb

IDIR = ./include
CFLAGS = -I$(IDIR)

BIN = ./bin
DATA = ./data

SRCS = ./src/*.c 
MAIN = RowReduction.c
OUT = rowr

all: | $(BIN)
	$(CC) $(CFLAGS) $(SRCS) $(MAIN) -o $(BIN)/$(OUT)
	make run
run:
	$(BIN)/$(OUT) 0<$(DATA)/linsys.txt

bin:
	mkdir $(BIN)

debug:
	$(CC) $(CFLAGS) $(SRCS) $(MAIN) -o $(BIN)/$(OUT) -g
	$(DB) $(BIN)/$(OUT)

clean:
	rm $(BIN)/*
