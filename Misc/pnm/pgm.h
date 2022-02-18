#ifndef _PGM_H
#define _PGM_H

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define PGM_MAGIT "P5"

typedef struct Pgm {
	char magic[3];
	/* whitespace */
	int width;
	/* whitespace */
	int height;
	/* whitespace */
	int maxval;
	/* whitespace */
	int *raster;
} Pgm;

Pgm *pgm_open (FILE *file) {
	if (file == NULL) {
		return NULL;
	}

	Pgm *ppgm = (Pgm *) malloc(sizeof(Pgm));

	fgets(ppgm->magic, 3, file);
	fscanf(file, " %d", &ppgm->width);
	fscanf(file, " %d", &ppgm->height);
	fscanf(file, " %d ", &ppgm->maxval);

	const int n = ppgm->width * ppgm->height;
	const int single = ppgm->maxval < 256;
	ppgm->raster = (int *) malloc(sizeof(int) * n);

	if (single) {
		for (int i = 0; i < n; i++) {
			ppgm->raster[i] = fgetc(file);
		}
	}
	else {
		for (int i = 0; i < n; i++) {
			int c1 = fgetc(file);
			int c2 = fgetc(file);
			ppgm->raster[i] = (c1 << 8) | (c2 & 0x0FF);
		}
	}

	return ppgm;
}

int *pgm_write (Pgm *ppgm, FILE *file) {
	const int n = ppgm->width * ppgm->height;
	const int single = ppgm->maxval < 256;

	fprintf(file, "%s\n%d %d %d\n", ppgm->magic, ppgm->width, ppgm->height, ppgm->maxval);

	if (single) {
		for (int i = 0; i < n; i++) {
			fputc(ppgm->raster[i] & 0x0FF, file);
		}
	}
	else {
		for (int i = 0; i < n; i++) {
			char c1 = ppgm->raster[i] >> 8;
			char c2 = ppgm->raster[i] & 0x0FF;
			fputc(c1, file);
			fputc(c2, file);
		}
	}

	return 0;
}

Pgm *pgm_new (int width, int height, int maxval) {
	Pgm *ppgm = (Pgm *) malloc(sizeof(Pgm));
	ppgm->magic[0] = PGM_MAGIT[0];
	ppgm->magic[1] = PGM_MAGIT[1];
	ppgm->magic[2] = PGM_MAGIT[2];
	ppgm->width = width;
	ppgm->height = height;
	ppgm->maxval = maxval;

	assert(maxval <= 255);

	const int n = width * height;
	ppgm->raster = (int *) malloc(sizeof(int) * n);

	for (int i = 0; i < n; i++) {
		ppgm->raster[i] = 0;
	}

	return ppgm;
}

void pgm_set(Pgm *ppgm, int x, int y, int c) {
	if (x < ppgm->width && y < ppgm->height) {
		ppgm->raster[x + y * ppgm->width] = c;
	}
}

int pgm_get(Pgm *ppgm, int x, int y) {
	if (x < ppgm->width || y < ppgm->height) {
		return ppgm->raster[x + y * ppgm->width];
	}
	else {
		return EOF;
	}
}

void pgm_close (Pgm *ppgm) {
	free(ppgm->raster);
	free(ppgm);
}

#endif /* _PGM_H */
