%{
#include<stdio.h>
#include<string.h>
int nb_ligne=1; 
int col=0;
char sauvType1[20], sauvNom[20], sauvNom2[20];
int t, val, a, op;
char recentVars[100][100];
int recentCount = 0;
int yyparse();
int yylex();
int yyerror(char *s);
int main();
int yywrap();
void afficher();
void insererType();
int doubleDeclaration();
void insererConstante();
int constOuPas();
int divSurZero();
int compatibiliteTypeVar();
int compatibiliteTypeVarB();
%}

%union { 
	int num;
	float reel;
	char* str;	
}

%token mc_program mc_pdec mc_pinst mc_begin mc_end pvg err vrg EGAL deux_points mc_cst
		mc_FOR mc_WHILE mc_DO mc_ENDFOR mc_IF mc_ELSE mc_ENDIF AFFECTATION par_ouv par_ferm <str> ADDITION <str> SOUSTRACTION <str> MULTIPLICATION
		<str> DIVISION SUPERIEUR INFERIEUR DOUBLEEGAL DIFFERENT SUPERIEUR_OU_EGAL INFERIEUR_OU_EGAL ET_LOGIQUE
		OU_LOGIQUE
%token <str> idf
%token <num> cst_int
%token <reel> cst_float
%token <str> mc_pint
%token <str> mc_pfloat


%left OU_LOGIQUE
%left ET_LOGIQUE
%left SUPERIEUR INFERIEUR DOUBLEEGAL DIFFERENT SUPERIEUR_OU_EGAL INFERIEUR_OU_EGAL
%left ADDITION SOUSTRACTION
%left MULTIPLICATION DIVISION


%start S
%%
S: ENTETE DECLARATION INSTRUCTION{printf("Programme syntaxiquement correcte");YYACCEPT;}
;
ENTETE:mc_program idf
;
DECLARATION:mc_pdec LISTE_DEC
;
LISTE_DEC: DEC LISTE_DEC
			|DEC_CST LISTE_DEC
			|
;
DEC:LISTEIDF deux_points TYPE pvg {for(int i=0; i<recentCount; i++){
      if(doubleDeclaration(recentVars[i]) != -1){
        insererType(recentVars[i],sauvType1);
      }else{
        printf("Erreur semantique a la ligne %d a la colonne %d : double declaration d'une variable '%s' \n",nb_ligne,col, recentVars[i]);
      }
    }
    recentCount = 0;}
;
DEC_CST:mc_cst TYPE idf EGAL CST pvg	{insererConstante($3); if(doubleDeclaration($3)==0) insererType($3,sauvType1);
								else printf("Erreur Semantique:double declaration de %s, a la ligne %d et colonne %d\n",$3,nb_ligne,col);}
;
LISTEIDF:idf OU_LOGIQUE LISTEIDF	{strcpy(recentVars[recentCount],$1);recentCount++;} 
		|idf	{strcpy(recentVars[recentCount],$1);recentCount++;}
;
TYPE: mc_pint	{strcpy(sauvType1,$1);}
	|mc_pfloat	{strcpy(sauvType1,$1);}
;
CST: cst_int	{a=1; val=$1;}
	|cst_float	{a=2; val=$1;}
;
INSTRUCTION:mc_pinst mc_begin LISTE_INST mc_end
;
LISTE_INST:AFF LISTE_INST
			|BOUCLE LISTE_INST
			|AFF_SP LISTE_INST
			|COND LISTE_INST
			|
;
AFF:idf AFFECTATION EXP_ARITH pvg
	{if(doubleDeclaration($1)==0) printf("Erreur Semantique: %s non declare, a la ligne %d, colonne %d\n",$1,nb_ligne,col);
	if(constOuPas($1)==1) printf("Erreur Semantique: la constante %s a deja une valeur, a la ligne %d, colonne %d\n",$1,nb_ligne,col);
	strcpy(sauvNom,$1);}
;
AFF_SP:idf AFFECTATION EXP_ARITH 
		{if(doubleDeclaration($1)==0) printf("Erreur Semantique: %s non declare, a la ligne %d, colonne %d\n",$1,nb_ligne,col);
		strcpy(sauvNom,$1);}
