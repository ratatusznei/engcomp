#include "Massa.h"

Massa novaMassa (double m, int x, int y) {
	Massa t = {
		m, 
		x,
		y,
		0,
		0,
	};

	return t;
}

void aplicaForca (Massa *obj, double forca) {
	obj->ay += forca / obj->m; 
}

void updateMassa (Massa *obj, double delta_t) {
	obj->vy += obj->ay * delta_t;
	obj->y += obj->vy * delta_t;

	obj->ay = 0;
}

void drawMassa (SDL_Renderer *ren, Massa *obj) {
	return;
	Circle c = {
		obj->x, obj->y, MASS_R
	};

	drawCircle(ren, &c);
}
