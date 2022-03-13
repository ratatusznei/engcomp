CXX = clang++
W = -Wall -Wextra -pedantic
CXXFLAGS = -O2 -std=c++11
PROGRAM = test.out

default: run
all: $(PROGRAM)

ifdef V
 E1 = @\#
 E2 =
else
 E1 = @echo
 E2 = @
endif

# Preenche arquivos aqui:
SRC = main.cpp
OBJ = main.o parser.o lexer.o table.o error.o

# Se precisar de dependencias
# g++ -MM main.cpp
main.o: main.cpp parser.hpp lexer.hpp table.hpp
parser.o: parser.cpp parser.hpp lexer.hpp table.hpp error.hpp
lexer.o: lexer.cpp lexer.hpp error.hpp
table.o: table.cpp table.hpp
error.o: error.cpp error.hpp

$(PROGRAM): $(OBJ)
	$(E1) "LINK  $^"
	$(E2) $(CXX) $(CXXFLAGS) $^ -o $(PROGRAM)

%.o: %.cpp
	$(E1) "CXX   $<"
	$(E2) $(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: clean run
run: $(PROGRAM)
	$(E1) -n "RUN  "
	./$<

clean:
	$(E1) "CLEAN $(PROGRAM) $(OBJ)"
	$(E2) rm -rf $(PROGRAM) $(OBJ)
