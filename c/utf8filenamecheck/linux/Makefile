CC=gcc
CFLAGS=-O2 --machine-arch=native -pipe -Wall
LIBS=

# https://github.com/adamretter/utf8-validator-c
CFLAGS+=-Isimdutf8check/

all: utf8filenamecheck.c
	$(CC) $(CFLAGS) -o bin/utf8filenamecheck utf8filenamecheck.c $(LIBS)