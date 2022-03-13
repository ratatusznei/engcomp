#include "error.hpp"
#include <iostream>

double error::error(std::string s) {
	std::cerr << s << std::endl;
	return 0;
}
