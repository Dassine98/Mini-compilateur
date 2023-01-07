
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_program = 258,
     mc_pdec = 259,
     mc_pinst = 260,
     mc_begin = 261,
     mc_end = 262,
     pvg = 263,
     err = 264,
     vrg = 265,
     EGAL = 266,
     deux_points = 267,
     mc_cst = 268,
     mc_FOR = 269,
     mc_WHILE = 270,
     mc_DO = 271,
     mc_ENDFOR = 272,
     mc_IF = 273,
     mc_ELSE = 274,
     mc_ENDIF = 275,
     AFFECTATION = 276,
     par_ouv = 277,
     par_ferm = 278,
     ADDITION = 279,
     SOUSTRACTION = 280,
     MULTIPLICATION = 281,
     DIVISION = 282,
     SUPERIEUR = 283,
     INFERIEUR = 284,
     DOUBLEEGAL = 285,
     DIFFERENT = 286,
     SUPERIEUR_OU_EGAL = 287,
     INFERIEUR_OU_EGAL = 288,
     ET_LOGIQUE = 289,
     OU_LOGIQUE = 290,
     idf = 291,
     cst_int = 292,
     cst_float = 293,
     mc_pint = 294,
     mc_pfloat = 295
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 25 "synt.y"
 
	int num;
	float reel;
	char* str;	



/* Line 1676 of yacc.c  */
#line 100 "synt.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


