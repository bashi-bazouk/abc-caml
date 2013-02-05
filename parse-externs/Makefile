all : Lexer.mll Parser.mly main.ml
	ocamllex Lexer.mll
	ocamlyacc Parser.mly
	ocamlc -c Parser.mli
	ocamlc -c Lexer.ml
	ocamlc -c Parser.ml
	ocamlc -c Main.ml
	ocamlc -o parse-externs Lexer.cmo Parser.cmo Main.cmo