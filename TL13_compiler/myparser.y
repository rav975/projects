%{
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include "uthash.h"
#include "mynodes.h"	

#define TYPE_INT 1
#define TYPE_BOOL 0

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern yylineno;

nodeType *prog(nodeType* declarations, nodeType* stmtSequence);
nodeType *decl(nodeType* ident, nodeType* idtype, nodeType* declarations);
nodeType *idtype(char* idtype);
nodeType *assgn(nodeType* ident, nodeType* expr);
nodeType *ifnode(nodeType* expr, nodeType* stmtSequence, nodeType* elseStmt);
nodeType *whilenode(nodeType* expr, nodeType* stmtSequence);
nodeType *seq(nodeType* stmt, nodeType* stmtSequence);
nodeType *writeintnode(nodeType* expr);
nodeType *fact(nodeType* fact);
nodeType *id(char* name);
nodeType *con(int value);
nodeType *op(int op, nodeType* leftOp, nodeType* rightOp);

void freeNode(nodeType *p);
void add_symbol(char* name, char* type);
void print_symbols();
void yyerror(const char *s);

struct symbol {

	UT_hash_handle hh;
	char* type; 
	char* name;
	int value;
	int declared;
};

struct symbol *sym_table = NULL;

%}

%union {
	nodeType *nPtr;
	int iValue; 
	int bValue; 
	char *sString; 
};

%token <iValue> num
%token <sString> ident
%token <bValue> boollit
%token <iValue> OP2 OP3 OP4
%token LP RP ASGN SC 
%token INT BOOL
%token IF THEN ELSE BGN END WHILE DO PROGRAM VAR AS
%token WRITEINT READINT

%left OP4
%left OP3
%left OP2

%type <nPtr> assignment factor expression ifStatement statementSequence elseClause whileStatement simpleExpression term statement program declarations type writeInt

%start program

%%

program:
	PROGRAM declarations BGN statementSequence END {
		$$ = prog($2, $4);
		run($$);
		free($$);
	} 
	;
declarations:
	VAR ident AS type SC declarations { $$ = decl($2, $4, $6); }
	| { $$ = NULL; }
	;
type:
	INT { $$ = id("int"); }
	| BOOL { $$ = id("bool"); }
	;
statementSequence:
	statement SC statementSequence { $$ = seq($1, $3); }
	| { $$ = NULL; }
	;
statement:
	assignment { $$ = $1; }
	| ifStatement { $$ = $1; }
	| whileStatement { $$ = $1; }
	| writeInt { $$ = $1; }
	;
assignment:
	ident ASGN expression { $$ = assgn($1, $3); }
	| ident ASGN READINT { $$ = assgn($1, NULL); }
	;
ifStatement:
	IF expression THEN statementSequence elseClause END { $$ = ifnode($2, $4, $5); }
	;
elseClause:
	ELSE statementSequence { $$ = $2; }
	| { $$ = NULL; }
	;
whileStatement:
	WHILE expression DO statementSequence END { $$ = whilenode($2, $4); }
	;
writeInt:
	WRITEINT expression { $$ = writeintnode($2); }
	;
expression:
	simpleExpression { $$ = $1; }
	| simpleExpression OP4 simpleExpression { $$ = op($2, $1, $3); }
	;
simpleExpression:
	term OP3 term { $$ = $$ = op($2, $1, $3); }
	| term { $$ = $1; }
	;
term:
	factor OP2 factor { $$ = $$ = op($2, $1, $3); }
	| factor { $$ = $1; }
	;
factor:
	ident { $$ = id($1); }
	| num { 
			$$ = con($1); 
			if(!($1 >=0 && $1 <= 2147483647)) 
				yyerror("Integer overflow.");
	}
	| boollit { $$ = con($1); }
	| LP expression RP { $$ = $2; }
	;

