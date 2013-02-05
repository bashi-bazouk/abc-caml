
# CONFIGURE THESE VARIABLES
workspace = ~/Desktop/abc-bindings
abc_folder = ~/Desktop/abc
arch_flags = -DLIN64 -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8 -DSIZEOF_INT=4
CC := gcc

# DERIVED
abc_src_folder = $(abc_folder)/src
target = abc.h

ARCHFLAGS := $(shell $(CC) arch_flags.c -o $(workspace)/arch_flags && $(workspace)/arch_flags)


abc.pp.h: $(target)
	cpp $(ARCHFLAGS) -I $(abc_src_folder) -o $(workspace)/abc.pp.h $<

main: main.ml
	ocamlfind ocamlc -o main -package FrontC -linkpkg main.ml

all: C.ml
	ocamlc -c C.ml

test: main
	./main

declaration: declaration.ml
	ocamlfind ocamlc -package sexplib,sexplib.syntax -syntax camlp4o -linkpkg -c $<

PHONY: clean lextest

clean:
	-rm *.cmo
	-rm *.cmi
	-rm *~
	-rm a.out

Lexer.cmo: Lexer.mll 
	ocamllex Lexer.mll
	ocamlc -c Lexer.ml

lextest: Lexer.cmo
	ocamlc Lexer.ml -o lextest
	cat abc.h | ./lextest
	rm lextest