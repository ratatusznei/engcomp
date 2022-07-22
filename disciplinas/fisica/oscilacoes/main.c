/*
	Por:
		Fernando Henrique Ratusznei Caetano
*/

#include <SDL.h>

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <unistd.h>

#include "Sistema.h"

#define FPS 24
#define DELTA_T (1.0 / FPS)

#define SCREEN_NAME "Modos normais"
#define SCREEN_W 700
#define SCREEN_H 400

int initWindow (SDL_Renderer **ren);

int main (int argc, char *argv[]) {
	Sistema *sis = malloc(sizeof(Sistema));
	int ys[N_MASSES];
	for (int i = 0; i < N_MASSES; ++i) {
		ys[i] = 200;
	}

	for (int i = 1*N_MASSES/5; i < 2*N_MASSES/5; ++i) {
		double x = i - 2*N_MASSES/5.;
		double T = N_MASSES/5.;
		ys[i] = 200 - 100*sin(acos(-1)*x/T)*sin(acos(-1)*17*x/T);
	}
	for (int i = 3*N_MASSES/5; i < 4*N_MASSES/5; ++i) {
		double x = i - 2*N_MASSES/5.;
		double T = N_MASSES/5.;
		ys[i] = 200 + 100*sin(acos(-1)*x/T)*sin(acos(-1)*7*x/T);
	}


	SDL_Renderer *ren;
	SDL_Event event;
	int quit = 0;

	if (!initWindow(&ren)) {
		fprintf(stderr, "Erro ao criar janela\n");

		SDL_Quit();
		free(sis);
		return 1;
	}

	initSistema(sis, SCREEN_W, SCREEN_H / 2, ys);

	clock_t last_time = clock();
	clock_t now;

	double render_delta = 0;
	double exec_time = 0;
	while (!quit) {
		now = clock();
		double delta = ((double) now - last_time) / CLOCKS_PER_SEC;
		updateSistema(sis, delta);
		last_time = now;

		render_delta += delta;
		if (render_delta > DELTA_T) {
			exec_time += render_delta;
			render_delta = 0;

			printf("Tempo de simulacao: %.2lfs\r", exec_time);
			fflush(stdout);

			SDL_SetRenderDrawColor(ren, 0xFF, 0xFF, 0xFF, 0);
			SDL_RenderClear(ren);
			drawSistema(ren, sis);

			if (SDL_PollEvent(&event)) {
				if (event.type == SDL_QUIT) { quit = 1; }
				if (event.type == SDL_KEYDOWN) {
					SDL_Keycode key = event.key.keysym.sym;
					if (key == SDLK_q) { quit = 1; }
				}
			}

			SDL_RenderPresent(ren);
		}
	}

	SDL_Quit();
	free(sis);
	return 0;
}

int initWindow (SDL_Renderer **ren) {
	if (SDL_Init(SDL_INIT_VIDEO) != 0){
		fprintf(stderr, "SDL_Init");
		return 1;
	}

	SDL_Window *win = SDL_CreateWindow(
		SCREEN_NAME,
		150, 150,
		SCREEN_W, SCREEN_H,
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
}
