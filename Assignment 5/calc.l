%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}
%%
printf				   {return print;}
"exit"				   {return exit_command;}
[a-zA-Z]			   {yylval.id = yytext[0]; return identifier;}
\( return LPAREN_TOK;
\) return RPAREN_TOK;
\{ return LCURLY_TOK;
\} return RCURLY_TOK;
, return COMMA_TOK;
int return INT;
float return FLOAT;
char return CHAR;
void return VOID;
double return DOUBLE;
main return MAIN_TOK;
[0-9]+                 {yylval.num = atoi(yytext); return number;}
[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)                {yylval.d = atof(yytext); return double_num;}
['][a-zA-Z][']				{yylval.c=yytext[0]; return charac;}
[ \t\n]                ;
[-+=;]           	   {return yytext[0];}




"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">" return GT;
"<" return LT;
for     return FOR;
while   return WHILE;
if  return IF;
else    return ELSE;
%%
int yywrap (void) {return 1;}

