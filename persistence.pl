:- use_module(library(persistency)).

:- persistent 
	kb_clause(term:any).

:- db_attach('kb/kb_clauses.pl', []).

/*
* Need to:
* * persist the actual text rather than prolog terms
* * load the prolog terms from the text
*
*/
