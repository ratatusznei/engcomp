#include "parser.hpp"
#include "lexer.hpp"
#include "table.hpp"
#include "error.hpp"
#include <cctype>
#include <cmath>

namespace parser {
	double prim(bool);
	double term(bool);
}

double parser::expr(bool get) {
	double left = term(get);
	// add and subtract
	while (true) {
		switch (lexer::ts.current().kind) {
		case lexer::Kind::plus:
			left += term(true);
			break;
		case lexer::Kind::minus:
			left -= term(true);
			break;
		default:
			return left;
		}
	}
}

double parser::prim(bool get) {
	if (get) lexer::ts.get(); // read next token
	switch (lexer::ts.current().kind) {
	case lexer::Kind::number:
		// floating-point constant
		{
			double v = lexer::ts.current().number_value;
			lexer::ts.get();
			return v;
		}
	case lexer::Kind::name:
		{
			double& v = table::table[lexer::ts.current().string_value];
			if (lexer::ts.get().kind == lexer::Kind::assign) v = expr(true);
			return v;
		}
	case lexer::Kind::minus:
		// unar y minus
		return -prim(true);
	case lexer::Kind::lp:
		{
			auto e = expr(true);
			if (lexer::ts.current().kind != lexer::Kind::rp) return error::error("')' expected");
			lexer::ts.get();
			// eat ’)’
			return e;
		}
	default:
		return error::error("primary expected");
	}
}

double parser::term(bool get) {
	double left = prim(get);
	// multiply and divide
	while (true) {
		switch (lexer::ts.current().kind) {
		case lexer::Kind::exp:
			left = pow(left, prim(true));
			break;
		case lexer::Kind::mul:
			left *= prim(true);
			break;
		case lexer::Kind::div:
			if (auto d = prim(true)) {
				left /= d;
				break;
			}
			return error::error("divide by 0");
		default:
			return left;
		}
	}
}
