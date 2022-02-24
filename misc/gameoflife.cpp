#include <iostream>
#include <vector>

struct P {
	bool alive;
	int ns;
};
using Screen = std::vector<P>;
constexpr int width = 70;
constexpr int height = 30;
constexpr char alive_char = '#';

void render(const Screen& s) {
	std::cout << '+';
	for (int i = 0; i < width; ++i) {
		std::cout << '-';
	}
	std::cout << '+' << std::endl;
	for (int y = 0; y < height; ++y) {
		std::cout << '|';
		for (int x = 0; x < width; ++x) {
			std::cout << (s.at(x + y*width).alive? alive_char: ' ');
		}
		std::cout << '|' << std::endl;
	}

	std::cout << '+';
	for (int i = 0; i < width; ++i) {
		std::cout << '-';
	}
	std::cout << '+' << std::endl;
}

int count_neighbours(const Screen& s, int x, int y) {
	int left = x - 1 >= 0? x - 1: width - 1;
	int right = x + 1 <= width - 1? x + 1: 0;
	int top = y - 1 >= 0? y - 1: height - 1;
	int bot = y + 1 <= height - 1? y + 1: 0;

	int c = 0;

	if (s.at(left + y*width).alive) ++c;
	if (s.at(left + top*width).alive) ++c;
	if (s.at(left + bot*width).alive) ++c;

	if (s.at(right + y*width).alive) ++c;
	if (s.at(right + top*width).alive) ++c;
	if (s.at(right + bot*width).alive) ++c;

	if (s.at(x + top*width).alive) ++c;
	if (s.at(x + bot*width).alive) ++c;

	return c;
}

void update(Screen& s) {
	for (int y = 0; y < height; ++y) {
		for (int x = 0; x < width; ++x) { 
			int c = count_neighbours(s, x, y);
			s.at(x + y*width).ns = c;
		}
	}

	for (int y = 0; y < height; ++y) {
		for (int x = 0; x < width; ++x) { 
			const int ns = s.at(x + y*width).ns;
			bool& alive = s.at(x + y*width).alive;

			if (alive && (ns < 2 || alive && ns > 3)) {
				alive = false;
			}
			else if (!alive && ns == 3) {
				alive = true;
			}
		}
	}
}

int main() {
	Screen screen(width * height, { false, 0 });

	screen.at(0 + 1*width).alive = true;
	screen.at(2 + 1*width).alive = true;
	screen.at(2 + 2*width).alive = true;
	screen.at(2 + 3*width).alive = true;
	screen.at(1 + 3*width).alive = true;

	render(screen);
	while (true) {
		getchar();
		update(screen);
		render(screen);
	}
}
