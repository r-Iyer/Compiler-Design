%{
#include<stdio.h>

#include "tokendef_LEX.h"
%}

%%
;                                {return(SEMICOLON_TOK);}
,                                {return COMMA_TOK;        }
\{                               {fprintf(yyout,"%s",yytext);}
\}                               {return(RCRLY_TOK);}
\(				                 {return(LPAREN_TOK);}
\)				                 {return(RPAREN_TOK);}
int                              {return(INT_TOK);}
float 							 {return(FLOAT_TOK);}
while 							 {return(WHILE_TOK);}
printf							 {return(PRINT_TOK);}
if 								 {return(IF_TOK);}
main                             {return(MAIN_TOK);}
scanf							 {return(SCAN_TOK);}

([a-z]|[A-Z])([a-z]|[A-Z]|[0-9])* {return (ID_TOK);}
%%

int main(int argc,char *argv[])
{
    int val;
    if(argc<3)
    exit(0);
    yyin=fopen(argv[1],"r");
    yyout = fopen(argv[2],"wb");

    while((val = yylex()) > 0)
    {
        printf("Token ===%s; Token ID ====%d\n", yytext, val);
       
    }
    
    return(0);
}