%{
#include<stdio.h>
#include<string.h>
#include "synt.tab.h"
#include"ts.h"
extern int nb_ligne;
extern int col;
extern YYSTYPE yylval;
%}
lettre[a-z]
chiffre [0-9]
idf {lettre}(_|{lettre}|{chiffre})*
cst_int [- ][1-9]{chiffre}*|0
cst_float [- ]{chiffre}+[.]{chiffre}+
Commentaire "/*"(.|\n)*"*/"|"//"(.|\n)*
%%
	/*mots Cles*/
Program {return mc_program;col=col+yyleng;}
PDEC {return mc_pdec;col=col+yyleng;}
PINST {return mc_pinst;col=col+yyleng;}
Begin {return mc_begin;col=col+yyleng;}
End {return mc_end;col=col+yyleng;} 
Pint {yylval.str = strdup("Pint"); return mc_pint;col=col+yyleng;}
Pfloat {yylval.str = strdup("Pfloat"); return mc_pfloat;col=col+yyleng;}
FOR {return mc_FOR;col+=yyleng;}
WHILE {return mc_WHILE;col+=yyleng;}
DO {return mc_DO;col+=yyleng;}
ENDFOR {return mc_ENDFOR;col+=yyleng;} 
IF {return mc_IF;col+=yyleng;}
ELSE {return mc_ELSE;col+=yyleng;}
ENDIF {return mc_ENDIF;col+=yyleng;}
"@define" {return mc_cst;col+=yyleng;}
{Commentaire} {col=col+yyleng;}
{cst_int} {yylval.num=atoi(yytext);col=col+yyleng;
		if ((atoi(yytext)<=32767)&&(atoi(yytext)>=-32768)){return cst_int;}
		else{printf("La valeur doit etre comprise entre 32767 et -32768\n");}}
{cst_float} {yylval.reel=atof(yytext);col=col+yyleng;return cst_float;}
{idf} {if (yyleng <= 12 & yytext[yyleng-1] != '_') {yylval.str=strdup(yytext);inserer(yytext,"idf");return idf;}
		else {printf("Erreur lexicale: l'IDF ne respecte pas les contraintes\n");col+=yyleng;}}

":" {return deux_points;col=col+yyleng;}
	/*affectation*/
"<--" {return AFFECTATION;col=col+yyleng;}

   /*operateurs arithmetiques*/
"(" {return par_ouv;col=col+yyleng;}
")"  {return par_ferm;col=col+yyleng;}
"+" {return ADDITION;col=col+yyleng;} 
"-" {return SOUSTRACTION;col=col+yyleng;}
"*" {return MULTIPLICATION;col=col+yyleng;} 
"/" {return DIVISION;col=col+yyleng;}
"=" {return EGAL;col=col+yyleng;}
   /*operateurs de comparaison*/
">" {return SUPERIEUR;col=col+yyleng;}
"<" {return INFERIEUR;col=col+yyleng;}
"==" {return DOUBLEEGAL;col=col+yyleng;}
"!=" {return DIFFERENT;col=col+yyleng;}
">=" {return SUPERIEUR_OU_EGAL;col=col+yyleng;}
"<=" {return INFERIEUR_OU_EGAL;col=col+yyleng;}

	/*operateurs logiques*/
"&" {return ET_LOGIQUE;col=col+yyleng;}
"|" {return OU_LOGIQUE;col=col+yyleng;} 
; {return pvg;col=col+yyleng;}
[,] {return vrg;col=col+yyleng;}

	/*tabulation et saut de ligne*/
[ \t] {col=col+yyleng;}
\n {nb_ligne++;col=0;}
. {printf("Erreur lexicale a la ligne %d et colonne %d sur l'entite %s\n",nb_ligne,col,yytext);
	return err;}
%%

