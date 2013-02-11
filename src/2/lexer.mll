{
  open Lexing
  open Parser        (* The type token is defined in parser.mli *)
  open Declaration
  exception Eof

  let error msg = raise (Failure msg)

  (* Scoreboard *)
  type scoreboard =
      { mutable skipped: string;
	mutable reports: (int * string) list }

  let board : scoreboard = 
    { skipped = "";
      reports = [] }

  let log_level = 6

  let log level memo  =
    board.reports <-
      (10, "Skipped "^board.skipped)::(level, memo)::board.reports;
    if board.skipped <> "" then print_endline ("Skipped "^board.skipped);
    board.skipped <- "";
    if level >= log_level then print_endline memo
      
  let skip c =
    board.skipped <- board.skipped^(String.make 1 c)
      
  let report () =
    let lines = 
      List.fold_right (fun (_,s) acc -> acc^"\n  "^s) board.reports "  " in
    print_endline ("History:"^lines)

  (* State *)
  let state : (lexbuf -> unit) list ref = ref []

  let continue lexbuf =
    match !state with
	[] -> error "Empty stack"
      | (hd::_) -> hd lexbuf

  let goto s =
    state := s::(!state)

  let break () =
    match !state with
	[] -> error "Empty stack"
      | (_::tl) ->
	state :=  tl

  (* Sexp *)

  let construct_fun_dec name args ret =
    let rec interc s = function
      | []       -> ""
      | [last]   -> last
      | (hd::tl) -> hd ^ s ^ (interc s tl) in
    "val "^name^" : "^(interc " -> " (List.rev (ret::args)))

  (* Util *)

  let rec interc s = function
    | []       -> ""
    | [last]   -> last
    | (hd::tl) -> hd ^ s ^ (interc s tl)
      
  let eof () = log 0 "eof"; exit 0

}

(* This aspect of the lexer has been developed to incrementally parse the abc.h
 * header file. To avoid the complexity of a full C parser, extension of
 * functional coverage is restricted to providing coverage of the abc.h header 
 * file only.  *)

let otherwise = _ as char

let whitespace = ['\n' ' ' '\t']
let ws  = whitespace*
let ws1 = whitespace+

let integer = ['0'-'9']+
let int = integer as i

let identifier = ['a'-'z' 'A'-'Z' '0'-'9' '_']+
let ident = identifier as id

let not_brackets = [^'{' '}']

let line_comment = "//" [^'\n']* '\n'
let block_comment = "/*" ([^'*'] | ('*' [^'/']))* "*/" (* minimal cover *)

(* The following define the major effective structures in abc.h *)
let start_enum       = "typedef" ws "enum" ws "{"
let start_typedef    = "typedef"
let start_struct     = "struct" ws ident ws
let start_fun_dec = ("static inline" | "extern ABC_DLL")
let start_block      = '{'

let end_enum       = ws '}'
let end_typedef    = ident ws ';'
let end_struct     = '}' ws ';'
let end_fun_dec    = ')' ws ';'?
let end_block      = '}'

let open_type_spec = (identifier | '*')
let typed_ident = ((open_type_spec ws)+ as typ) ws1 ident

let escape_n = '\\' '\n'
let macro = '#' ( ws escape_n | [^'\n'])*

rule token = parse
    ws1              {  }
|   line_comment     {  }
|   block_comment    {  }
|   macro            {  }
|   start_enum       { log 6 "(TypeDef\n  (Enum("; goto typedef; goto enum }
|   start_typedef    { log 3 "Typedef"; goto typedef }
|   start_struct ';' { log 4 ("Struct "^id) }
|   start_struct '{' { log 5 ("Struct "^id); goto structure }
|   start_fun_dec    { goto fun_dec }
|   otherwise        {  }
|   eof              { eof () }
and enum = parse
    ws1                            {  }
|   line_comment                   {  }
|   block_comment                  {  }
|   macro                          {  }
|   ident ws line_comment end_enum { log 6 ("    ("^id^"()))))");
		                     break () }
|   ident ws '=' ws int ws ',' { log 6 ("    ("^id^"("^i^"))") }
|   ident end_enum { log 6 ("    ("^id^"()))))");
		     break () }
|   ident ws ','   { log 6 ("    ("^id^"())") }
|   otherwise      { skip char }
|   eof            { eof () }
and typedef = parse
    ws          {  }
|   "struct"    {  }
|   end_typedef { log 2 ("Identifier "^id);
		  log 2 "Semi"; break () }
|   ident       { log 2 ("Identifier "^id) }
|   otherwise   { skip char }
|   eof         { eof () }
and structure = parse
    ws           {  }
|   line_comment {  }
|   "int nObjCounts[ABC_OBJ_NUMBER];"
                 { log 3 ("Member nObjCounts (NTuple ABC_OBJ_NUMBER int)") }
|   typed_ident ws ':' ws int ws ';'
	         { log 4 ("Bitfield "^i^" "^id^" "^typ) }
|   typed_ident ws ';' { log 3 ("Member "^id^" "^typ) }
|   end_struct         { log 3 "RBrackSemi"; break () }
|   otherwise          { skip char }
|   eof                { eof () }
and fun_dec = parse
|   ws typed_ident ws "(" ws end_fun_dec
                          { log 5 ("val "^id^" : () -> "^typ);
	   		    break () }
|   ws typed_ident ws "(" { parameters id [] typ lexbuf }
|   otherwise             { skip char }
|   eof                   { eof () }
and parameters name acc ret = parse
    ws                { parameters name acc ret lexbuf }
|   ws typed_ident ws ","
                      { parameters name (typ::acc) ret lexbuf }
|   ws "word r[2]" ws end_fun_dec 
                      { let typ = (interc " -> " (List.rev (ret::"word *"::acc))) in
	 		log 5 ("val "^name^" : "^typ);
			break () }
|   ws typed_ident ws end_fun_dec
                      { let dec = construct_fun_dec name (typ::acc) ret in
	 		log 5 dec;
			break () }
|   otherwise         { skip char; parameters name acc ret lexbuf }
|   eof               { eof () }
and nested_block = parse
    not_brackets {  }
|   start_block  { goto nested_block }
|   end_block    { break ()  }
|   otherwise    { skip char }
|   eof          { eof ()    }

{

  let _ =
    let lexbuf = from_channel stdin in
    goto token;
    while true do continue lexbuf done
    

}
