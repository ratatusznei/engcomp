// Calculator from TC++PL Chapter 10

#include <iostream>
#include "parser.hpp"
#include "lexer.hpp"
#include "table.hpp"

using std::cout;
using std::endl;

void calculate() {
	while (true) {
		lexer::ts.get();
		if (lexer::ts.current().kind == lexer::Kind::end) break;
		if (lexer::ts.current().kind == lexer::Kind::print) continue;
		cout << ": " << parser::expr(false) << endl;
	}
}

int main() {
	table::init();
	calculate();
}
