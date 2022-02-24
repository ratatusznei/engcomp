#ifndef __BALL_H
#define __BALL_H

#include <stdlib.h>
#include <math.h>

#include <SDL.h>

typedef struct {
	int x;
	int y;
	double vx;
	double vy;
	int r;
} ball_t;

/* Instantiates a new ball
	@param: (x, y) pos, radius
*/
ball_t *newBall (int x, int y, double vx, double vy, int r);

/* Renders a red circle 
	@param: renderer, ball
*/
void renderBall (SDL_Renderer *ren, ball_t *ball, SDL_Texture *tex);

/* Checks if 2 balls are colliding 
	@param: ball 1, ball 2
	@return: bool
*/
int are2BallsColliding (ball_t *b1, ball_t *b2, int *dist);

/* Computes the colision with the box with the top left corner at (0, 0)
	@param: ball, box size
	@return: bool
*/
void collideBallBox (ball_t *ball, int box_w, int box_h);

/* Computes the collision between 2 balls
	@param: ball 1, ball 2
*/
void collideBalls (ball_t *b1, ball_t *b2);

#endif /* __BALL_H */

