#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct {
	char nom[20];
	char code[20];
	char type[20];
	int cst; //0:non 1:oui
}TypeTS;

TypeTS ts[1000];
int cpt=0;

int rechercher(char entite[]){
	int i=0;
	while(i<cpt){
		if(strcmp(entite,ts[i].nom)==0){
			return i;
		}
		i++;
	}
	return -1;
}

void inserer(char entite[], char code[]){
	if(rechercher(entite)==-1){
		strcpy(ts[cpt].nom,entite);
		strcpy(ts[cpt].code,code);
		ts[cpt].cst=0;
		cpt++;
	}
}

void afficher(){
	printf("\n\n/******************Table des symboles******************/\n");
	printf("_____________________________________________________________________\n");
	printf("\t| NomEntite | CodeEntite  | TypeEntite  | Constante |\n");
	printf("_____________________________________________________________________\n");
	int i=0;
	while(i<cpt){
		printf("\t|%10s |%12s |%12s |%10d |\n",ts[i].nom, ts[i].code, ts[i].type, ts[i].cst);
		i++;
	}
}

void insererType(char entite[], char type[]){
	int pos;
	pos=rechercher(entite);
	if(pos!=-1){
		strcpy(ts[pos].type,type);
	}
}

int doubleDeclaration(char entite[]){
	int pos;
	pos=rechercher(entite);
	if(strcmp(ts[pos].type,"")==0) return 0;
	else return -1;
}

void insererConstante(char entite[]){
	int pos;
	pos=rechercher(entite);
	ts[pos].cst=1;
}

int constOuPas(char entite[]){
	int pos;
	pos=rechercher(entite);
	if(ts[pos].cst==1) return 1;
}

int compatibiliteTypeVar(char entite[],int a){
  int i;
  for(i=0;i<cpt;i++){
    if(strcmp(ts[i].nom,entite) == 0)
      break;
  }
  switch (a)
  {
  case 1: /* entier */{
    if(strcmp(ts[i].type,"Pint") == 0)
      return 0;
    }
  case 2: /* reel */{
    if(strcmp(ts[i].type,"Pfloat") == 0)
      return 0;
    }
  }
  return -1;
}

int compatibiliteTypeVarB(char entite1[],char entite2[]){ /* Pour les variables */
  int i , j ;
  i = rechercher(entite1);
  j = rechercher(entite2);
  if(strcmp(ts[i].type,ts[j].type) == 0)
    return 0;
  else
    return -1;
}

