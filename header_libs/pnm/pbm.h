#ifndef _PBM_H
#define _PBM_H

#include <stdio.h>
#include <stdlib.h>

#define PBM_MAGIT "P4"

typedef struct Pbm {
	char magic[3];
	/* whitespace */
	int width;
	/* whitespace */
	int height;
	/* whitespace */
	char *raster;
} Pbm;

Pbm *pbm_open (FILE *file) {
	if (file == NULL) {
		return NULL;
	}

	Pbm *ppbm = (Pbm *) malloc(sizeof(Pbm));

	fgets(ppbm->magic, 3, file);
	fscanf(file, " %d", &ppbm->width);
	fscanf(file, " %d ", &ppbm->height);

	const int n = ppbm->width * ppbm->height;
	ppbm->raster = (char *) malloc(sizeof(char) * n);

	for (int i = 0; i < n ; i++) {
		const int c = fgetc(file);

		for (int bit = 0; bit < 8; bit++, i++) {
			ppbm->raster[i] = (c & (1 << bit)) != 0;
		}
	}

	return ppbm;
}

int *pbm_write (Pbm *ppbm, FILE *file) {
	const int n = ppbm->width * ppbm->height;

	fprintf(file, "%s\n%d %d\n", ppbm->magic, ppbm->width, ppbm->height);

	int x = 0;
	for (int i = 0; i < n;) {
		int c = 0;

		for (int bit = 0; bit < 8; bit++) {
			int fill = ppbm->raster[i] != 0;
			c |= (fill << (7 - bit));

			i++;
			x++;

			if (x >= ppbm->width) {
				x = 0;
				break;
			}
		}

		fputc(c, file);
	}

	return 0;
}

Pbm *pbm_new (int width, int height) {
	Pbm *ppbm = (Pbm *) malloc(sizeof(Pbm));
	ppbm->magic[0] = PBM_MAGIT[0];
	ppbm->magic[1] = PBM_MAGIT[1];
	ppbm->magic[2] = PBM_MAGIT[2];
	ppbm->width = width;
	ppbm->height = height;

	const int n = width * height;
	ppbm->raster = (char *) malloc(sizeof(char) * n);

	for (int i = 0; i < n; i++) {
		ppbm->raster[i] = 0;
	}

	return ppbm;
}

void pbm_set(Pbm *ppbm, int x, int y, char c) {
	if (x < ppbm->width && y < ppbm->height) {
		ppbm->raster[x + y * ppbm->width] = c;
	}
}

int pbm_get(Pbm *ppbm, int x, int y) {
	if (x >= ppbm->width || x >= ppbm->height) {
		return ppbm->raster[x + y * ppbm->width];
	}
	else {
		return EOF;
	}
}

void pbm_close (Pbm *ppbm) {
	free(ppbm->raster);
	free(ppbm);
}

#endif /* _PBM_H */
