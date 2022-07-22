#ifndef __MASSA_H
#define __MASSA_H

#include <SDL.h>
#include "Shapes.h"

#define MASS_R 5

typedef struct {
	double m;

	double x;
	
	double y;
	double vy;
	double ay;
} Massa;

Massa novaMassa (double m, int x, int y);

void aplicaForca (Massa *obj, double forca);

void updateMassa (Massa *obj, double delta_t);

void drawMassa (SDL_Renderer *ren, Massa *obj);

#endif /* __MASSA_H */
