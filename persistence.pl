:- use_module(library(persistency)).

:- persistent kb_clause(term:any).

:- db_attach('kb/kb_clauses.pl', []).
