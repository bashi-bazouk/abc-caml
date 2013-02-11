type identifier = string

type primitive =
    Void
  | Char
  | Short
  | Int
  | Long
  | Float
  | Double
  | Signed
  | Unsigned
  | Alias of identifier

type compound_type =
    Base of primitive
  | Pointer of compound_type
  | Array of compound_type
  | Union of structure
  | Struct of structure
  | Enum of enumeration
and element = identifier * (compound_type * int option) (* name, (reference_type, bit_width) *)
and structure   = element list
and atom    = identifier * int option
and enumeration = atom list

type declaration =
    Synonym of identifier * identifier
  | TypeDef of identifier * type_def
  | FuncDec of identifier * func_dec
  | TStruct of identifier * t_struct
and type_def = compound_type
and func_dec = compound_type * compound_type list
and t_struct = structure

type ('a, 'b) morphism = ('a, 'b) Hashtbl.t
type 'b lookup = (identifier, 'b) morphism

type synonyms = identifier list lookup (*  *)
type type_defs = type_def lookup
type func_decs = func_dec lookup
type structures = structure lookup 


type atoms    = atom morphism
type enumerations = enumeration lookup
val enumeration_of_atom : atom -> enumeration

type elements = element morphism
type structures   = structure lookup
val structure_of_element : element -> structure



val show_primitive : primitive -> string
val show_compound_type : compound_type -> string
val show_declaration : 'a -> string

