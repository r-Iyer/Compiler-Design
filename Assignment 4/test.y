%{
#include"lex.yy.c"
void yyerror(char *);
int scope=0;
%}

%token SEMICOLON_TOK
%token LCRLY_TOK
%token RCRLY_TOK
%token LPAREN_TOK
%token RPAREN_TOK
%token INT_TOK
%token MAIN_TOK
%token COMMA_TOK
%token ID_TOK


%start S




%%
S    :  datatype  MAIN_TOK LPAREN_TOK RPAREN_TOK BLOCK    {printf("Syntax for Main Function is Ok....\n");}
     ;

BLOCK: LCRLY_TOK  STATEMENTS  BLOCKS  RCRLY_TOK
     ;

BLOCKS: BLOCK STATEMENTS BLOCKS                                {}
      |
      ;

STATEMENTS:STATEMENTS  stmt
          |
          ;

stmt      :DECLARATION SEMICOLON_TOK       {}
          ;


DECLARATION:datatype id_token      {printf("Syntax of The Declaration Statement is Correct.....\n");}
           ;

datatype:  INT_TOK
        |
        ;

id_token: id_token COMMA_TOK ID_TOK          {}
        | ID_TOK                             {}
        ;



%%




int main()
{
   if (yyparse()==0) printf("Parsed Successfully\n");
   else printf("\nParsing Error at Line No %d\n", yylineno);

   return(0);	

}

void yyerror(char *s)
{
	printf("yyerror: %s\n",s);
}
