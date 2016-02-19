### Makefile for the C and Fortran implementations

CC = gcc
CFLAGS = -std=c99 -W -Wall -Wextra -pedantic -O3 -ffast-math -ftree-vectorize -fPIC
LDFLAGS = -shared
F2PY = f2py
F2PYFLAGS = --opt="-O3 -ffast-math -ftree-vectorize"


.PHONY: all

all: cernlib_c cernlib_f90_1 cernlib_f90_2 root_improvement root_improvement_fast root_improvement_sincos

cernlib_c:
	@echo "cernlib-c"
	$(CC) $(CFLAGS) $(LDFLAGS) cernlib-c/ErrorFunctions.c -o cernlib-c/wofz.so -lm

cernlib_f90_1:
	$(F2PY) $(F2PYFLAGS) -m wwerf -c cernlib-f90-1/erfr.f90; mv wwerf.so cernlib-f90-1

cernlib_f90_2:
	$(F2PY) $(F2PYFLAGS) -m wwerf2 -c cernlib-f90-2/errfff.f; mv wwerf2.so cernlib-f90-2

root_improvement:
	$(CC) $(CFLAGS) $(LDFLAGS) cernlib-root-adapted/erfc.c cernlib-root-adapted/wofz.c -o cernlib-root-adapted/liberfc.so

root_improvement_fast:
	$(CC) $(CFLAGS) $(LDFLAGS) cernlib-root-adapted/erfc.c cernlib-root-adapted/wofz.c -o cernlib-root-adapted/liberfc_fast.so -DFAST_IMPL

root_improvement_sincos:
	$(CC) $(CFLAGS) $(LDFLAGS) cernlib-root-adapted/erfc.c cernlib-root-adapted/wofz.c -o cernlib-root-adapted/liberfc_sincos.so -DSINCOS




clean:
	rm -f cernlib-c/*.so cernlib-f90-1/*.so cernlib-f90-2/*.so cernlib-root-adapted/*.so