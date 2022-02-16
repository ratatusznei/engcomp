#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <utility>
using namespace std;

template<typename T> class BinTree {
	class Node {
	public:
		T value;
		Node *left;
		Node *right;

		Node(const T val) : value(val), left(nullptr), right(nullptr) { }
		~Node() {
			if (left) delete left;
			if (right) delete right;
		}

		static void insert_on_node (Node* node, const T& value) {
			if (value > node->value) {
				if (node->right == nullptr) {
					node->right = new Node{value};
				} 
				else {
					Node::insert_on_node(node->right, value);
				}
			} 
			else {
				if (node->left == nullptr) {
					node->left = new Node{value};
				}
				else {
					Node::insert_on_node(node->left, value);
				}
			}
		}

		static bool search_on_node(Node* node, const T& value) {
			if (node == nullptr) {
				return false;
			}
			else if (node->value == value) {
				return true;
			}
			else if (value > node->value) {
				return Node::search_on_node(node->right, value);
			}
			else {
				return Node::search_on_node(node->left, value);
			}
		}

		static Node* remove_on_node(Node *node, const T& value) {
			if (node == nullptr) {
				return nullptr;
			}
			else if (value == node->value) {
				if (node->left && node->right) {
					Node *cursor = node->left;
					while (cursor && cursor->right) {
						cursor = cursor->right;
					}

					swap(node->value, cursor->value);

					node->left = Node::remove_on_node(node->left, value);
					return node;
				}
				else if (node->left) {
					auto left = node->left;
					node->left = nullptr;
					delete node;
					return left;
				}
				else if (node->right) {
					auto right = node->right;
					node->right = nullptr;
					delete node;
					return right;
				}
				else {
					return nullptr;
				}
			}
			else if (value > node->value) {
				node->right = Node::remove_on_node(node->right, value);
				return node;
			}
			else {
				node->left = Node::remove_on_node(node->left, value);
				return node;
			}
		}

		void print() const {
			if (left == nullptr && right == nullptr) {
				cout << value;
				return;
			}

			cout << '(' << value;
			if (left) {
				cout << ' ';
				left->print();
			} 
			else {
				cout << u8" ⏚ ";
			}
			if (right) {
				cout << ' ';
				right->print();
			} 
			else {
				cout << u8" ⏚ ";
			}

			cout << ')';
		}
	};

	Node *root;

public:
	BinTree() : root(nullptr) {}
	~BinTree() { 
		delete root;
	}

	void print() {
		root->print();
		cout << endl;
	}

	// insert
	void operator+=(const T& value) {
		if (root == nullptr) {
			root = new Node{value};
		}
		else {
			Node::insert_on_node(root, value);
		}
	}

	// search
	bool operator()(const T& value) {
		return Node::search_on_node(root, value);
	}

	// remove
	void operator-=(const T& value) {
		root = Node::remove_on_node(root, value);
	}
};

int main() {
	BinTree<int> tree;

	tree += 5;
	tree += 2;
	tree += 4;
	tree += 8;
	tree += 3;

	tree.print();
	tree -= 5;
	tree.print();

	for (int i = 1; i <= 10; i++) {
		string res = tree(i)? "tem": "nao tem";
		cout << res << ' ' << i << endl;
	}
}
