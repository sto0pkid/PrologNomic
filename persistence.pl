:- use_module(library(persistency)).

:- persistent kb_clause(term:any), names(term:any, vars:list(any)).

:- db_attach('kb/kb_clauses.pl', []).
