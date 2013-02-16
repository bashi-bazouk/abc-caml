{

  open Parser

}

let ws = [' ' '\t' '\r']*

let identifier = ['a'-'z' 'A'-'Z' '0'-'9' '_']+
let ident = identifier as id

let int = ['0'-'9']+ as i

rule main = parse
  ws         { main lexbuf }
| eof        { EOL         }
| "typedef"  { TYPEDEF     }
| "struct"   { STRUCT      }
| "union"    { UNION       }
| "enum"     { ENUM        }
| int        { INT (int_of_string i) }
| ident      { ALIAS id    }
| '*'        { POINTER     }
| '('        { LPR         }
| ','        { COMMA       }
| ')'        { RPR         }
| '{'        { LBK         }
| ':'        { CLN         }
| ';'        { SEMI        }
| '}'        { RBK         }
| '['        { LBC         }
| ']'        { RBC         }
| '='        { EQ          }
| _ as c    { raise (Failure ("lex error on"^(String.make 1 c))) }
{
    

  let _ =
    let failed = ref []
    and next () = input_line stdin in
    try
      while true do
	let line = next () in
	try
	  Parser.main main (Lexing.from_string line);
	  flush_all ()
	with
	  | _ -> failed := line::(!failed)
      done
    with
      | End_of_file -> 
	Printf.printf "\n%d Failures.\n" (List.length !failed);
	List.iter print_endline !failed;

}
