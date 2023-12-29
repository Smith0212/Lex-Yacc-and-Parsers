%{
    #include "yacc7b.tab.h"
    extern int yylval;
%}
%%
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[ \t] ; /* ignore whitespace */
\n return 0; /* logical EOF */
. return yytext[0];
%%
int yywrap() {
    return 1;
}
void yyerror(char *s) {
    printf("error");
}