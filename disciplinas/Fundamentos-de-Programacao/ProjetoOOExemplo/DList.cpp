#include <stdlib.h>

#include "DList.h"

template <typename T>
DList<T>::DList () {
	_count = 0;

	_first = NULL;
	_last = NULL;
}

template <typename T>
DList<T>::~DList () {
	DListElement<T> *iterator = _first;
	DListElement<T> *to_delete = _first;

	while (iterator != NULL) {
		to_delete = iterator;
		iterator = iterator->getNext();

		delete to_delete;
	}
}

template <typename T>
void DList<T>::append(T *data) {
	DListElement<T> *element = new DListElement<T>(data);

	if (_first == NULL) {
		_first = element;
		_last = element;
	}
	else {
		_last->setNext(element);
		element->setPrev(_last);

		_last = element;
	}
}
