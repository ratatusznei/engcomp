#include "Ball.h"

ball_t *newBall (int x, int y, double vx, double vy, int r) {
	ball_t *b = malloc(sizeof(ball_t));

	b->x = x;
	b->y = y;
	b->vx = vx;
	b->vy = vy;
	b->r = r;

	return b;
}

void renderBall (SDL_Renderer *ren, ball_t *ball, SDL_Texture *tex) {
	if (!tex) {
		int r2 = ball->r * ball->r;
		int dx;
		int dy;

		for (dy = 0; dy < ball->r; dy++) {
			for (dx = dy; dx < ball->r; dx++) {
				if (dx * dx + dy * dy <= r2) {
					SDL_RenderDrawPoint(ren,
						 ball->x + dx, ball->y + dy);
					SDL_RenderDrawPoint(ren,
						 ball->x + dx, ball->y - dy);
					SDL_RenderDrawPoint(ren,
						 ball->x - dx, ball->y + dy);
					SDL_RenderDrawPoint(ren,
						 ball->x - dx, ball->y - dy);

					SDL_RenderDrawPoint(ren,
						 ball->x + dy, ball->y + dx);
					SDL_RenderDrawPoint(ren,
						 ball->x + dy, ball->y - dx);
					SDL_RenderDrawPoint(ren,
						 ball->x - dy, ball->y + dx);
					SDL_RenderDrawPoint(ren,
						 ball->x - dy, ball->y - dx);
				}
			}
		}
	}
	else {
		SDL_Rect tex_rect;
		tex_rect.x = ball->x - ball->r;
		tex_rect.y = ball->y - ball->r;
		tex_rect.w = ball->r * 2;
		tex_rect.h = ball->r * 2;

		SDL_RenderCopy(ren, tex, NULL, &tex_rect);
	}
}

int are2BallsColliding (ball_t *b1, ball_t *b2, int *dist) {
	int dx = b2->x - b1->x;
	int dy = b2->y - b1->y;
	int r_maisr = b1->r + b2->r;

	*dist = dx * dx + dy * dy;

	return *dist <= (r_maisr * r_maisr);
}

void collideBallBox (ball_t *ball, int box_w, int box_h) {
	if (ball->x - ball->r < 0) {
		if (ball->vx < 0) {
			ball->vx = -ball->vx;
		}

		ball->x = 0 - ball->x + 2 * ball->r;
	}
	else if (ball->x + ball->r > box_w) {
		if (ball->vx > 0) {
			ball->vx = -ball->vx;
		}

		ball->x = 2 * box_w - ball->x - 2 * ball->r;
	}

	if (ball->y - ball->r < 0) {
		if (ball->vy < 0) {
			ball->vy = -ball->vy;
		}

		ball->y = 0 - ball->y + 2 * ball->r;
	}
	else if (ball->y + ball->r > box_h) {
		if (ball->vy > 0) {
			ball->vy = -ball->vy;
		}

		ball->y = 2 * box_h - ball->y - 2 * ball->r;
	}
}

void collideBalls (ball_t *b1, ball_t *b2) {
	int b;

	if (are2BallsColliding (b1, b2, &b)) {
		/* cc aponta da bola 2 para a bola 1 */
		int ccx = b1->x - b2->x;
		int ccy = b1->y - b2->y;
		double cc = 2 * sqrt(ccx * ccx + ccy * ccy);

		double proj1 = (b1->vx * ccx + b1->vy * ccy) /
			(double) (ccx * ccx + ccy * ccy);
		double proj2 = (b2->vx * ccx + b2->vy * ccy) /
			(double) (ccx * ccx + ccy * ccy);

		/* Inverte as velocidades no eixo dos centros */

		/* Primeiro subtrai do vetor a projecao da propria velicadade
		   e entao adiciona no vetor a projecao da velocidade da 
		   outra bola */

		/* V1 = V1 - proj (V1 em cc) + proj(V2 em cc) */
		b1->vx = b1->vx + (proj2 - proj1) * ccx;
		b1->vy = b1->vy + (proj2 - proj1) * ccy;

		/* V2 = V2 - proj (V2 em cc) + proj(V1 em cc) */
		b2->vx = b2->vx + (proj1 - proj2) * ccx;
		b2->vy = b2->vy + (proj1 - proj2) * ccy;

		/* Separa as bolas */
		/* b = intersecao = r1 + r2 - dist(centros)
		   Mover b/2 no eixo dos centros */

		b = (b1->r + b2->r - sqrt(b)) + 0.5;

		b1->x += ccx * b / cc;
		b1->y += ccy * b / cc;

		b2->x -= ccx * b / cc;
		b2->y -= ccy * b / cc;
	}
}
