typedef enum { MULT, DIV, MOD, ADD, SUB, EQ, NEQ, LT, GT, LEQ,GEQ } operatorEnum;

typedef enum { typeCon, typeOp, typeWriteInt, typeWhile, typeIf, 
				typeAssgn, typeIdent, typeIdType, typeSeq, typeDecl, typeProg } nodeEnum;

typedef struct {

	nodeEnum type;
	int value; 

} conNodeType;

typedef struct {

	nodeEnum type;
	char* name;

} identNodeType;

typedef struct {

	nodeEnum type; 
	int op; 
	union nodeTypeTag *leftOp;
	union nodeTypeTag *rightOp;

} opNodeType;

typedef struct {

	nodeEnum type;
	union nodeTypeTag *expr;

} writeIntNodeType;

typedef struct {

	nodeEnum type;
	union nodeTypeTag *stmt;
	union nodeTypeTag *stmtSequence;

} seqNodeType;

typedef struct {

	nodeEnum type;
	union nodeTypeTag *expr;
	union nodeTypeTag *stmtSequence;

} whileNodeType;

typedef struct {

	nodeEnum type;
	union nodeTypeTag *expr;
	union nodeTypeTag *stmtSequence;
	union nodeTypeTag *elseStmt;

} ifNodeType;

typedef struct {

	nodeEnum type;
	union nodeTypeTag *ident;
	union nodeTypeTag *expr;

} assgnNodeType;

typedef struct {

	nodeEnum type;
	char* idtype;

} idtypeNodeType;

typedef struct {

	nodeEnum type; 
	union nodeTypeTag *ident;
	union nodeTypeTag *idtype;
	union nodeTypeTag *declarations; 

} declNodeType;

typedef struct {

	nodeEnum type;
	union nodeTypeTag *declarations;
	union nodeTypeTag *stmtSequence;

} progNodeType;

typedef union nodeTypeTag {

	nodeEnum type;
	
	assgnNodeType assgn;
	ifNodeType ifStmt;
	writeIntNodeType writeInt;
	whileNodeType whileStmt;
	seqNodeType stmtSequence;
	declNodeType declarations;
	identNodeType ident;
	idtypeNodeType idtype;
	conNodeType con;
	progNodeType program;
	opNodeType op;

} nodeType;
