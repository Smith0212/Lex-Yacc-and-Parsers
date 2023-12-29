#include <bits/stdc++.h>
#include <fstream>
#include <string>
#include <vector>
#include <cctype> //for isalpha() and isdigit()
using namespace std;

// Function to check if a string is a valid C++ identifier
bool isValidIdentifier(const string& str) {

    if (str.empty() || (!isalpha(str[0]) && str[0] != '_'))
        return false;

    for (char ch : str) {
        // The remaining characters can be letters, digits, or underscores
        if (!isalnum(ch) && ch != '_')
            return false;
    }

    // If all checks pass, the identifier is valid
    return true;
}

int main() {
    //array of keywords
    string keywords[32]={"void","int","float","double","char","long","short","signed","unsigned","bool","if","else","for","while","do","break","continue","switch","case","default","return","goto","auto","extern","register","static","const","sizeof","typedef","volatile","struct","union"};
    
    //array of operators
    string operators[45]={"+","-","*","/","%",">","<","=","==","++","--","+=","-=","*=","/=","%=","&&","||","!","!=","&","|","^","~",">>","<<",">>=","<<=","&=","|=","^=",".","->","?",":","::",";",",","(",")","{","}","[","]"};
    
    //reading the file and storing each word in respective vectors
    ifstream file("input.cpp");
    string word;
    vector<string> keywordsVector;
    vector<string> operatorsVector;
    vector<string> identifiersVector;
    vector<string> othersVector;

    int key=0;
    int op=0;
    int id=0;
    int other=0;

    //read file word by word
    while (file >> word){
        //check if a word is keyword
        for(int i=0;i<32;i++){
            if(word==keywords[i]){
                keywordsVector.push_back(word);
                cout << word << " is a keyword." << endl;
                key++;
                goto end;
            }
        }
        //check if a word is operator
        for(int i=0;i<45;i++){
            if(word==operators[i]){
                operatorsVector.push_back(word);
                cout << word << " is an operator." << endl;
                op++;
                goto end;
            }
        }
        
        if (isValidIdentifier(word)) {
            identifiersVector.push_back(word);
            cout << word << " is a valid identifier." << endl;
            id++;
        } else {
            othersVector.push_back(word);
            cout << word << " is others." << endl;
            other++;
        }
        end:;
    }
    cout<< endl;
    //print the vectors
    cout<<"Keywords: ";
    for(int i=0;i<keywordsVector.size();i++){
        cout<<keywordsVector[i]<<" ";
    }
    cout<<endl;

    cout<<"Operators: ";
    for(int i=0;i<operatorsVector.size();i++){
        cout<<operatorsVector[i]<<" ";
    }
    
    cout<<endl;
    cout<<"Identifiers: ";
    for(int i=0;i<identifiersVector.size();i++){
        cout<<identifiersVector[i]<<" ";
    }

    cout<<endl;
    cout<<"Others: ";
    for(int i=0;i<othersVector.size();i++){
        cout<<othersVector[i]<<" ";
    }

    cout<< endl;
    cout<< endl;
    cout << "total keywords: " << key << endl;
    cout << "total operators: " << op << endl;
    cout << "total identifiers: " << id << endl;
    cout << "total others: " << other << endl;

    cout<<endl;
    return 0;
}
