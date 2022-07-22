#ifndef __SHAPES_H
#define __SHAPES_H

#include <SDL.h>

typedef struct {
	int x;
	int y;
	int w;
	int h;
} Rect;

typedef struct {
	int x;
	int y;
	int r;
} Circle;

typedef struct {
	int x0;
	int y0;
	int x1;
	int y1;
} Line;


void drawRect (SDL_Renderer *ren, Rect *rect);

void drawCircle (SDL_Renderer *ren, Circle *circle);

void drawLine (SDL_Renderer *ren, Line *line);

#endif /* __SHAPES_H */