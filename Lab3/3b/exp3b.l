%option noyywrap

%{
#include <stdio.h>
int w,c,l;
%}

word [a-zA-Z]

%%
{word}{word}* {printf("%s\n ",yytext); w++; c+=yyleng;}

\n            {l++;}

. {}
%%

int main() {
    yyin = fopen("input.txt", "r");
    yylex();
    printf("\nWords: %d \nChracters: %d \nLines: %d",w,c,l+1);
    fclose(yyin);
    return 0;
}