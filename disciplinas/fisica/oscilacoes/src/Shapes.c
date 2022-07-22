#include "Shapes.h"

void drawRect (SDL_Renderer *ren, Rect *rect) {
	int x = rect->x;
	int y = rect->y;

	int final_x = x + rect->w;
	int final_y = y + rect->h;

	while (y < final_y) {
		while (x < final_x) {
			SDL_RenderDrawPoint(ren, x++, y++);
		}

		x = rect->x;
	}
}

void drawCircle (SDL_Renderer *ren, Circle *circle) {
	int r = circle->r;
	int r2 = r * r;

	int x = circle->x;
	int y = circle->y;

	int dx;
	int dy;

	for (dy = 0; dy < r; dy++) {
		for (dx = dy; dx < r; dx++) {
			if (dx * dx + dy * dy <= r2) {
				SDL_RenderDrawPoint(ren, x + dx, y + dy);
				SDL_RenderDrawPoint(ren, x + dx, y - dy);
				SDL_RenderDrawPoint(ren, x - dx, y + dy);
				SDL_RenderDrawPoint(ren, x - dx, y - dy);

				SDL_RenderDrawPoint(ren, x + dy, y + dx);
				SDL_RenderDrawPoint(ren, x + dy, y - dx);
				SDL_RenderDrawPoint(ren, x - dy, y + dx);
				SDL_RenderDrawPoint(ren, x - dy, y - dx);
			}
		}
	}
}

void drawLine(SDL_Renderer *ren, Line *line) {
	SDL_RenderDrawLine(ren, line->x0, line->y0, line->x1, line->y1);
}
