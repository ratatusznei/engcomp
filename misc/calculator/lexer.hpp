#ifndef _LEXER_HPP
#define _LEXER_HPP
#include <iostream>
#include <string>
using std::istream;
using std::string;

namespace lexer {
	enum class Kind: char {
		name, number, end,
		plus='+', minus='-', mul='*', exp='^', div='/', print=';', assign='=', lp='(', rp=')'
	};
	struct Token {
		Kind kind;
		string string_value;
		double number_value;
	};
	class Token_stream {
		public:
			Token_stream(istream& s);
			Token_stream(istream* p);
			~Token_stream();
			Token get();

			const Token& current();
			// read and return next token
			// most recently read token
			void set_input(istream& s);
			void set_input(istream* p);
		private:
			void close();
			istream* ip;
			bool owns;
			Token ct {Kind::end};
	};

	extern Token_stream ts;
}
#endif // _LEXER_HPP
