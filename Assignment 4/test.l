%{
#include<stdio.h>
#include "y.tab.h"
%}

%%
;                                {return(SEMICOLON_TOK);}
,                                {return COMMA_TOK;        }
\{                               {return(LCRLY_TOK);}
\}                               {return(RCRLY_TOK);}
\(				                 {return(LPAREN_TOK);}
\)				                 {return(RPAREN_TOK);}
int                              {return(INT_TOK);}
main                             {return(MAIN_TOK);}
if                               {return(IF_TOK);}
else                               {return(ELSE_TOK);}
"="								{return(EQUAL_TOK);}
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">" return GT;
"<" return LT;

([a-z]|[A-Z])([a-z]|[A-Z]|[0-9])* {return (ID_TOK);}
([0-9])+ 						  {return (NUM_TOK);}
%%

/*
int main()
{
    int val;
    while((val = yylex()) > 0)
    {
        printf("Token ===%s; Token ID ====%d\n", yytext, val);
        
    }
    
    return(0);
}
 */