%%
int run(nodeType* p) {
	if(!p){
		return 1;
	}	
	switch(p->type){
		case typeProg: {
			printf("\n/*-- C Code --*/\n\n");
			printf("#include<stdio.h>\n");
			printf("#include<stdlib.h>\n");
			printf("#include<stdbool.h>\n\n");
			printf("void main() {\n");
			run(p->program.declarations);
			run(p->program.stmtSequence);
			printf("}\n");
			//print_symbols();
		} break;
		case typeDecl: {
			nodeType *temp = p->declarations.idtype;
			add_symbol(p->declarations.ident, temp->idtype.idtype); 
			run(p->declarations.idtype);
			printf(" %s;\n", p->declarations.ident);
			run(p->declarations.declarations);
		} break;
		case typeIdType: {
			printf("%s", p->idtype.idtype);
		} break;
		case typeSeq: {
			run(p->stmtSequence.stmt);
			printf("\n");
			run(p->stmtSequence.stmtSequence);
		} break;
		case typeAssgn: {
			struct symbol *s;
   			HASH_FIND_STR(sym_table, p->assgn.ident, s);  
    		if (s==NULL)
    			yyerror("Variable not declared.");
    		// else
    		// 	s->value = evaluate_expr(p->assgn.expr);
			if(p->assgn.expr == NULL)
				printf("scanf(\"%%d\", &%s);", p->assgn.ident);
			else {
				printf("%s = ", p->assgn.ident);
				run(p->assgn.expr);
				printf(";");
			}		
		} break;
		case typeIf: {
			printf("if(");
			run(p->ifStmt.expr);
			printf(") {\n");
			run(p->ifStmt.stmtSequence);
			printf("}");
			if(p->ifStmt.elseStmt != NULL) {
				printf("else {\n");
				run(p->ifStmt.elseStmt);
				printf("}");
			}
		} break;
		case typeWhile: {
			printf("while(");
			run(p->whileStmt.expr);
			printf(") {\n");
			run(p->whileStmt.stmtSequence);
			printf("}");
		} break;
		case typeWriteInt: {
			printf("printf(\"%%d\\n\",");
			run(p->writeInt.expr);
			printf(");");
		} break;
		case typeOp: {
			printf("(");
			run(p->op.leftOp);
			switch(p->op.op) {
				case ADD: {
					printf(" + ");
				} break;
				case SUB: {
					printf(" - ");
				} break;
				case MULT: {
					printf(" * ");
				} break;
				case DIV: {
					printf(" / ");
				} break;
				case MOD: {
					printf("mod");
				} break;
				case EQ: {
					printf(" = ");
				} break;
				case NEQ: {
					printf(" != ");
				} break;
				case LT: {
					printf(" < ");
				} break;
				case GT: {
					printf(" > ");
				} break;
				case LEQ: {
					printf(" <= ");
				} break;
				case GEQ: {
					printf(" <= ");
				} break;
			}
			run(p->op.rightOp);	
			printf(")");
		} break;
		case typeIdent: {
			printf("%s", p->ident.name);
		} break;
		case typeCon: {
			printf("%d",p->con.value);
		} break;
	}	
}
nodeType *prog(nodeType* declarations, nodeType* stmtSequence) {
	nodeType *p;
	
	if ((p = malloc(sizeof(progNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeProg;
	p->program.declarations = declarations;
	p->program.stmtSequence = stmtSequence;

	return p;
}
nodeType *decl(nodeType* ident, nodeType* idtype, nodeType* declarations) {
	nodeType *p;
	
	if ((p = malloc(sizeof(declNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeDecl;
	p->declarations.ident = ident;
	p->declarations.idtype = idtype;
	p->declarations.declarations = declarations;

	return p;
}
nodeType *idtype(char* idtype) {
	nodeType *p;
	
	if ((p = malloc(sizeof(idtypeNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeIdType;
	p->idtype.idtype = idtype;

	return p;
}
nodeType *assgn(nodeType* ident, nodeType* expr) {
	nodeType *p;
	
	if ((p = malloc(sizeof(assgnNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeAssgn;
	p->assgn.ident = ident;
	p->assgn.expr = expr;

	return p;
}
nodeType *ifnode(nodeType* expr, nodeType* stmtSequence, nodeType* elseStmt) {
	nodeType *p;
	
	if ((p = malloc(sizeof(ifNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeIf;
	p->ifStmt.expr = expr;
	p->ifStmt.stmtSequence = stmtSequence;
	p->ifStmt.elseStmt = elseStmt;

	return p;
}
nodeType *whilenode(nodeType* expr, nodeType* stmtSequence) {
	nodeType *p;
	
	if ((p = malloc(sizeof(whileNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeWhile;
	p->whileStmt.expr = expr;
	p->whileStmt.stmtSequence = stmtSequence;
	
	return p;
}
nodeType *seq(nodeType* stmt, nodeType* stmtSequence) {
	nodeType *p;
	
	if ((p = malloc(sizeof(seqNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeSeq;
	p->stmtSequence.stmt = stmt;
	p->stmtSequence.stmtSequence = stmtSequence;
	
	return p;
}
nodeType *writeintnode(nodeType* expr) {
	nodeType *p;
	
	if ((p = malloc(sizeof(writeIntNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeWriteInt;
	p->writeInt.expr = expr;
	
	return p;
}
nodeType *id(char* name) {
	nodeType *p;
	
	if ((p = malloc(sizeof(identNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeIdent;
	p->ident.name = name;

	return p;
}
nodeType *con(int value) {
	nodeType *p;
	
	if ((p = malloc(sizeof(conNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeCon;
	p->con.value = value;

	return p;
}
nodeType *op(int op, nodeType* leftOp, nodeType* rightOp) {
	nodeType *p;
	size_t size;
	
	if ((p = malloc(sizeof(opNodeType))) == NULL)
		yyerror("out of memory");
	
	p->type = typeOp;
	p->op.op = op;
	p->op.leftOp = leftOp;
	p->op.rightOp = rightOp;

	return p;
}

// int evaluate_expr(nodeType* expr) {
// 	switch(expr->type) {
// 		case typeIdent: {
// 			struct symbol *s;
//    			HASH_FIND_STR(sym_table, expr->ident.name, s);
//    			return s->value;
// 		} break;
// 		default: {
// 			return 0;	
// 		} 
// 	}
// }

void add_symbol(char* name, char* type) {

    struct symbol *s;

    HASH_FIND_STR(sym_table, name, s);  /* id already in the hash? */
    if (s==NULL) {
    	if ((s = malloc(sizeof(struct symbol))) == NULL)
			yyerror("out of memory");
   		s->name = name;
    	s->value = 0;
    	s->type = type;
    	s->declared = 1;
    	HASH_ADD_STR(sym_table, name, s); 
    }
    else
    	yyerror("Variable declared twice;");	
}

void print_symbols() {
    struct symbol *s;

    for(s=sym_table; s != NULL; s=(struct symbol*)(s->hh.next)) {
        printf("//type: %s, name: %s, value: %d\n", s->type, s->name, s->value);
    }
}

void freeNode(nodeType *p) {
	if (!p) 
		return;
	free (p);
}

void yyerror(const char *s) {
  printf("Compile Error: %s - Line: %d\n",s, yylineno);
  exit(1);
}

int main(int argc, char *argv[]) {
 
  FILE *input = fopen(argv[1], "r");
  yyin = input;
  yyparse();
  fclose(yyin);
  return 0;
}
