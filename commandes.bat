flex lexical.l
bison -d synt.y
gcc lex.yy.c synt.tab.c -o projetComp.exe
projetComp<expLangage.txt
