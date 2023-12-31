%{
#include "7c.tab.h"
%}

%%
[0-9]+  { yylval = atoi(yytext); return NUMBER; }

[ \t]   ; /* Ignore whitespace */

\n      return 0; /* Logical EOF */

. return yytext[0];
%%

int yywrap() {
    return 1;
}
void yyerror(char *s) {
    printf("Syntax error\n");
}
