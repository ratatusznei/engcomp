#include "lexer.hpp"
#include "error.hpp"

lexer::Token_stream::Token_stream(istream& s) : ip{&s}, owns{false} { }
lexer::Token_stream::Token_stream(istream* p) : ip{p}, owns{true} { }
lexer::Token_stream::~Token_stream() { close(); }
lexer::Token lexer::Token_stream::get() {
	char ch = 0;

	do { // skip whitespace except ’\n’
		if (!ip->get(ch)) return ct={Kind::end};
	} while (ch!='\n' && isspace(ch));

	switch (ch) {
		case ';': 
		case '\n':
			return ct = {Kind::print};
		case 0:
			return ct = {Kind::end};
		case '*':
		case '^':
		case '/':
		case '+':
		case '-':
		case '(':
		case ')':
		case '=':
			return ct = {static_cast<Kind>(ch)};
		case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9':
		case '.':
			ip->putback(ch);
			// put the first digit (or .) back into the input stream
			*ip >> ct.number_value;
			// read number into ct
			ct.kind=Kind::number;
			return ct;
		default:
			// name, name =, or error
			if (isalpha(ch)) {
				ct.string_value = ch;
				while (ip->get(ch) && isalnum(ch)) {
					ct.string_value += ch;
				}
				ip->putback(ch);
				ct.kind = Kind::name;
				return ct;
			}
			error::error("bad token");
			return ct = {Kind::print};
	}
}

const lexer::Token& lexer::Token_stream::current() {
	return ct;
}
// read and return next token
// most recently read token
void lexer::Token_stream::set_input(istream& s) { close(); ip = &s; owns=false; }
void lexer::Token_stream::set_input(istream* p) { close(); ip = p; owns = true; }
void lexer::Token_stream::close() { if (owns) delete ip; }

lexer::Token_stream lexer::ts(std::cin);
