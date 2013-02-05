(* File lexer.mll *)
{
  open Parser        (* The type token is defined in parser.mli *)
  exception Eof
}

let ws = [' ' '\t' '\n']
let alias = ~ws
let pointer = ['*']

rule declaration = 
  parse ws                       { token lexbuf }
      | "extern" ws "ABC_DLL" ws alias { c_type $5  }
      | '*'                 { POINTER      }
      | '('                 { LPAREN       }
      | ')'                 { RPAREN       }
      | alias               { ALIAS $1     }
      | eof                 { EOF          }



rule c_type base =
  parse pointer { }
