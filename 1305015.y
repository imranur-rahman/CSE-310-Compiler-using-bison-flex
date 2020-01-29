
%{
#include <stdio.h>
#include <stdlib.h>
//#define YYSTYPE double      /* yyparse() stack type */

extern FILE *yyin;

void yyerror(char *s){
	//printf("%s\n",s);
	fprintf(stderr,"%s\n",s);
}

int yylex(void);
int yyparse(void);

%}

%token INT MAIN LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD SEMICOLON COMMA FLOAT CHAR ID FOR IF ELSE WHILE DO PRINTLN RETURN LOGICOP RELOP ADDOP MULOP NOT CONST_INT CONST_FLOAT CONST_CHAR INCOP DECOP ASSIGNOP VOID BREAK DOUBLE CONTINUE


%%
Program : INT MAIN LPAREN RPAREN compound_statement	{printf("Program : INT MAIN LPAREN RPAREN compound_statement\n");}
	;


compound_statement : LCURL var_declaration statements RCURL	{printf("compound_statement : LCURL var_declaration statements RCURL\n");}
		   | LCURL statements RCURL			{printf("compound_statement : LCURL statements RCURL\n");}
		   | LCURL RCURL				{printf("compound_statement : LCURL RCURL\n");}
		   ;

			 
var_declaration	: type_specifier declaration_list SEMICOLON			{printf("type_specifier declaration_list SEMICOLON\n");}
		|  var_declaration type_specifier declaration_list SEMICOLON	{printf("var_declaration type_specifier declaration_list SEMICOLON\n");}
		;

type_specifier	: INT 		{printf("type_specifier	: INT\n");}
		| FLOAT		{printf("type_specifier	: FLOAT\n");}
		| CHAR		{printf("type_specifier	: CHAR\n");}
		;
			
declaration_list : declaration_list COMMA ID 				{printf("declaration_list : declaration_list COMMA ID\n");}
		 | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD	{printf("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD\n");}
		 | ID 							{printf("declaration_list : ID\n");}
		 | ID LTHIRD CONST_INT RTHIRD 				{printf("declaration_list : ID LTHIRD CONST_INT RTHIRD\n");}
		 ;

statements : statement 			{printf("statements  : statement\n");}
	   | statements statement 	{printf("statements  : statements statement\n");}
	   ;


statement  : expression_statement 					{printf("statement  : expression_statement\n");}
	   | compound_statement 					{printf("statement  : compound_statement\n");}
	   | FOR LPAREN expression_statement expression_statement expression RPAREN statement {printf("statement  : FOR LPAREN expression_statement expression_statement expression RPAREN statement\n");}
	   | IF LPAREN expression RPAREN statement			{printf("statement  : IF LPAREN expression RPAREN statement\n");}
	   | IF LPAREN expression RPAREN statement ELSE statement	{printf("statement  : IF LPAREN expression RPAREN statement ELSE statement\n");}
	   | WHILE LPAREN expression RPAREN statement 			{printf("statement  : WHILE LPAREN expression RPAREN statement\n");}
	   | PRINTLN LPAREN ID RPAREN SEMICOLON 			{printf("statement  : PRINTLN LPAREN ID RPAREN SEMICOLON\n");}
	   | RETURN expression SEMICOLON 				{printf("statement  : RETURN expression SEMICOLON\n");}
	   ;
		
expression_statement	: SEMICOLON		{printf("expression_statement	: SEMICOLON\n");}		
			| expression SEMICOLON 	{printf("expression_statement	: expression SEMICOLON\n");}
			;
						
variable : ID 				{printf("variable : ID\n");}
	 | ID LTHIRD expression RTHIRD 	{printf("variable : ID LTHIRD expression RTHIRD\n");}
	 ;
			
expression : logic_expression				{printf("expression : logic_expression\n");}
	   | variable ASSIGNOP logic_expression 	{printf("expression : variable ASSIGNOP logic_expression\n");}
	   ;
			
logic_expression : rel_expression 				{printf("logic_expression : rel_expression\n");}
		 | rel_expression LOGICOP rel_expression 	{printf("logic_expression : rel_expression LOGICOP rel_expression\n");}
		 ;
			
rel_expression	: simple_expression 				{printf("rel_expression	: simple_expression\n");}
		| simple_expression RELOP simple_expression	{printf("rel_expression	: simple_expression RELOP simple_expression\n");}
		;
				
simple_expression : term 				{printf("simple_expression : term\n");}
		  | simple_expression ADDOP term 	{printf("simple_expression : simple_expression ADDOP term\n");}
		  ;
					
term :	unary_expression		{printf("term : unary_expression\n");}
     |  term MULOP unary_expression	{printf("term : term MULOP unary_expression\n");}
     ;

unary_expression : ADDOP unary_expression 	{printf("unary_expression : ADDOP unary_expression\n");} 
		 | NOT unary_expression 	{printf("unary_expression : NOT unary_expression\n");} 
		 | factor 			{printf("unary_expression : factor\n");} 
		 ;
	
factor	: variable 			{printf("factor	: variable\n");}
	| LPAREN expression RPAREN 	{printf("factor : LPAREN expression RPAREN\n");}
	| CONST_INT 			{printf("factor	: CONST_INT\n");}
	| CONST_FLOAT			{printf("factor	: CONST_FLOAT\n");}
	| CONST_CHAR			{printf("factor	: CONST_CHAR\n");}
	| factor INCOP 			{printf("factor	: factor INCOP\n");}
	| factor DECOP			{printf("factor	: factor DECOP\n");}
	;
%%

/*int main(void)
{
    //freopen("output.txt", "wt", stdout);
    yyparse();
    return 0;
}*/
int main(int argc, char *argv[]) {
    freopen("output.txt", "wt", stdout);
    if (argc > 1)
    {
        yyin = fopen(argv[1], "r");
        yyparse(); /* Calls yylex() for tokens. */
    }
    else
        printf("syntax: %s filename\n", argv[0]);
    return 0;
}
