all: alpha

alpha: alpha.tab.c lex.yy.c
	gcc -Wall -g -o alpha alpha.tab.c lex.yy.c -lfl

alpha.tab.c alpha.tab.h: alpha.y
	bison -d alpha.y

lex.yy.c: alpha.l
	flex alpha.l

clean:
	rm -f alpha alpha.tab.c alpha.tab.h lex.yy.c
