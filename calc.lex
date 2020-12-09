%{
    #include <stdio.h>
    #include "y.tab.h"
    char c;
    char buf[100];
%}
num [0-9]+
nl \n
op [^a-z0-9\b]
%%
{num} {
    yylval.ival = atoi(yytext);
    return num;
    }
{nl} {
    return endline;
    }
{op} {
        c = yytext[0];
        return c;
    }
%%

int yywrap(){
    return 1;
}
