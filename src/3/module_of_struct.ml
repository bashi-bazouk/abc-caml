
open Declaration
open Sexplib

  
(*let mli_of_struct (identifier: string) (elements: structure) : string =*)
  
let (^=) r s = r := (!r ^ s)
let  declaration = ref ""

let print s =
  print_string s;
  declaration ^= s

let id_of_element = function
  | Member   (id,_)   -> id
  | Bitfield (id,_,_) -> id

(* TODO type mappings (inductive now) *)

let myStruct = 
  ("Abc_Lib_t_",
   [Member ("pName", Pointer Char);
    Member ("pManFunc", Pointer Void);
    Member ("vTops", Pointer (Alias "Vec_Ptr_t"));
    Member ("tModules", Pointer (Alias "st__table"));
    Member ("pLibrary", Pointer (Alias "Abc_Lib_t"));
    Member ("pGenlib", Pointer Void)])


let record_of_struct (identifier, members) =
  let decl = ref "" in
  let add s = decl := !decl ^ s in
  let fake_map_type typ = "bool" in
  let rec nbits = function
    | 1 -> "boolean"
    | n -> "boolean, "^(nbits (n-1)) in
  let print_element = function
    | Member (id,typ)   -> add (id^": "^(fake_map_type typ))
    | Bitfield (id,_,n) -> add (id^": ("^(nbits n)^")") in
  let rec print_elements = function
    | (fst::(snd::tl)) -> 
      print_element fst; 
      add ";\n  ";
      print_elements (snd::tl)
    | hd::tl -> 
      print_element hd;
      add " }"
    | [] -> 
      add " }" in
  add ("type "^identifier^" = {\n  ");
  print_elements members;
  !decl

struct Abc_Lib_t_ 
{
    char *            pName;         // the name of the library
    void *            pManFunc;      // functionality manager for the nodes
    Vec_Ptr_t *       vTops;         // the array of top-level modules
    Vec_Ptr_t *       vModules;      // the array of modules
    st__table *       tModules;      // the table hashing module names into their networks
    Abc_Lib_t *       pLibrary;      // the library used to map this design
    void *            pGenlib;       // the genlib library used to map this design
};
