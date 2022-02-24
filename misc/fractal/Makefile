CFLAGS=--std=c99 -Wall -Wextra --pedantic -O2

OUT=./fractal
SRC=fractal.c

all: $(OUT)

run: all
	$(OUT)

$(OUT): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(OUT)

clean:
	rm $(OUT)

.PHONY: clean run
