
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

declaration.cmo: declaration.ml
	ocamlfind ocamlc -package sexplib,sexplib.syntax -syntax camlp4o -linkpkg -c $<

dectop: declaration.cmo
	ocamlfind ocamlmktop -o dectop -package sexplib -linkpkg $<

PHONY: clean lextest

clean:
	-rm lexer.mli lexer.ml parser.mli parser.ml *.cmo *.cmi *~ a.out arch_flags

parser.cmo: parser.mly
	ocamlyacc parser.mly
	ocamlc -c parser.mli parser.ml

lexer.cmo: lexer.mll parser.cmo declaration.cmo
	ocamllex Lexer.mll
	ocamlc -c Lexer.ml

lextest: lexer.cmo
	ocamlc Lexer.ml -o lextest
	cat abc.h | ./lextest
	rm lextest

stage1: stage1.mll
	ocamllex stage1.mll
	ocamlc -o stage1 stage1.ml
	-./stage1
	-rm stage1