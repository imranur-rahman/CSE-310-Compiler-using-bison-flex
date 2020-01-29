%x STRING COMMENT

%{
#include<iostream>
#include<stdlib.h>
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include"1305015_symbol.h"
#include "y.tab.h"

//extern YYSTYPE yylval;
//extern SymbolTable *table;
//void yyerror(char *);

int line_count=1;
int error=0;
int lexical_error = 0;
int in;


//SymbolTable symboltable(30);
string temp;

%}

WHITESPACE [ \t\f\r\v]+
LETTER [_a-zA-Z]
LETTERS {LETTER}+
DIGIT [0-9]
DIGITS {DIGIT}+
NEWLINE \n

FLOAT_NUMBER {DIGITS}(\.{DIGITS})(E[+-]?{DIGITS})?
CHARACTER '([ -~]{-}['])'
EXCEPTIONAL_CHARACTER '\\[nt"afrbv0]'|'\\'
IDENTIFIER {LETTER}({LETTER}|{DIGIT})*

DECIMAL_POINT_ERROR {DIGIT}+(\.{DIGIT}*)(\.|{DIGIT})+
ILL_FORMED_NUMBER ({DIGITS}|{FLOAT_NUMBER}+)([E][+-]?{FLOAT_NUMBER}*)([E][+-]?{FLOAT_NUMBER}*|{DIGITS})*
NON_IDENTIFIER {DIGITS}{LETTERS}({DIGIT}|{LETTER})*|{LETTERS}{DIGITS}({DIGIT}|{LETTER})+
MULTI_CHAR_CONSTANT_ERROR \'([ -~])([ -~])+\'|'([ -~])+


SINGLELINE_COMMENT "//"({CHARACTER}+)$ 


%%

{WHITESPACE}    {}
{NEWLINE} 	{line_count++;}




"if"		{
			//fprintf(tokenout,"<IF>");
			//fprintf(logout,"Line no %d: tokenout <IF> Lexeme %s found\n\n",line_count,yytext);
			return IF;
		}
"for"		{
			//fprintf(tokenout,"<FOR>");
			//fprintf(logout,"Line no %d: tokenout <FOR> Lexeme %s found\n\n",line_count,yytext);
			return FOR;
		}
"do"		{
			//fprintf(tokenout,"<DO>");
			//fprintf(logout,"Line no %d: tokenout <DO> Lexeme %s found\n\n",line_count,yytext);
			return DO;
		}
"int"		{
			//fprintf(tokenout,"<INT>");
			//fprintf(logout,"Line no %d: tokenout <INT> Lexeme %s found\n\n",line_count,yytext);
			return INT;
		}
"float"		{
			//fprintf(tokenout,"<FLOAT>");
			//fprintf(logout,"Line no %d: tokenout <FLOAT> Lexeme %s found\n\n",line_count,yytext);
			return FLOAT;

		}
"void"		{
			//fprintf(tokenout,"<VOID>");
			//fprintf(logout,"Line no %d: tokenout <VOID> Lexeme %s found\n\n",line_count,yytext);
			return VOID;
		}
"else"		{
			//fprintf(tokenout,"<ELSE>");
			//fprintf(logout,"Line no %d: tokenout <ELSE> Lexeme %s found\n\n",line_count,yytext);
			return ELSE;
		}
"while"		{
			//fprintf(tokenout,"<WHILE>");
			//fprintf(logout,"Line no %d: tokenout <WHILE> Lexeme %s found\n\n",line_count,yytext);
			return WHILE;
		}
"break"		{
			//fprintf(tokenout,"<BREAK>");
			//fprintf(logout,"Line no %d: tokenout <BREAK> Lexeme %s found\n\n",line_count,yytext);
			return BREAK;
		}
"char"		{
			//fprintf(tokenout,"<CHAR>");
			//fprintf(logout,"Line no %d: tokenout <CHAR> Lexeme %s found\n\n",line_count,yytext);
			return CHAR;
		}
"double"	{
			//fprintf(tokenout,"<DOUBLE>");
			//fprintf(logout,"Line no %d: tokenout <DOUBLE> Lexeme %s found\n\n",line_count,yytext);
			return DOUBLE;
		}
"return"	{
			//fprintf(tokenout,"<RETURN>");
			//fprintf(logout,"Line no %d: tokenout <RETURN> Lexeme %s found\n\n",line_count,yytext);
			return RETURN;
		}
"continue"	{
			//fprintf(tokenout,"<CONTINUE>");
			//fprintf(logout,"Line no %d: tokenout <CONTINUE> Lexeme %s found\n\n",line_count,yytext);
			return CONTINUE;
		}
"main"		{
			//fprintf(tokenout,"<MAIN>");
			//fprintf(logout,"Line no %d: tokenout <MAIN> Lexeme %s found\n\n",line_count,yytext);
			return MAIN;
		}
"println"	{
			//fprintf(tokenout,"<PRINTLN>");
			//fprintf(logout,"Line no %d: tokenout <PRINTLN> Lexeme %s found\n\n",line_count,yytext);
			return PRINTLN;
		}



