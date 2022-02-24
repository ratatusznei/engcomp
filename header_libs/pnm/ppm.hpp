#ifndef _PPM_HPP
#define _PPM_HPP

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

struct Color { 
	int r; 
	int g;
	int b;

	Color(int red, int green, int blue):
		r(red),
		g(green),
		b(blue) { }
	Color(double gray): Color(gray, gray, gray) {} 
	Color(): r(0), g(0), b(0) {}
};

class PPM_writer {
	static const string magic_number;
	ofstream fs;
	int width;
	int heigth;
	int max;
	vector<Color> buffer;

public:
	PPM_writer(string filename, int w, int h):
		fs(filename, ios::out | ios::binary | ios::trunc),
		width(w),
		heigth(h), 
		max(255),
		buffer(w*h)
	{ }

	void write() {
		fs << magic_number << width << ' ' << heigth << '\n' << max << '\n';
		for (auto p: buffer) {
			fs << p.r << ' ' << p.g << ' ' << p.b << ' ';
		}
	}

	inline Color& at(int x, int y) {
		return buffer.at(x + y*width);
	}

	inline Color& operator[](pair<int,int> coord) {
		return buffer[coord.first + coord.second*width];
	}

	~PPM_writer() {
		write();
		fs.close();
	}
};

const string PPM_writer::magic_number{"P3"};

#endif /* _PPM_HPP */
