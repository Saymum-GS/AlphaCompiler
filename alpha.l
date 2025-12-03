%{
#include "alpha.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_num = 1;
%}

%option noyywrap

DIGIT    [0-9]
LETTER   [a-zA-Z_]
ID       {LETTER}({LETTER}|{DIGIT})*
INTEGER  {DIGIT}+
FLOAT    {DIGIT}+\.{DIGIT}+
STRING   \"([^\\\"]|\\.)*\"

%%

"alp>"[^\n]*          { /* single-line comment */ }

"alp{"([^}]|\n)*"}alp" {
    char *p = yytext;
    while (*p) { if (*p=='\n') line_num++; p++; }
}

"num"       { return NUM; }
"decimal"   { return DECIMAL; }
"text"      { return TEXT; }
"read"      { return INPUT; }
"show"      { return SHOW; }

{ID}        { yylval.str = strdup(yytext); return IDENTIFIER; }
{INTEGER}   { yylval.ival = atoi(yytext); return INT_LITERAL; }
{FLOAT}     { yylval.fval = atof(yytext); return FLOAT_LITERAL; }
{STRING}    { yylval.str = strdup(yytext); return STRING_LITERAL; }

"="         { return ASSIGN; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }

"("         { return LPAREN; }
")"         { return RPAREN; }
";"         { return SEMICOLON; }

[ \t]+      { /* skip whitespace */ }
\n          { line_num++; }

.           { printf("Unexpected character: %s at line %d\n", yytext, line_num); }

%%
