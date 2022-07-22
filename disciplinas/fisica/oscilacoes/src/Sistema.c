#include "Sistema.h"

void initSistema (Sistema *sis, int width, int y0, int ys[N_MASSES]) {
	int i;

	for (i = 0; i < N_MASSES; i++) {
		sis->massas[i] = novaMassa(M, width * (i + 1.)/(N_MASSES+1), ys[i]);
	}

	sis->y0 = y0;
	sis->width = width;
}

void updateSistema (Sistema *sis, double delta_t) {
	int i;

	int y0 = sis->y0;

	aplicaForca(&(sis->massas[0]),
		K_LINHA * (
			(sis->massas[1].y - y0)
			- 2 * (sis->massas[0].y - y0)
		)
	);

	for (i = 1; i < N_MASSES - 1; i++) {
		aplicaForca(&(sis->massas[i]),
			K_LINHA * (
				(sis->massas[i - 1].y - y0)
				- 2 * (sis->massas[i].y - y0)
				+ (sis->massas[i + 1].y - y0)
			)
		);
	}

	aplicaForca(&(sis->massas[N_MASSES - 1]),
		K_LINHA * (
			(sis->massas[N_MASSES - 2].y - y0)
			- 2 * (sis->massas[N_MASSES - 1].y - y0)
		)
	);

	for (i = 0; i < N_MASSES; i++) {
		updateMassa(&(sis->massas[i]), delta_t);
	}
}

void drawSistema (SDL_Renderer *ren, Sistema *sis) {
	int i = 0;
	Line l;

	/* Cor das molas */
	SDL_SetRenderDrawColor(ren, 0, 0, 0, 0);

	l.x0 = 0;
	l.y0 = sis->y0;
	l.x1 = sis->massas[0].x;
	l.y1 = sis->massas[0].y;

	drawLine(ren, &l);

	for (i = 1; i < N_MASSES; i++) {
		l.x0 = sis->massas[i - 1].x;
		l.y0 = sis->massas[i - 1].y;
		l.x1 = sis->massas[i].x;
		l.y1 = sis->massas[i].y;

		drawLine(ren, &l);
	}

	l.x0 = sis->massas[N_MASSES - 1].x;
	l.y0 = sis->massas[N_MASSES - 1].y;
	l.x1 = sis->width;
	l.y1 = sis->y0;

	drawLine(ren, &l);

	/* Cor das Massas */
	SDL_SetRenderDrawColor(ren, 0xFF, 0, 0, 0);

	for (i = 0; i < N_MASSES; i++) {
		drawMassa(ren, &(sis->massas[i]));
	}
}
