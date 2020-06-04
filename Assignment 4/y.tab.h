/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    SEMICOLON_TOK = 258,
    LCRLY_TOK = 259,
    RCRLY_TOK = 260,
    LPAREN_TOK = 261,
    RPAREN_TOK = 262,
    INT_TOK = 263,
    MAIN_TOK = 264,
    COMMA_TOK = 265,
    ID_TOK = 266,
    IF_TOK = 267,
    NUM_TOK = 268,
    AND = 269,
    OR = 270,
    LE = 271,
    GE = 272,
    EQ = 273,
    NE = 274,
    LT = 275,
    GT = 276
  };
#endif
/* Tokens.  */
#define SEMICOLON_TOK 258
#define LCRLY_TOK 259
#define RCRLY_TOK 260
#define LPAREN_TOK 261
#define RPAREN_TOK 262
#define INT_TOK 263
#define MAIN_TOK 264
#define COMMA_TOK 265
#define ID_TOK 266
#define IF_TOK 267
#define NUM_TOK 268
#define AND 269
#define OR 270
#define LE 271
#define GE 272
#define EQ 273
#define NE 274
#define LT 275
#define GT 276

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
