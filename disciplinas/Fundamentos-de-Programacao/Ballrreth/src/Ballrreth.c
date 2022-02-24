#include "Ballrreth.h"

int initBallrreth(SDL_Renderer **ren, SDL_Texture **tex,
  ball_t *balls, int n_balls, int box_w, int box_h) {
	if (SDL_Init(SDL_INIT_VIDEO) != 0){
		fprintf(stderr, "SDL_Init");
		return 1;
	}

	SDL_Window *win = SDL_CreateWindow(
		SCREEN_NAME,
		150, 150,
		box_w, box_h,
		SDL_WINDOW_SHOWN
	);
	if (!win) {
		fprintf(stderr, "SDL_CreateWindow\n");
		SDL_Quit();
		return 1;
	}

	*ren = SDL_CreateRenderer(
		win, -1,
		SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC
	);
	if (!*ren) {
		fprintf(stderr, "SDL_CreateRenderer\n");
		SDL_Quit();
		return 1;
	}

	/* Tenta carregar a imagem da bola
	   Se nao funcionar ele desenha e bolinha vermelha */
	SDL_Surface *bmp = SDL_LoadBMP("./data/ball_tex.bmp");
	*tex = NULL;

	if (bmp) {
		*tex = SDL_CreateTextureFromSurface(*ren, bmp);
		SDL_FreeSurface(bmp);
		if (!*tex) {
			fprintf(stderr, "SDL_Texture Error\n");
		}
	} else {
		fprintf(stderr, "SDL_LoadBMP\n");
	}

	srand(time(NULL));

	int i;
	for (i = 0; i < n_balls; i++) {
		int r = (double) (rand()) / RAND_MAX * (MAX_R - MIN_R) + MIN_R;
		int x = (double) (rand()) / RAND_MAX * (box_w - 2 * r) + r;
		int y = (double) (rand()) / RAND_MAX * (box_h - 2 * r) + r;

		int vx = (double) (rand()) / RAND_MAX * (MAX_V - MIN_V) + MIN_V;
		int vy = (double) (rand()) / RAND_MAX * (MAX_V - MIN_V) + MIN_V;

		balls[i] = *newBall(x, y, vx, vy, r);
	}

	return 0;
}

void updateBallrreth (ball_t *balls, int n_balls, int box_w, int box_h) {
	int i;
	int j;

	/* Move balls */
	for (i = 0; i < n_balls; i++) {
		balls[i].x += balls[i].vx;
		balls[i].y += balls[i].vy;

		collideBallBox(&balls[i], box_w, box_h);
	}

	/* Collide balls */
	for (i = 0; i < n_balls; i++) {
		for (j = i + 1; j < n_balls; j++) {
			collideBalls(&balls[i], &balls[j]);
		}
	}
}

void displayBallrreth (SDL_Renderer *ren, SDL_Texture *tex,
  ball_t *balls, int n_balls) {
	int i;

	SDL_SetRenderDrawColor(ren, 0xFF, 0xFF, 0xFF, 0);
	SDL_RenderClear(ren);

	SDL_SetRenderDrawColor(ren, 0xFF, 0, 0, 0);

	for (i = 0; i < n_balls; i++) {
		renderBall(ren, &balls[i], tex);
	}

	SDL_RenderPresent(ren);
}
