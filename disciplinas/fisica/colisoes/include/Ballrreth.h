#ifndef __BALLRRETH_H
#define __BALLRRETH_H

#include <stdlib.h>
#include <time.h>

#include <SDL.h>
#include "Ball.h"

#define MAX_R 40
#define MIN_R 40

#define MAX_V 5
#define MIN_V -5

#define FPS 60
#define CLOCKS_PER_FRAME (CLOCKS_PER_SEC / FPS)

#define SCREEN_NAME "Ballrreth"

int initBallrreth (SDL_Renderer **ren, SDL_Texture **tex,
	ball_t *balls, int n_balls, int box_w, int box_h);

void updateBallrreth (ball_t *balls, int n_balls, int box_w, int box_h);

void displayBallrreth (SDL_Renderer *ren, SDL_Texture *tex,
	ball_t *balls, int n_balls);

#endif /* __BALLRRETH_H */
