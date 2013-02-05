open Frontc

let cabdefs =
  let args = [FROM_FILE "abc.pp.h";
	      INCLUDE_DIR "~/Desktop/abc/src";
	      OPTION "-std=c99";
	      USE_CPP;
	      PREPROC "/opt/local/bin/cpp"] in
  parse args
	      
