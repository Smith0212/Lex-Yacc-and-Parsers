%{
#include "7a.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }

\n          { return EOL;}

[ \t]       ; // Skip whitespace

.           {return yytext[0];}

%%  

int yywrap() {
    return 1;
}
void yyerror(char *s) {
    printf("error");
}