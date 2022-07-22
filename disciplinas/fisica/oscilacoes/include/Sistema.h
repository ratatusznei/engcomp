#ifndef __SISTEMA_H
#define __SISTEMA_H

#include <SDL.h>
#include "Shapes.h"
#include "Massa.h"

#define M .0005
#define K_LINHA 1
#define N_MASSES 500

typedef struct {
	Massa massas[N_MASSES];

	int y0;
	int width;
} Sistema;

void initSistema (Sistema *sis, int width, int y0, int ys[N_MASSES]);

void updateSistema (Sistema *sis, double delta_t);

void drawSistema (SDL_Renderer *ren, Sistema *sis);

#endif /* __SISTEMA_H */
