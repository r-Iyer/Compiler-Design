%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val,int);
void updatescope(int);
int get_type(char);





struct node{
    int val;
    int type;
    int scope;
};
struct node symbols[26];
int type=-1,temp=-1,check=-1;
%}

%union {int num;char c; double d; char id;}         /* Yacc definitions */
%start S
%token print
%token exit_command
%token <num> number
%token <c> charac
%token <d> double_num
%token <id> identifier
%type <num> exp term 
%type <id> assignment
%token INT FLOAT CHAR DOUBLE VOID
%token MAIN_TOK COMMA_TOK
%token LPAREN_TOK RPAREN_TOK
%token LCURLY_TOK RCURLY_TOK

%left AND OR
%left LE GE EQ NE LT GT

%token FOR WHILE
%token IF ELSE PRINTF

%%

S    :  Type  MAIN_TOK LPAREN_TOK RPAREN_TOK  Block   {printf("Syntax for Main Function is Ok....\n");}
     ;
Block : LCURLY_TOK {updatescope(1);} StmtList RCURLY_TOK {updatescope(0);} 
        ; 
StmtList:   StmtList Stmt
    |
    ;
Stmt:   WhileStmt
    | Declaration
    | ForStmt
    | IfStmt
    | printfunc
    |Function
    | ';'
    ;

Declaration: new_assignment ';'
    | assignment ';'
    | FunctionCall ';'
    | error

    ;

Type:   INT {type=1;}
    | CHAR {type=2;}
    | DOUBLE {type=3;}
    | VOID
    ;

new_assignment : Type identifier '=' exp  { updateSymbolVal($2,$4,0); }
            ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3,1); }
			;
exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	;
term   	: number                {if(type!=1){yyerror("Type_check failed");$$ =-1;}else{$$ = $1;}}
        |charac                 {if(type!=2){yyerror("Type_check failed");$$ =-1;}else{$$ = $1;}}
        |double_num             {if(type!=3){yyerror("Type_check failed");$$ =-1;}else{$$ = $1;}}
		| identifier			{temp=get_type($1);if(check==-1)check=temp;if(temp!=check){yyerror("Type_check failed");check=-1;}else{$$ = symbolVal($1);}}
        ;

Function: Type identifier LPAREN_TOK ArgListOpt RPAREN_TOK Block
    ;
ArgListOpt: ArgList
    |
    ;
ArgList:  ArgList COMMA_TOK Arg
    | Arg
    ;
Arg:    Type identifier
    ;

FunctionCall : identifier LPAREN_TOK RPAREN_TOK
    | identifier LPAREN_TOK assignment RPAREN_TOK
    ;

WhileStmt: WHILE  LPAREN_TOK Expr  RPAREN_TOK Stmt
    | WHILE  LPAREN_TOK Expr  RPAREN_TOK Block
    ;
ForStmt: FOR  LPAREN_TOK Expr ';' Expr ';' Expr  RPAREN_TOK Stmt
       | FOR  LPAREN_TOK Expr ';' Expr ';' Expr  RPAREN_TOK Block
       | FOR  LPAREN_TOK Expr  RPAREN_TOK Stmt
       | FOR  LPAREN_TOK Expr  RPAREN_TOK Block
    ;
IfStmt : IF  LPAREN_TOK Expr  RPAREN_TOK Block
        |IF  LPAREN_TOK Expr  RPAREN_TOK Block ElseStmt
    ;
ElseStmt : ELSE Block

printfunc : print LPAREN_TOK  exp  RPAREN_TOK ';' {printf("Printing %d\n", $3);}
    ;

Expr:
    | Expr LE Expr
    | Expr GE Expr
    | Expr NE Expr
    | Expr EQ Expr
    | Expr GT Expr
    | Expr LT Expr
    | assignment
    | identifier
    | number
    ;

%%                     /* C code */


int computeSymbolIndex(char token)
{
	int idx = -1;
	idx = token - 'a';
	return idx;
} 
int get_type(char x)
{
    int b1 = computeSymbolIndex(x);
    return symbols[b1].type;
}
/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket].val;
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val,int flag)
{   
	int bucket = computeSymbolIndex(symbol);
    if(symbols[bucket].val!=-1&&flag==0)
    {printf("\n Already declared in scope \n");return;}

	symbols[bucket].val = val;
    symbols[bucket].scope=0;
    if(flag==0){
    symbols[bucket].type=type;
    type=-1;}
    //printf("Value: %d, Type: %d \n",symbols[bucket].val,symbols[bucket].type);

}
void updatescope(int flag)
{
    for(int i=0; i<26; i++) {
    if(flag==0){
    if(symbols[i].scope!=-1)
    symbols[i].scope--;}
    else
    {if(symbols[i].scope!=-1)
    symbols[i].scope++;}}

}

int main (void) {
	int i;
	for(i=0; i<26; i++) {
		symbols[i].val= -1;
        symbols[i].scope= -1;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

