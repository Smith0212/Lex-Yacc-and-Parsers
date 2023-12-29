%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%token NUMBER
%token EOL

%%

calculation:
    expression EOL    { printf("Result: %f\n", $1); }
    | calculation EOL { /* Allow multiple calculations */ }
    ;

expression:
    NUMBER           { $$ = $1; }
    | expression "+" expression { $$ = $1 + $3; }
    | expression "-" expression { $$ = $1 - $3; }
    | expression "*" expression { $$ = $1 * $3; }
    | expression "/" expression   { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;  // Handle division by zero
        } else {
            $$ = $1 / $3; 
        }
    }
    | expression "^" expression    { $$ = pow($1, $3); }
    | "(" expression ")"      { $$ = $2; }
    ;

%%

int main() {
    yyparse();
    return 0;
}
