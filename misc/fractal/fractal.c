#include <termios.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <complex.h>
#include <string.h>
#include <assert.h>


/*      |-y
 * -x --+-- +x
 *      |+y
 */
#define LIMIT_LEFT   (-2.0)
#define LIMIT_RIGHT  ( 1.0)
#define LIMIT_TOP    (-1.0)
#define LIMIT_BOTTOM ( 1.0)

void render_fractal (double x, double dx, double y, double dy, double detail, const char *(*render_map)());

static const char *map_color (int level, int max) {
	static const char render_map[][10] = {
		"\x1b[40;37m ", "\x1b[40;37m.", "\x1b[40;37m:", "\x1b[40;37m-",
		"\x1b[40;37m=", "\x1b[40;37m+", "\x1b[40;37m*", "\x1b[40;37m@",

		"\x1b[41;34m ", "\x1b[41;34m.", "\x1b[41;34m:", "\x1b[41;34m-",
		"\x1b[41;34m=", "\x1b[41;34m+", "\x1b[41;34m*", "\x1b[41;34m@",

		"\x1b[42;33m ", "\x1b[42;33m.", "\x1b[42;33m:", "\x1b[42;33m-",
		"\x1b[42;33m=", "\x1b[42;33m+", "\x1b[42;33m*", "\x1b[42;33m@",

		"\x1b[43;32m ", "\x1b[43;32m.", "\x1b[43;32m:", "\x1b[43;32m-",
		"\x1b[43;32m=", "\x1b[43;32m+", "\x1b[43;32m*", "\x1b[43;32m@",

		"\x1b[44;31m ", "\x1b[44;31m.", "\x1b[44;31m:", "\x1b[44;31m-",
		"\x1b[44;31m=", "\x1b[44;31m+", "\x1b[44;31m*", "\x1b[44;31m@",

		"\x1b[45;36m ", "\x1b[45;36m.", "\x1b[45;36m:", "\x1b[45;36m-",
		"\x1b[45;36m=", "\x1b[45;36m+", "\x1b[45;36m*", "\x1b[45;36m@",

		"\x1b[46;35m ", "\x1b[46;35m.", "\x1b[46;35m:", "\x1b[46;35m-",
		"\x1b[46;35m=", "\x1b[46;35m+", "\x1b[46;35m*", "\x1b[46;35m@",

		"\x1b[47;30m ", "\x1b[47;30m.", "\x1b[47;30m:", "\x1b[47;30m-",
		"\x1b[47;30m=", "\x1b[47;30m+", "\x1b[47;30m*", "\x1b[47;30m@",
	};

	return render_map[(level * 64) / max];
}

static const char *map_grayscale (int level, int max) {
	static const char render_map[][10] = {
		"\x1b[40;37m ", "\x1b[40;37m.", "\x1b[40;37m\"", "\x1b[40;37m`", "\x1b[40;37m^", "\x1b[40;37m,",
		"\x1b[40;37m:", "\x1b[40;37m;", "\x1b[40;37mI",  "\x1b[40;37ml", "\x1b[40;37m!", "\x1b[40;37mi",
		"\x1b[40;37m~", "\x1b[40;37m+", "\x1b[40;37m_",  "\x1b[40;37m-", "\x1b[40;37m?", "\x1b[40;37m]",
		"\x1b[40;37m[", "\x1b[40;37m}", "\x1b[40;37m{",  "\x1b[40;37m",  "\x1b[40;37m1", "\x1b[40;37m)",

		"\x1b[40;37m(", "\x1b[40;37m|", "\x1b[40;37m\\", "\x1b[40;37m/", "\x1b[40;37mt", "\x1b[40;37mf",
		"\x1b[40;37mj", "\x1b[40;37mr", "\x1b[40;37mx",  "\x1b[40;37mn", "\x1b[40;37mu", "\x1b[40;37mv",
		"\x1b[40;37mc", "\x1b[40;37mz", "\x1b[40;37mX",  "\x1b[40;37mY", "\x1b[40;37mU", "\x1b[40;37mJ",
		"\x1b[40;37mC", "\x1b[40;37mL", "\x1b[40;37mQ",  "\x1b[40;37m0", "\x1b[40;37mO", "\x1b[40;37mZ",

		"\x1b[40;37mm", "\x1b[40;37mw", "\x1b[40;37mq", "\x1b[40;37mp", "\x1b[40;37md", "\x1b[40;37mb",
		"\x1b[40;37mk", "\x1b[40;37mh", "\x1b[40;37ma", "\x1b[40;37mo", "\x1b[40;37m*", "\x1b[40;37mM",
		"\x1b[40;37mW", "\x1b[40;37m&", "\x1b[40;37m8", "\x1b[40;37m%", "\x1b[40;37mB", "\x1b[40;37m@",
	};

	return render_map[(level * 66) / max];
}

