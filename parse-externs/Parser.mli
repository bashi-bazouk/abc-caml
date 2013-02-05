type token =
  | EXTERN
  | ABC_DLL
  | WORD
  | POINTER
  | LPAREN
  | RPAREN
  | COMMA
  | SEMICOLON
  | INT of (int)
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> int
