grammar YAPLGrammar;

program: programBlocks EOF;

programBlocks: classdef ';' programBlocks | EOF;

classdef: CLASS TYPE ('inherits' TYPE)? '{' (feature ';')* '}';

feature:
	ID '(' (formal (',' formal)*)? ')' ':' TYPE '{' expr '}'
	| ID ':' TYPE (ASSIGNMENT expr)?;

formal: ID ':' TYPE;

expr:
	expr ('@' TYPE)? '.' ID '(' (expr (',' expr)*)? ')'
	| ID '(' (expr (',' expr)*)? ')'
	| IF expr THEN expr ELSE expr FI
	| WHILE expr LOOP expr POOL
	| '{' (expr ';')+ '}'
	| LET ID ':' TYPE (ASSIGNMENT expr)? (
		',' ID ':' TYPE (ASSIGNMENT expr)?
	)* IN expr
	| CASE expr OF (ID ':' TYPE CASE_ARROW expr ';')+ ESAC
	| NEW TYPE
	| ISVOID expr
	| expr MULTIPLY expr
	| expr DIVISION expr
	| expr ADD expr
	| expr MINUS expr
	| INTEGER_NEGATIVE expr
	| expr LESS_THAN expr
	| expr LESS_EQUAL expr
	| expr EQUAL expr
	| NOT expr
	| '(' expr ')'
	| ID
	| INT
	| STRING
	| TRUE
	| FALSE
	| ID ASSIGNMENT expr;

CLASS: C L A S S;

ELSE: E L S E;

FALSE: 'f' A L S E;

FI: F I;

IF: I F;

IN: I N;

INHERITS: I N H E R I T S;

ISVOID: I S V O I D;

LET: L E T;

LOOP: L O O P;

POOL: P O O L;

THEN: T H E N;

WHILE: W H I L E;

CASE: C A S E;

ESAC: E S A C;

NEW: N E W;

OF: O F;

NOT: N O T;

TRUE: 't' R U E;

STRING: '"' (ESC | ~ ["\\])* '"';

INT: [0-9]+;

TYPE: [A-Z] [_0-9A-Za-z]*;

ID: [a-z] [_0-9A-Za-z]*;

ASSIGNMENT: '<-';

CASE_ARROW: '=>';

ADD: '+';

MINUS: '-';

MULTIPLY: '*';

DIVISION: '/';

LESS_THAN: '<';

LESS_EQUAL: '<=';

EQUAL: '=';

INTEGER_NEGATIVE: '~';

fragment A: [aA];

fragment C: [cC];

fragment D: [dD];

fragment E: [eE];

fragment F: [fF];

fragment H: [hH];

fragment I: [iI];

fragment L: [lL];

fragment N: [nN];

fragment O: [oO];

fragment P: [pP];

fragment R: [rR];

fragment S: [sS];

fragment T: [tT];

fragment U: [uU];

fragment V: [vV];

fragment W: [wW];

fragment ESC: '\\' (["\\/bfnrt] | UNICODE);

fragment UNICODE: 'u' HEX HEX HEX HEX;

fragment HEX: [0-9a-fA-F];
// comments

OPEN_COMMENT: '(*';

CLOSE_COMMENT: '*)';

COMMENT: OPEN_COMMENT (COMMENT | .)*? CLOSE_COMMENT -> skip;

ONE_LINE_COMMENT: '--' (~ '\n')* '\n'? -> skip;
// skip spaces, tabs, newlines, note that \v is not suppoted in antlr

WHITESPACE: [ \t\r\n\f]+ -> skip;

case_expr: ID ':' TYPE '=>' expr ';';
