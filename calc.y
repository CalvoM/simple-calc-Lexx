%{
    #include <stdio.h>
    #include <math.h>
%}
%union{
    int ival;
    char* word;
    char let;
}

%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%start line
%token<ival> num 
%token<let>endline
%type<ival> expr
%%
line : 
     | endline {
         printf("Type sth, we are powerful\r\n");
     }
     | line endline{
         printf("Type sth, we are powerful\r\n");
     }
     | expr endline {
         printf("=%d\r\n",$1);
     }
     | line expr endline {
         printf("=%d\r\n",$2);
     }
     ;
expr :'(' expr ')' {
         $$=$2;
     }
     | expr '*' expr {
         $$=$1*$3;
     }
     | expr '/' expr {
         $$=$1/$3;
     }
     |expr '%' expr {
         $$=$1%$3;  
     }
     | expr '+' expr {
         $$=$1+$3;
     }
     | expr '-' expr {
         $$=$1-$3;
     }
     | num {
         $$=$1;
     }
     ;
%%

void yyerror(const char *err){
    fprintf(stderr,"%s\r\n",err);
}
  
extern int yywrap();

int main(){
    return(yyparse());
}