
%token EXTERN ABC_DLL LPAREN RPAREN COMMA SEMICOLON POINTER EOF
%token <string> ALIAS

%start main             /* the entry point */
%type <int> main
%%


main:
    EXTERN ABC_DLL ctype ALIAS LPAREN args RPAREN SEMICOLON { $1 }
;
ctype:
  ALIAS 
pointers arg:
      { arg }
  | POINTER { pointers (Pointer arg) lexbuf }
expr:
    INT                     { $1 }
  | LPAREN expr RPAREN      { $2 }
  | expr PLUS expr          { $1 + $3 }
  | expr MINUS expr         { $1 - $3 }
  | expr TIMES expr         { $1 * $3 }
  | expr DIV expr           { $1 / $3 }
  | MINUS expr %prec UMINUS { - $2 }
