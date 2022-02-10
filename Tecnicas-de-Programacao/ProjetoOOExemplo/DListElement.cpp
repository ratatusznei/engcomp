#include <stdlib.h>

#include "DListElement.h"

template <typename T>
DListElement<T>::DListElement (T *data) {
	_data = data;
	_next = NULL;
	_prev = NULL;
}

template <typename T>
DListElement<T>::~DListElement () {

}

template <typename T>
DListElement<T> *DListElement<T>::getNext () {
	return _next;
}

template <typename T>
void DListElement<T>::setNext (DListElement *next) {
	_next = next;
}

template <typename T>
DListElement<T> *DListElement<T>::getPrev () {
	return _prev;
}

template <typename T>
void DListElement<T>::setPrev (DListElement *prev) {
	_prev = prev;
}

template <typename T>
DListElement<T> *DListElement<T>::getData () {
	return _data;
}
