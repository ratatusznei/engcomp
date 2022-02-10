#pragma once

#include <stdlib.h>

class Barbante {
private:
	int _length;
	char *_string;

public:
	Barbante (const char *string = NULL);
	~Barbante ();

	const int getLength ();

	void setString(const char *string);
	const char *getString ();

	void operator= (Barbante &other);
	void operator= (char *string);
	void operator= (const char *string);

	bool operator== (Barbante &to_compare);
};
