%option noyywrap

%{
    int c1 = 0, c2 = 0, c3 = 0, c4 = 0;
%}

digit [0-9]
letter [a-zA-Z]

%%
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while {printf("The length of keyword %s: %d \n",yytext, yyleng);c1++;}

{letter}({letter}|{digit})* {printf("The length of identifier %s is: %d \n", yytext,yyleng); c2++;}

{digit}+ {printf("The length of digit %s is: %d\n", yytext, yyleng); c3++;}

[ \t\n]

. {printf("The length of others %s is: %d\n", yytext, yyleng); c4++;}
%%

int main() {
    yylex();
    printf("keywords: %d, identifiers: %d, digits: %d, others: %d,\n Total number of tokens: %d", c1, c2, c3, c4, c1+c2+c3+c4);
    return 0;
}