{DIGIT}+ 	{
			//fprintf(tokenout,"<CONST_INT,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <CONST_INT> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "CONST_INT");
			//symboltable.printTable();
			return CONST_INT;
		}
{FLOAT_NUMBER}	{
			//fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <CONST_FLOAT> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "CONST_FLOAT");
			//symboltable.printTable();
			return CONST_FLOAT;
		}
{CHARACTER}	{
			//fprintf(tokenout,"<CONST_CHAR,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <CONST_CHAR> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "CONST_CHAR");
			//symboltable.printTable();
			return CONST_CHAR;
		}

{IDENTIFIER}    {
			//fprintf(tokenout,"<ID,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <ID> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "ID");
			//symboltable.printTable();
			return ID;
		}



[+-]		{
			//fprintf(tokenout,"<ADDOP,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <ADDOP> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "ADDOP");
			//symboltable.printTable();
			return ADDOP;
		}
[*/%]		{
			//fprintf(tokenout,"<MULOP,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <MULOP> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "MULOP");
			//symboltable.printTable();
			return MULOP;
		}
("++")		{
			//fprintf(tokenout,"<INCOP,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <INCOP> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "INCOP");
			//symboltable.printTable();
			return INCOP;
		}
("--")		{
			//fprintf(tokenout,"<DECOP,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <DECOP> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "DECOP");
			//symboltable.printTable();
			return DECOP;
		}
("=")		{
			//fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <ASSIGNOP> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "ASSIGNOP");
			//symboltable.printTable();
			return ASSIGNOP;
		}
("&&"|"||"|"!")	{
			//fprintf(tokenout,"<LOGICOP,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <LOGICOP> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "LOGICOP");
			//symboltable.printTable();
			return LOGICOP;
		}
"("		{
			//fprintf(tokenout,"<LPAREN,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <LPAREN> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "LPAREN");
			//symboltable.printTable();
			return LPAREN;
		}
")"		{
			//fprintf(tokenout,"<RPAREN,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <RPAREN> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "RPAREN");
			//symboltable.printTable();
			return RPAREN;
		}
"{"		{
			//fprintf(tokenout,"<LCURL,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <LCURL> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "LCURL");
			//symboltable.printTable();
			return LCURL;
		}
"}"		{
			//fprintf(tokenout,"<RCURL,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <RCURL> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "RCURL");
			//symboltable.printTable();
			return RCURL;
		}
"["		{
			//fprintf(tokenout,"<LTHIRD,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <LTHIRD> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "LTHIRD");
			//symboltable.printTable();
			return LTHIRD;
		}
"]"		{
			//fprintf(tokenout,"<RTHIRD,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <RTHIRD> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "RTHIRD");
			//symboltable.printTable();
			return RTHIRD;
		}
","		{
			//fprintf(tokenout,"<COMMA,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <COMMA> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "COMMA");
			//symboltable.printTable();
			return COMMA;
		}
";"		{
			//fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			//fprintf(logout,"Line no %d: tokenout <SEMICOLON> Lexeme %s found\n\n",line_count,yytext);
			//symboltable.insert(yytext, "SEMICOLON");
			//symboltable.printTable();
			return SEMICOLON;
		}
		
		




\"		{	
			temp.clear();
			temp += string(yytext);
			in = line_count;
			BEGIN STRING;
			
		}
<STRING>[\"]	{
			temp += string(yytext);
			//fprintf(tokenout,"<STRING>,%s", temp.c_str());
			//fprintf(logout,"Line no %d: TOKEN <STRING> Lexeme %s \n\n",in,temp.c_str());
			BEGIN INITIAL;
		}
<STRING>\\\n
		{
			line_count++;
		}
<STRING>\n	{
			line_count++;
			lexical_error++;
			//fprintf(logout,"Error at line no %d Unfinished string %s\n\n",line_count,temp.c_str());
			BEGIN INITIAL;
		}
<STRING>[^"]    {
			temp += string(yytext);
		}

<STRING><<EOF>>	{
			lexical_error++;
			//fprintf(logout, "Unfinished String\n\n");
			BEGIN INITIAL;
		}
		

"/*"		{
			BEGIN COMMENT;
			temp.clear();
			temp += string(yytext);
			in = line_count;
			
		}
<COMMENT>"*/"   {
			temp += string(yytext);
			//fprintf(logout,"Line no %d: <COMMENT> %s \n\n",in,temp.c_str());
			BEGIN INITIAL;
		}
<COMMENT>[^\n]  {
			if(yytext[0] == '\n')line_count++;
			else temp += string(yytext);
		}

<COMMENT><<EOF>> {
			//fprintf(logout,"Error at line no %d Unfinished string %s\n\n",in,temp.c_str());
			//fprintf(logout,"Total Line Number: %d\n\n",line_count); 
			//fprintf(logout,"Total Errors: %d\n",lexical_error);
			BEGIN INITIAL;
			return 0;
		}
<<EOF>> 	{
			//fprintf(logout,"Total Line Number: %d\n\n",line_count); 
			//fprintf(logout,"Total Errors: %d\n",lexical_error);
			BEGIN INITIAL;
			return 0;
		}
			
.		{
		}


%%
int yywrap(void)
{
	return 1;
}
/*int main(int argc,char *argv[]){

	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}

	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	yyin= fin;
	logout= fopen("1305015_log.txt","w");
	tokenout= fopen("1305015_token.txt","w");

	
	yylex();
	fclose(yyin);
	//fclose(tokenout);
	//fclose(logout);
	return 0;
}*/
