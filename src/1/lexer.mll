{

}

let whitespace = [' ' '\t']
let ws  = whitespace*
let ws1 = whitespace+

let nl = ['\r' '\n']*
let nnl = [^'\n' '\r']

let wsnl = nl | ws

let empty = nl (whitespace | nl)* nl

let word = ['a'-'z' 'A'-'Z' '0'-'9' '_']+

let namespace_start = "ABC_NAMESPACE_HEADER_START"
let namespace_end = "ABC_NAMESPACE_HEADER_END"

let comment = "//" nnl* nl
let block_comment = "/*" ([^'*'] | ('*' [^'/']))* "*/"

let macro = "#" (nnl | ('\\' nl))+ nl
let cstruct = "struct" wsnl+ (word as id) wsnl+ '{'

let function_qualifier = "auto" | "register" | "static" | "extern" | "inline" | "EXTERN" | "local" | "const" | "ABC_DLL"

let eraseable = (function_qualifier | ('\\' nl) | block_comment)

let function_def = ((word ws '(' [^')']* ')') as decl) wsnl* '{'

rule skip = parse
    namespace_start { namespace lexbuf }
|   _               { skip lexbuf }
|   eof             {  }
and namespace = parse
    namespace_end     { skip lexbuf }
|   ';' nl*           { print_char '\n'; namespace lexbuf }
|   '=' [^';'] ';'    { namespace lexbuf }
|   "struct" ws (word as n) ws comment "{" 
                      { print_string ("struct "^n^" { ");
			pass_block lexbuf; 
			namespace lexbuf                          }
|   wsnl* '{'         { print_string " {"; pass_block lexbuf; namespace lexbuf }
|   macro ws          { print_char '\n'; namespace lexbuf }
|   comment           { print_char '\n'; namespace lexbuf }
|   eraseable ws      { namespace lexbuf }
|   ws1               { print_char ' '; namespace lexbuf}
|   function_def      { print_string decl; skip_block lexbuf; namespace lexbuf }
|   _ as c            { print_char c; namespace lexbuf }
|   eof               { raise (Failure "File ended before abc_namespace_end") }
and skip_block = parse
    '}' {  }
|   comment       { skip_block lexbuf }
|   block_comment { skip_block lexbuf }
|   '{'           { skip_block lexbuf; skip_block lexbuf }
|   _             { skip_block lexbuf }
and pass_block = parse
    '}'              { print_char '}' }
|   '{'              { print_char '{'; pass_block lexbuf; pass_block lexbuf }
|   "ABC_OBJ_NUMBER" { pass_block lexbuf }
|   comment          { pass_block lexbuf }
|   block_comment    { pass_block lexbuf }
|   ws1              { print_char ' '; pass_block lexbuf }
|   nl               { pass_block lexbuf }
|   _ as c           { print_char c; pass_block lexbuf }

{

  let _ = skip (Lexing.from_channel stdin)

}
