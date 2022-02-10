#pragma

template <typename Type>
class PilhaEn {
private:
	class Cell {
	private:
		Type data;
		Cell *prev;
	public:
		Cell (Type new_data, Cell *previous = NULL) {
			data = new_data;
			prev = previous;
		}

		Type getData () {
			return data;
		}

	 	Cell *getPrevious() {
			return prev;
		}
	};

	Cell *head;

public:
	PilhaEn () {
		head = NULL;
	}

	~PilhaEn () {
		while (!dequeue()) {
			/* Dequeues all elements */
		}
	}

	void enqueue (Type data) {
		Cell *new_cell;

		if (head == NULL) {
			new_cell = new Cell (data, NULL);
		}
		else {
			new_cell = new Cell (data, head);
		}

		head = new_cell;
	}

	bool dequeue () {
		if (head == NULL) {
			return 1;
		}

		Cell *new_head = head->getPrevious();

		delete head;
		head = new_head;

		return 0;
	}

	Type peek () {
		if (head != NULL) {
			return head->getData();
		}

		return (Type) 0;
	}

	bool isEmpty () {
		return head == NULL;
	}
};