;
BOUCLE:mc_FOR AFF_SP mc_WHILE cst_int mc_DO LISTE_INST mc_ENDFOR
;
EXP_ARITH:OPERANDE OPERAR EXP_ARITH	{if(t == 0){if((op == 4) && ((val == 0) || (val == 0.0)))
										printf("Erreur Semantique: Division par zero, a la ligne %d, colonne %d\n",nb_ligne,col);
												else {if(compatibiliteTypeVar(sauvNom,a) == -1)
                            printf("Erreur semantique a la ligne %d a la colonne %d : incompatibilite de type de la variable dans affectation \n",nb_ligne,col);}}
									if(t == 1){
										if(compatibiliteTypeVarB(sauvNom,sauvNom2) == -1)
                    printf("Erreur semantique a la ligne %d a la colonne %d : incompatibilite de type de la variable dans affectation \n",nb_ligne,col);}}
			|EXP_ARITHP		{if(t == 0){if((op == 4) && ((val == 0) || (val == 0.0)))
										printf("Erreur Semantique: Division par zero, a la ligne %d, colonne %d\n",nb_ligne,col);
												else {if(compatibiliteTypeVar(sauvNom,a) == -1)
                            printf("Erreur semantique a la ligne %d a la colonne %d : incompatibilite de type de la variable dans affectation \n",nb_ligne,col);}}
									if(t == 1){
										if(compatibiliteTypeVarB(sauvNom,sauvNom2) == -1)
                    printf("Erreur semantique a la ligne %d a la colonne %d : incompatibilite de type de la variable dans affectation \n",nb_ligne,col);}}		
			|OPERANDE		{if(t == 0){if((op == 4) && ((val == 0) || (val == 0.0)))
										printf("Erreur Semantique: Division par zero, a la ligne %d, colonne %d\n",nb_ligne,col);
												else {if(compatibiliteTypeVar(sauvNom,a) == -1)
                            printf("Erreur semantique a la ligne %d a la colonne %d : incompatibilite de type de la variable dans affectation \n",nb_ligne,col);}}
									if(t == 1){
										if(compatibiliteTypeVarB(sauvNom,sauvNom2) == -1)
                    printf("Erreur semantique a la ligne %d a la colonne %d : incompatibilite de type de la variable dans affectation \n",nb_ligne,col);}}		
;
OPERANDE:CST {t=0;}
		|idf {t=1; strcpy(sauvNom2,$1);}
;
OPERAR: ADDITION 	{op = 1;}
		|SOUSTRACTION {op = 2;}	
		|MULTIPLICATION	{op = 3;}
		|DIVISION		{op = 4;}
;
EXP_ARITHP: par_ouv EXP_ARITH par_ferm
			|par_ouv EXP_ARITH par_ferm EXP_ARITH
;
COND:mc_DO LISTE_INST mc_IF deux_points par_ouv EXP par_ferm mc_ELSE LISTE_INST mc_ENDIF
;
EXP:EXP_COMP
	|EXP_LOG
;
EXP_COMP:idf OPERCOMP CST
		|idf OPERCOMP EXP_ARITH
		|par_ouv idf OPERCOMP CST par_ferm
		|par_ouv idf OPERCOMP EXP_ARITH par_ferm
;
OPERCOMP:SUPERIEUR | INFERIEUR | DOUBLEEGAL | DIFFERENT | SUPERIEUR_OU_EGAL | INFERIEUR_OU_EGAL
;
EXP_LOG:EXP_COMP OPERLOG EXP_COMP
		|par_ouv EXP_COMP OPERLOG EXP_COMP par_ferm
;
OPERLOG:ET_LOGIQUE
		|OU_LOGIQUE
;
%%

int yyerror(char* msg)
{printf("%s ligne %d et colonne %d",msg,nb_ligne,col);
return 0;
}
int main() {    
yyparse();
afficher(); 
return 0;  
} 
int yywrap(void){
return 0;
}



