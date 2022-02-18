#ifndef _DRAW_H
#define _DRAW_H

#include "ppm.h"

typedef enum {
	RECT,
	CIRCLE,
	LINE,
} EShape;

typedef struct {
	EShape type;
} Shape;

typedef struct {
	EShape type;
	int x;
	int y;
	int w;
	int h;
} Rect;

typedef struct {
	EShape type;
	int cx;
	int cy;
	int r;
} Circle;

typedef struct {
	EShape type;
	int x0;
	int y0;
	int x1;
	int y1;
} Line;

void draw_rect (Ppm *p, Rect r, Rgb rgb) {
	const int x2 = r.x + r.w;
	const int y2 = r.y + r.h;

	for (int i = r.x; i < x2; i++) {
		for (int j = r.y; j < y2; j++) {
			ppm_set(p, j, i, rgb.r, rgb.g, rgb.b);
		}
	}
}

void draw_circle (Ppm *p, Circle c, Rgb rgb) {
	const int r2 = c.r * c.r;

	for (int i = 0; i < c.r; i++) {
		for (int j = 0; j < c.r; j++) {
			int d2 = i * i + j * j;

			if (d2 < r2) {
				ppm_set(p, c.cx + j, c.cy + i, rgb.r, rgb.g, rgb.b);
				ppm_set(p, c.cx + j, c.cy - i, rgb.r, rgb.g, rgb.b);
				ppm_set(p, c.cx - j, c.cy + i, rgb.r, rgb.g, rgb.b);
				ppm_set(p, c.cx - j, c.cy - i, rgb.r, rgb.g, rgb.b);
			}
		}
	}
}

void draw_line (Ppm *p, Line l, Rgb rgb) {
	int dx = l.x1 - l.x0;
	int dy = l.y1 - l.y0;

	if ((dx > 0? dx: -dx) >= (dy > 0? dy: -dy)) {
		if (dx >= 0) {
			for (int x = l.x0; x < l.x1; x++) {
				int y = l.y0 + dy * (x - l.x0) / dx;
				ppm_set(p, x, y, rgb.r, rgb.g, rgb.b);
			}
		}
		else {
			for (int x = l.x0 - 1; x >= l.x1; x--) {
				int y = l.y0 + dy * (x - l.x0) / dx;
				ppm_set(p, x, y, rgb.r, rgb.g, rgb.b);
			}
		}
	}
	else {
		if (dy >= 0) {
			for (int y = l.y0; y < l.y1; y++) {
				int x = l.x0 + dx * (y - l.y0) / dy;
				ppm_set(p, x, y, rgb.r, rgb.g, rgb.b);
			}
		}
		else {
			for (int y = l.y0 - 1; y >= l.y1; y--) {
				int x = l.x0 + dx * (y - l.y0) / dy;
				ppm_set(p, x, y, rgb.r, rgb.g, rgb.b);
			}
		}
	}
}

void draw (Ppm *p, Shape *s, Rgb rgb) {
	switch (s->type) {
	case RECT:
		draw_rect(p, *((Rect *) s), rgb);
		break;
	case CIRCLE:
		draw_circle(p, *((Circle *) s), rgb);
		break;
	case LINE:
		draw_line(p, *((Line *) s), rgb);
		break;
	}
}

#endif /* _DRAW_H */
