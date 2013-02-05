
open C

let c_Abc_NtkType_t =
  ([TypeSpecifier
       (Typedef "c_Abc_NtkType_t");
    TypeSpecifier 
      (Enum 
	 (EnumDef 
	    (None,
	     [Valued ("ABC_NTK_NONE",0);
	      Simple "ABC_NTK_NETLIST";
	      Simple "ABC_NTK_LOGIC";
	      Simple "ABC_NTK_STRASH";
	      Simple "ABC_NTK_OTHER"])))],[])
