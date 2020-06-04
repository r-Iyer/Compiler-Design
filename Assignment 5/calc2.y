%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
int symbols[52];
int scope[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val,int);
void updatescope(int);
extern FILE *yyin;
extern FILE *yyout;
%}

%union {int num; char id;}         /* Yacc definitions */
%start S
%token print
%token exit_command
%token <num> number
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

Type:   INT
    | FLOAT
    | CHAR
    | DOUBLE
    | VOID
    ;

new_assignment : Type identifier '=' exp  { updateSymbolVal($2,$4,0); }
            ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3,1); }
            ;
exp     : term                  {$$ = $1;}
        | exp '+' term          {$$ = $1 + $3;}
        | exp '-' term          {$$ = $1 - $3;}
        ;
term    : number                {$$ = $1;}
        | identifier            {$$ = symbolVal($1);} 
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
    idx = token - 'a' + 26;
    return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
    int bucket = computeSymbolIndex(symbol);
    return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val,int flag)
{
    int bucket = computeSymbolIndex(symbol);
    if(scope[bucket]!=-1&&flag==0)
    {printf("\n Already declared in scope \n");return;}
    symbols[bucket] = val;
    scope[bucket]=0;
}
void updatescope(int flag)
{
    for(int i=0; i<52; i++) {
    if(flag==0){
    if(scope[i]!=-1)
    scope[i]--;}
    else
    {if(scope[i]!=-1)
    scope[i]++;}}

}

int main (int argc,char *argv[]) {
    /* init symbol table */
    int i;
    for(i=0; i<52; i++) {
        symbols[i] = -1;
        scope[i]= -1;
    }
        int val;
    yyin=fopen(argv[1],"r");
    yyout = fopen(argv[2],"wb");

    return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

