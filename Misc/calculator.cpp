#include <iostream>
#include <string>
#include <map>
#include <cctype>
#include <cmath>
using namespace std;

enum class Kind : char {
	name, number, end,
	plus='+', minus='-', mul='*', exp='^', div='/', print=';', assign='=', lp='(', rp=')'
};
struct Token {
	Kind kind;
	string string_value;
	double number_value;
};

double error(string s) {
	cerr << s << endl;
	return 0;
}

class Token_stream {
	public:
		Token_stream(istream& s) : ip{&s}, owns{false} { }
		Token_stream(istream* p) : ip{p}, owns{true} { }
		~Token_stream() { close(); }
		Token get() {
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
				error("bad token");
				return ct = {Kind::print};
			}
		}

		const Token& current() {
			return ct;
		}
		// read and return next token
		// most recently read token
		void set_input(istream& s) { close(); ip = &s; owns=false; }
		void set_input(istream* p) { close(); ip = p; owns = true; }
	private:
		void close() { if (owns) delete ip; }
		istream* ip;
		bool owns;
		Token ct {Kind::end} ;
		// pointer to an input stream
		// does the Token_stream own the istream?
		// current token
};

Token_stream ts(cin);
map<string,double> table = { };
double expr(bool);

double prim(bool get) {
	if (get) ts.get(); // read next token
	switch (ts.current().kind) {
	case Kind::number:
		// floating-point constant
		{
			double v = ts.current().number_value;
			ts.get();
			return v;
		}
	case Kind::name:
		{
			double& v = table[ts.current().string_value];
			if (ts.get().kind == Kind::assign) v = expr(true);
			return v;
		}
	case Kind::minus:
		// unar y minus
		return -prim(true);
	case Kind::lp:
		{
			auto e = expr(true);
			if (ts.current().kind != Kind::rp) return error("')' expected");
			ts.get();
			// eat ’)’
			return e;
		}
	default:
		return error("primary expected");
	}
}

double term(bool get) {
	double left = prim(get);
	// multiply and divide
	while (true) {
		switch (ts.current().kind) {
		case Kind::exp:
			left = pow(left, prim(true));
			break;
		case Kind::mul:
			left *= prim(true);
			break;
		case Kind::div:
			if (auto d = prim(true)) {
				left /= d;
				break;
			}
			return error("divide by 0");
		default:
			return left;
		}
	}
}

double expr(bool get) {
	double left = term(get);
	// add and subtract
	while (true) {
		switch (ts.current().kind) {
		case Kind::plus:
			left += term(true);
			break;
		case Kind::minus:
			left -= term(true);
			break;
		default:
			return left;
		}
	}
}

void calculate() {
	while (true) {
		ts.get();
		if (ts.current().kind == Kind::end) break;
		if (ts.current().kind == Kind::print) continue;
		cout << ": " << expr(false) << endl;
	}
}

int main() {
	table["pi"] = 3.1415965;
	table["e"] = 2.7182818;
	calculate();
}
