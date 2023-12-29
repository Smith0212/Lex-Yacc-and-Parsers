%{
#include <stdio.h>
#include <math.h>
%}

%token NUMBER

%%

statement: E      { printf("Result: %d\n", $1); }
         | statement E { printf("Result: %d\n", $2); }
         ;

E : E '+' T { $$ = $1 + $3; }
  | T { $$ = $1; }
  ;

T : T '*' F { $$ = $1 * $3; }
  | F { $$ = $1; }
  ;

F : P '^' F { $$ = $1 ^ $3; }
  | P { $$ = $1; }
  ;

P : '(' E ')'       { $$ = $2; }
  | NUMBER { $$ = $1; }
  ;

%%

int main(){
    yyparse();
}