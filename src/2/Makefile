.PHONY : clean

all : parser.cmo lexer.cmo
	ocamlc -o ../../stage-2 parser.cmo lexer.cmo

lexer.cmo : lexer.mll
	ocamllex lexer.mll
	ocamlc -c lexer.ml

parser.cmo : parser.mly
	ocamlyacc parser.mly
	ocamlc -c parser.mli parser.ml

clean :
	-rm ../../stage-2 *.cm* *.ml *.mli