%option noyywrap

%{
#include <stdio.h>
FILE *comments_file;
%}


%x COMMENT

%%

"/*"    {
            comments_file = fopen("comments.txt", "a");
            if (comments_file == NULL) {
                fprintf(stderr, "Error opening comments.txt for writing.\n");
                exit(1);
            }
            fprintf(comments_file, "/*");
            BEGIN(COMMENT);
        }
<COMMENT>"*/"    {
                    fprintf(comments_file, "*/\n");
                    fclose(comments_file);
                    BEGIN(INITIAL);
                }
<COMMENT>.|\n     {
                    fprintf(comments_file, "%s", yytext);
                }
"//"    {
            comments_file = fopen("comments.txt", "a");
            if (comments_file == NULL) {
                fprintf(stderr, "Error opening comments.txt for writing.\n");
                exit(1);
            }
            fprintf(comments_file, "%s", yytext);
            fclose(comments_file);
        }
.|\n    {
            FILE *output_file = fopen("input.c", "a");
            if (output_file == NULL) {
                fprintf(stderr, "Error opening input.c for writing.\n");
                exit(1);
            }
            fprintf(output_file, "%s", yytext);
            fclose(output_file);
        }
%%

int main() {
    yylex();
    return 0;
}
