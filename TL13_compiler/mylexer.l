%{
#include <stdio.h>
#include "mynodes.h"
#include "myparser.tab.h"

%}

NL			\n
WHITE		[ \t]
COMMENT		%.*

%%

{WHITE}				{}
{COMMENT}			{}
{NL}				{ yylineno++; }

[1-9][0-9]*|0 		{
						yylval.iValue = atoi(yytext); 
						return num;
					}

"false"|"true" 		{
						if (strcmp(yytext,"false") == 0)
							yylval.bValue = 0;
						else
							yylval.bValue = 1;
						return boollit;
					}

[A-Z][A-Z0-9]* 		{	
						yylval.sString = NULL;
						char* temp = malloc(sizeof(yytext));
						strcpy(temp,yytext);
						yylval.sString = temp;
						return ident;
					}

\(					{return LP;}

\)					{return RP;}

\:\=				{return ASGN;} 

\;	 				{return SC;}

\*|div|mod			{ 
						yylval.iValue = opEnum(yytext);
						return OP2;
					} 

\+|\-				{
						yylval.iValue = opEnum(yytext);
						return OP3;
					}

\=|\!\=|\<|\>|\<\=|\>\=			{
									yylval.iValue = opEnum(yytext);
									return OP4;
								}

"if"				{return IF;}

"then"				{return THEN;}

"else"				{return ELSE;}

"begin"				{return BGN;}

"end"				{return END;}

"while"				{return WHILE;}

"do"				{return DO;}

"program"			{return PROGRAM;}

"var"				{return VAR;}

"as"				{return AS;}

"int"				{return INT;}

"bool"				{return BOOL;}

"writeInt"			{return WRITEINT;}

"readInt"			{return READINT;}

%%

int opEnum(char* string)
{
	if (!strcmp(string, "div"))
        	return DIV;	
	if (!strcmp(string,  "*"))
		return MULT;
	if (!strcmp(string, "+"))
        	return ADD;
	if (!strcmp(string, "-"))
   		return SUB;
	if (!strcmp(string, "mod"))
        	return MOD;
	if (!strcmp(string, "="))
        	return EQ;
	if (!strcmp(string, "!="))
        	return NEQ;
	if (!strcmp(string, "<"))
        	return LT;
	if (!strcmp(string, ">"))
        	return GT;
	if (!strcmp(string, "<="))
        	return LEQ;
	if (!strcmp(string, ">="))
        	return GEQ;
}
