#pragma once

#include "DListElement.h"

template <typename T>
class DList {
private:
	DListElement<T> *_first;
	DListElement<T> *_last;

	int _count;

public:
	DList ();
	~DList ();

	void append(T *data);
};
