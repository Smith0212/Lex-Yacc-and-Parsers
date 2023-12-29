%option noyywrap

%{
#include <stdio.h>
FILE* output_file;
FILE* comment_file;
%}

%%

\/\/(.*)|\/\*[^*]*\*+([^/*][^*]*\*+)*\/ {
    comment_file = fopen("comment.txt", "a");
    if (comment_file) {
        fprintf(comment_file, "%s\n", yytext);
        fclose(comment_file);
    } else {
        fprintf(stderr, "Error opening the file.\n");
    }
}

.|\n {
    output_file = fopen("output.c", "a");
    if (output_file) {
        fprintf(output_file, "%s", yytext);
        fclose(output_file);
    } else {
        fprintf(stderr, "Error opening the file.\n");
    }
}
%%

int main() {
    yyin = fopen("input.c", "r");
    yylex();
    fclose(yyin);
    return 0;
}
