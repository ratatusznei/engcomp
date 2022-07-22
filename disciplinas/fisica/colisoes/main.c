/*
	Por: Fernando H. Ratusznei Caetano

	Bolinhas

*/

#include <stdio.h>
#include <time.h>

#include "Ballrreth.h"

#define N_ARGS 3
#define USAGE "Usage: %s <bolinhas> <largura> <altura>\n\n"

int main (int argc, char *argv[]) {
	if (argc != N_ARGS + 1) {
		fprintf(stderr, USAGE, argv[0]);
		return 1;
	}

	int n_balls = atoi(argv[1]);
	int width = atoi(argv[2]);
	int height = atoi(argv[3]);

	SDL_Renderer *ren;
	SDL_Texture *ball_tex;
	SDL_Event event;
	int quit = 0;

	clock_t start_time;
	
	ball_t *balls = malloc(n_balls * sizeof(ball_t));

	initBallrreth(&ren, &ball_tex, balls, n_balls, width, height);

	while (!quit) {
		start_time = clock();

		displayBallrreth(ren, ball_tex, balls, n_balls);
		updateBallrreth(balls, n_balls, width, height);

		if (SDL_PollEvent(&event)) {
			if (event.type == SDL_QUIT) {
				quit = 1;
			}
			if (event.type == SDL_KEYDOWN) {
				SDL_Keycode key = event.key.keysym.sym;

				if (key == SDLK_q) {
					quit = 1;
				}
			}
		}

		while (clock() - start_time < CLOCKS_PER_FRAME) {
			/* wait */
		}
	}

	SDL_Quit();
	return 0;
}
