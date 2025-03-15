import struct

def fth(f):
    return hex(struct.unpack('<I', struct.pack('<f', f))[0])[2:]

re0, im0, dre0, dim0 = -2, -1, 3/640, 2/480
re1, im1, dre1, dim1 = -0.68, -0.72, (-0.4 - -.68) / 640, (-0.5 - -0.72) / 480

for i in range(10):
    t = i/9
    re = (1-t)*re0 + t*re1
    im = (1-t)*im0 + t*im1
    dre = (1-t)*dre0 + t*dre1
    dim = (1-t)*dim0 + t*dim1
    print(f'when {i} => re0 <= x"{fth(re)}"; im0 <= x"{fth(im)}"; inc_re <= x"{fth(dre)}"; inc_im <= x"{fth(dim)}";')
