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

open Parsing;;
let yytransl_const = [|
  257 (* EXTERN *);
  258 (* ABC_DLL *);
  259 (* WORD *);
  260 (* POINTER *);
  261 (* LPAREN *);
  262 (* RPAREN *);
  263 (* COMMA *);
  264 (* SEMICOLON *);
  266 (* PLUS *);
  267 (* MINUS *);
  268 (* TIMES *);
  269 (* DIV *);
  270 (* EOL *);
    0|]

let yytransl_block = [|
  265 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\003\000\003\000\003\000\002\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\002\000\000\000\009\000\000\000\000\000\
\008\000\000\000\000\000\000\000\000\000\001\000\003\000\000\000\
\000\000\006\000\007\000"

let yydgoto = "\002\000\
\006\000\007\000"

let yysindex = "\004\000\
\023\255\000\000\023\255\000\000\023\255\000\000\025\255\014\255\
\000\000\023\255\023\255\023\255\023\255\000\000\000\000\247\254\
\247\254\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\005\255\
\007\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255"

let yytablesize = 39
let yytable = "\008\000\
\000\000\009\000\012\000\013\000\001\000\000\000\016\000\017\000\
\018\000\019\000\004\000\000\000\005\000\000\000\004\000\004\000\
\005\000\005\000\004\000\015\000\005\000\000\000\000\000\010\000\
\011\000\012\000\013\000\003\000\000\000\000\000\000\000\004\000\
\000\000\005\000\010\000\011\000\012\000\013\000\014\000"

let yycheck = "\003\000\
\255\255\005\000\012\001\013\001\001\000\255\255\010\000\011\000\
\012\000\013\000\006\001\255\255\006\001\255\255\010\001\011\001\
\010\001\011\001\014\001\006\001\014\001\255\255\255\255\010\001\
\011\001\012\001\013\001\005\001\255\255\255\255\255\255\009\001\
\255\255\011\001\010\001\011\001\012\001\013\001\014\001"

let yynames_const = "\
  EXTERN\000\
  ABC_DLL\000\
  WORD\000\
  POINTER\000\
  LPAREN\000\
  RPAREN\000\
  COMMA\000\
  SEMICOLON\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIV\000\
  EOL\000\
  "

let yynames_block = "\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 18 "Parser.mly"
                            ( _1 )
# 110 "Parser.ml"
               : int))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 21 "Parser.mly"
                            ( _1 )
# 117 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 22 "Parser.mly"
                            ( _2 )
# 124 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 23 "Parser.mly"
                            ( _1 + _3 )
# 132 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 24 "Parser.mly"
                            ( _1 - _3 )
# 140 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 25 "Parser.mly"
                            ( _1 * _3 )
# 148 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 26 "Parser.mly"
                            ( _1 / _3 )
# 156 "Parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 27 "Parser.mly"
                            ( - _2 )
# 163 "Parser.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : int)
