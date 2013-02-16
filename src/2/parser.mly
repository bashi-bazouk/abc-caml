

%token EOL
%token TYPEDEF
%token STRUCT UNION
%token ENUM
%token <string> ALIAS
%token POINTER
%token LPR RPR        /* ( ) */
%token LBC RBC        /* [ ] */
%token LBK RBK        /* { } */
%token COMMA SEMI CLN
%token EQ
%token <int> INT
%start main
%type <unit> main

%%

main:
    EOL             {  }
  | c_type ALIAS LPR parameters RPR EOL {  }
  | TYPEDEF c_type ALIAS EOL {  }
  | TYPEDEF STRUCT ALIAS ALIAS EOL {  }
  | STRUCT ALIAS EOL {  }
  | STRUCT ALIAS LBK elements RBK EOL {  }
c_type:
  | ALIAS indirection   { }
  | ENUM LBK items RBK {  }
indirection:
                        { }
  | POINTER indirection { }
parameters:
    { }
  | parameters1 { }
parameters1:
  | c_type ALIAS COMMA parameters { }
  | c_type ALIAS COMMA LBC INT RBC parameters { }
  | c_type ALIAS { }
  | c_type ALIAS LBC INT RBC { }
elements:
  | c_type ALIAS { }
  | c_type ALIAS SEMI { }
  | c_type ALIAS SEMI { }
  | c_type ALIAS SEMI elements { }
  | c_type ALIAS LBC RBC SEMI elements{ }
  | c_type ALIAS CLN INT { }
  | c_type ALIAS CLN INT SEMI { }
  | c_type ALIAS CLN INT SEMI elements { }
  | UNION LBK elements RBK { }
  | UNION LBK elements RBK SEMI { }
  | UNION LBK elements RBK SEMI elements { }
items:
  | ALIAS { }
  | ALIAS COMMA { }
  | ALIAS EQ INT { }
  | ALIAS EQ INT COMMA { }
  | ALIAS COMMA items { }
  | ALIAS EQ INT COMMA items { }

%%
