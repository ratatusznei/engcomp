#pragma once

template <typename T>
class DListElement {
private:
	DListElement *_next;
	DListElement *_prev;
	T *_data;
	
public:
	DListElement (T *data);
	~DListElement ();

	DListElement *getNext ();
	void setNext ();

	DListElement *getPrev ();
	void setPrev ();

	DListElement *getData ();
};
