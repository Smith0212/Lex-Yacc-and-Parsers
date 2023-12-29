#include <iostream>
#include <fstream>
#include <unordered_set>
#include <string>
using namespace std;

// Function to check if a word is a C++ keyword
bool isKeyword(const string& word) {
    static const unordered_set<string> keywords = {
        "asm", "double", "new", "switch", "auto", "else", "operator", "template", "break", "enum",
        "private", "this", "case", "extern", "protected", "throw", "catch", "float", "public", "try",
        "char", "for", "register", "typedef", "class", "friend", "return", "union", "const", "goto",
        "short", "unsigned", "continue", "if", "signed", "virtual", "default", "inline", "sizeof",
        "void", "delete", "int", "static", "volatile", "do", "long", "struct", "while"
    };
    return keywords.find(word) != keywords.end();
}

int main() {
    ifstream inputFile;
    inputFile.open("input.cpp"); // Replace "input.cpp" with the path to your C++ source file

    if (!inputFile) {
        cout << "Error opening file." << endl;
        return 1;
    }

    string word;
    char ch;

    while (inputFile.get(ch)) {
        // Check if the character is alphanumeric or underscore
        if (isalnum(ch) || ch == '_') {
            word += ch;
        } else {
            // Process the word
            if (!word.empty()) {
                if (isKeyword(word)) {
                    cout << word << " is a keyword." << endl;
                } else {
                    cout << word << " is an identifier." << endl;
                }
                word.clear();
            }

            // If the character is not part of an identifier, print it as an operator or separator
            if (!isspace(ch)) {
                cout << ch << " is an operator or separator." << endl;
            }
        }
    }

    // Check for any remaining word after processing the input file
    if (!word.empty()) {
        if (isKeyword(word)) {
            cout << word << " : keyword." << endl;
        } else {
            cout << word << " : identifier." << endl;
        }
    }

    inputFile.close();
    return 0;
}
