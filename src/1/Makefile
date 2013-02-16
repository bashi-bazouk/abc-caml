.PHONY : clean

all : lexer.mll
	ocamllex lexer.mll
	ocamlc -o ../../stage-1 lexer.ml

clean :
	rm *.cm* lexer.ml ../../stage-1