static const char *map_black_white (int level, int max) {
	static const char render_map[][10] = {
		"\x1b[40;37m ", "\x1b[47;30m "
	};

	return render_map[(level * 2) / max];
}


struct termios term_orig;
void resetTerm () {
	tcsetattr(STDOUT_FILENO, TCSAFLUSH, &term_orig);
}

int main (int argc, char **argv) {
	const double DELTA_X = LIMIT_RIGHT - LIMIT_LEFT;
	const double X = LIMIT_LEFT + DELTA_X / 2.0;
	const double DELTA_Y = LIMIT_BOTTOM - LIMIT_TOP;
	const double Y = LIMIT_TOP + DELTA_Y / 2.0;
	const double DETAIL = argc < 2? 8: atof(argv[1]);

	long outbuff_size = 1024L * 1024L * 1024L * 1024L;
	char *outbuff = (char *) malloc(outbuff_size);

	double x = X;
	double dx = DELTA_X;
	double y = Y;
	double dy = DELTA_Y;
	double detail = DETAIL;
	char choice = '\0';
	const char *(*render_map)(int, int) = map_grayscale;

	struct termios term_info;
	tcgetattr(STDOUT_FILENO, &term_orig);
	term_info = term_orig;
	term_info.c_lflag &= ~(ECHO | ICANON);
	tcsetattr(STDOUT_FILENO, TCSAFLUSH, &term_info);
	atexit(resetTerm);

	while (choice != 'q' && choice != EOF) {
		fwrite("\x1b[H\x1b[J", 1, 6, stdout);
		render_fractal(x, dx, y, dy, detail, render_map);

	choicestart:
		choice = getchar();
		choice = choice >= 'A' && choice <= 'Z'? choice - 'A' + 'a': choice;
		putchar('\n');

		switch (choice) {
		case 'a': x -= dx / 10; break;
		case 'd': x += dx / 10; break;
		case 'w': y -= dy / 10; break;
		case 's': y += dy / 10; break;

		case 'i': dx /= 1.5; dy /= 1.5; detail *= 1.5; break;
		case 'o': dx *= 1.5; dy *= 1.5; detail /= 1.5; break;

		case 'c': render_map = map_color;       break;
		case 'g': render_map = map_grayscale;   break;
		case 'b': render_map = map_black_white; break;

		case '0':
			x = X;
			dx = DELTA_X;
			y = Y;
			dy = DELTA_Y;
			detail = DETAIL;
			break;

		case 'q': goto exit;
		default: goto choicestart;
		}
	}

 exit:
	free(outbuff);
	return 0;
}

static char count_steps (int max, long double real, long double imag) {
	int i;
	complex long double z = 0 + 0 * I;
	const complex long double c = real + imag * 1 * I;

	for (i = 0; i < max; i++) {
		z = z * z + c;

		int x = creal(z);
		int y = cimag(z);
		if ( x > LIMIT_RIGHT  || x < LIMIT_LEFT
		  || y > LIMIT_BOTTOM || y < LIMIT_TOP) {
			return i;
		}
	}

	return i;
}

void render_fractal (double x, double dx, double y, double dy, double detail, const char *(*render_map)()) {
	const long double CHARBOX_CORRECTION = 2.66;
	const long double STEPS_X = (CHARBOX_CORRECTION * dx * detail);
	const long double STEPS_Y = (dy * detail);

	int i;
	int j;
	int max = INT_MIN;

	int **outness_mat = (int **) malloc(sizeof(int *) * STEPS_Y);
	assert(outness_mat != NULL);

	for (i = 0; i < STEPS_Y; i++) {
		outness_mat[i] = (int *) malloc(sizeof(int) * STEPS_X);
		assert(outness_mat[i] != NULL);
	}

	for (i = 0; i < STEPS_Y; i++) {
		for (j = 0; j < STEPS_X; j++) {
			long double real = (j * dx / (long double) STEPS_X) + x - dx / 2.0;
			long double imag = (i * dy / (long double) STEPS_Y) + y - dy / 2.0;

			outness_mat[i][j] = count_steps(100, real, imag);

			if (outness_mat[i][j] > max - 1) max = outness_mat[i][j] + 1;
		}
	}

	for (i = 0; i < STEPS_Y; i++) {
		for (j = 0; j < STEPS_X; j++) {
			printf("%s", render_map(outness_mat[i][j], max));
		}
		puts("\x1b[40m");
	}
	puts("\x1b[40m");
	fflush(stdout);

	for (i = 0; i < STEPS_Y; i++) {
		free(outness_mat[i]);
	}
	free(outness_mat);
}
