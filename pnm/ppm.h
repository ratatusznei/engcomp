#ifndef _PPM_H
#define _PPM_H

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define PPM_MAGIT "P6"

typedef struct {
	char r;
	char g;
	char b;
} Rgb;

typedef struct Ppm {
	char magic[3];
	/* whitespace */
	int width;
	/* whitespace */
	int height;
	/* whitespace */
	int maxval;
	/* whitespace */
	Rgb *raster;
} Ppm;

Ppm *ppm_open (FILE *file) {
	if (file == NULL) {
		return NULL;
	}

	Ppm *pppm = (Ppm *) malloc(sizeof(Ppm));

	fgets(pppm->magic, 3, file);
	fscanf(file, " %d", &pppm->width);
	fscanf(file, " %d", &pppm->height);
	fscanf(file, " %d ", &pppm->maxval);

	const int n = pppm->width * pppm->height;
	pppm->raster = (Rgb *) malloc(sizeof(Rgb) * n);

	for (int i = 0; i < n; i++) {
		pppm->raster[i].r = fgetc(file);
		pppm->raster[i].g = fgetc(file);
		pppm->raster[i].b = fgetc(file);
	}

	return pppm;
}

int *ppm_write (Ppm *pppm, FILE *file) {
	const int n = pppm->width * pppm->height;

	fprintf(file, "%s\n%d %d %d\n", pppm->magic, pppm->width, pppm->height, pppm->maxval);

	for (int i = 0; i < n; i++) {
		fputc(pppm->raster[i].r, file);
		fputc(pppm->raster[i].g, file);
		fputc(pppm->raster[i].b, file);
	}

	return 0;
}

Ppm *ppm_new (int width, int height, int maxval) {
	Ppm *pppm = (Ppm *) malloc(sizeof(Ppm));
	pppm->magic[0] = PPM_MAGIT[0];
	pppm->magic[1] = PPM_MAGIT[1];
	pppm->magic[2] = PPM_MAGIT[2];
	pppm->width = width;
	pppm->height = height;
	pppm->maxval = maxval;

	assert(maxval <= 255);

	const int n = width * height;
	pppm->raster = (Rgb *) malloc(sizeof(Rgb) * n);

	for (int i = 0; i < n; i++) {
		pppm->raster[i].r = 0;
		pppm->raster[i].g = 0;
		pppm->raster[i].b = 0;
	}

	return pppm;
}

void ppm_set(Ppm *pppm, int x, int y, char r, char g, char b) {
	if (x < pppm->width && y < pppm->height) {
		pppm->raster[x + y * pppm->width].r = r;
		pppm->raster[x + y * pppm->width].g = g;
		pppm->raster[x + y * pppm->width].b = b;
	}
}

Rgb ppm_get(Ppm *pppm, int x, int y) {
	if (x < pppm->width || y < pppm->height) {
		return (Rgb) {
			.r = pppm->raster[x + y * pppm->width].r,
			.g = pppm->raster[x + y * pppm->width].g,
			.b = pppm->raster[x + y * pppm->width].b,
		};
	}
	else {
		return (Rgb) { 0, 0, 0 };
	}
}

void ppm_close (Ppm *pppm) {
	free(pppm->raster);
	free(pppm);
}

#endif /* _PPM_H */
