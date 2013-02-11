
open Sexplib
open Sexplib.Std

type identifier = string with sexp

type compound_type =
  | Void | Char | Short | Int | Long | Float 
  | Double | Signed | Unsigned
  | Alias of identifier
  | Pointer of compound_type
  | Array of compound_type
  | Union of structure
  | Struct of structure
  | Enum of (identifier * int option) list
and element =
  | Member of identifier * compound_type
  | Bitfield of identifier * compound_type * int
and structure = element list with sexp

type declaration =
  | Synonym of identifier * identifier
  | TypeDef of compound_type * identifier
  | FuncDec of identifier * compound_type * compound_type list
  | TStruct of identifier * structure with sexp
