%option noyywrap

%{
#include<stdio.h>
FILE* number_file;
%}

digits [0-9]

%%
{digits}+ {
    int num = atoi(yytext); // Convert matched text to an integer
    if (num % 7 == 0) {
        num += 3;
    }
    printf("%d", num);

    number_file = fopen("number.txt", "a");
    if (number_file) {
        fprintf(number_file, "%d\n", num);
        fclose(number_file);
    } else {
        fprintf(stderr, "Error opening the file.\n");
    }
}



.|\n {
    printf(" ");
}
%%

int main()
{
    FILE* input = fopen("input.txt","r");
    if(!input)
    {
        printf(stderr, "Error opening the input file");
    }
    yyin = input;
    yylex();
    fclose(input);
}
