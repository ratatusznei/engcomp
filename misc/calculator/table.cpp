#include "table.hpp"
std::map<std::string,double> table::table {};

void table::init() {
	table["pi"] = 3.1415965;
	table["e"] = 2.7182818;
}
