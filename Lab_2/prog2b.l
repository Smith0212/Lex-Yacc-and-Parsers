%option noyywrap

%{
    int c1 = 0, c2 = 0, c3 = 0, c4 = 0;
%}

digit [0-9]
letter [a-zA-Z]

%%
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while {printf("%s: keyword\n", yytext);c1++;}

{letter}({letter}|{digit})* {printf("%s :identifiers\n", yytext); c2++;}

{digit}+ {printf("%s :digit\n", yytext); c3++;}

[ \t\n]

. {printf("%s :others\n", yytext); c4++;}
%%

int main() {
    yylex();
    printf("keywords: %d, identifiers: %d, digits: %d ,others: %d\n", c1, c2, c3, c4);
    return 0;
}
