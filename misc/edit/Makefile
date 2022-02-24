CC = gcc
W = -Wall -Wextra -pedantic
CFLAGS = -g
PROGRAM = edit

all: $(PROGRAM)

ifdef V
 E1 = @\#
 E2 =
else
 E1 = @echo
 E2 = @
endif

SRC = main.c
OBJ = main.o terminal.o editor.o vt100.o

terminal.o: terminal.c terminal.h vt100.o
main.o: main.c terminal.o editor.o
editor.o: editor.c editor.h terminal.o vt100.o

$(PROGRAM): $(OBJ)
	$(E1) "LINK $^"
	$(E2) $(CC) $(CFLAGS) $^ -o $(PROGRAM)

%.o: %.c
	$(E1) "CC   $<"
	$(E2) $(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean run
run: $(PROGRAM)
	$(E1) -n "RUN  "
	./$<
clean:
	$(E1) "CLEAN $(PROGRAM) $(OBJ)"
	$(E2) rm -rf $(PROGRAM) $(OBJ)
