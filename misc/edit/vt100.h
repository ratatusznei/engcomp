#ifndef VT100_H
#define VT100_H

#define VT_CTRL(c) ((c) & (0xBF))

void vt_clear ();
void vt_goto (int, int);

#endif /* VT100_H */
