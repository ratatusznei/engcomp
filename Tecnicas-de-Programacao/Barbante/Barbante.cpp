#include "Barbante.h"

#include <string.h>
#include <stdio.h>

Barbante::Barbante (const char *string) {
	_string = NULL;
	_length = 0;

	setString(string);
}

Barbante::~Barbante () {
	if (_string != NULL) {
		free(_string);
	}
}

const int Barbante::getLength () {
	return (const int) _length;
}

void Barbante::setString(const char *string) {
	if (_string != NULL) {
		free(_string);
	}

	if (string != NULL) {
		_length = strlen(string);
		_string = (char *) malloc(sizeof(char) * (_length + 1));
		strcpy(_string, string);
	}
	else {
		_string = NULL;
	}
}

const char *Barbante::getString () {
	return (const char *) _string;
}

void Barbante::operator= (Barbante &other) {
	setString(other.getString());
}

void Barbante::operator= (char *string) {
	setString((const char *) string);
}

void Barbante::operator= (const char *string) {
	setString(string);
}

bool Barbante::operator== (Barbante &to_compare) {
	return strcmp(to_compare.getString(), _string) == 0;
}
