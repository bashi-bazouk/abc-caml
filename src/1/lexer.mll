{

  let files = ref ["base/abc/abc.h"]

}

let whitespace = ['\n' ' ' '\t']
let ws  = whitespace*
let ws1 = whitespace+

let namespace_start = "ABC_NAMESPACE_HEADER_START"
let namespace_end = "ABC_NAMESPACE_HEADER_END"
let macro_include = "#include" ws1 '"' ([^'"']* as file) '"'

rule skip = parse
    namespace_start { namespace lexbuf }
|   macro_include   { print_endline ("Including "^file);
		      files := !files@[file]; skip lexbuf}
|   _               { skip lexbuf }
|   eof             {  }
and namespace = parse
    namespace_end   { skip lexbuf }
|   _ as c          { print_char c }
|   eof             { raise (Failure "File ended before abc_namespace_end") }


{

  let _ = 
    while !files != [] do 
      match !files with
	| []       -> () (* impossible *)
	| hd::tl ->
	  files := tl;
	  skip (Lexing.from_channel (open_in ("/Users/Brian/Desktop/abc/src/"^hd)))
    done

}
