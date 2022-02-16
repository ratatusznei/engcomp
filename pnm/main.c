#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>

#include "ppm.h"
#include "draw.h"

int main (int argc, char **argv) {
	FILE *f = fopen("a.pbm", "wb");

	const int n = 400;
	Ppm *p = ppm_new(n, n, 255);

	const Rgb colors[] = {
		(Rgb) { .r = 255, .g =   0, .b =   0 },
		(Rgb) { .r =   0, .g = 255, .b =   0 },
		(Rgb) { .r =   0, .g =   0, .b = 255 },
		(Rgb) { .r = 255, .g = 255, .b =   0 },
		(Rgb) { .r = 255, .g =   0, .b = 255 },
		(Rgb) { .r =   0, .g = 255, .b = 255 },
	};

	Shape *shapes[] = {
		(Shape *) &(Rect) {
			.type = RECT,
			.x = 250, .y = 300, .w = 50, .h = 40,
		},
		(Shape *) &(Circle) {
			.type = CIRCLE,
			.cx = 120, .cy = 120, .r = 12,
		},
		(Shape *) &(Line) {
			.type = LINE,
			.x0 = 0, .y0 = 0, .x1 = n, .y1 = n / 2,
		},
		(Shape *) &(Line) {
			.type = LINE,
			.x0 = 0, .y0 = 0, .x1 = 300, .y1 = 3 * n / 4,
		},
	};

	for (int i = 0; i < (sizeof(shapes) / sizeof(Shape *)); i++) {
		draw(p, shapes[i], colors[rand() % (sizeof(colors) / sizeof(Rgb))]);
	}

	ppm_write(p, f);
	ppm_close(p);
	fclose(f);
	return 0;
}
