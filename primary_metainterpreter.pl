:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/json)).
:- use_module(library(persistency)).

:- persistent kb_clause(term:any).

:- db_attach('kb/mi_test.pl', []).

:- http_handler(root(.), http_reply_file('index.html',[]), []).
:- http_handler(root(request), io, []).


% can't interpret itself but it can interpret the internal metainterpreter which can interpret itself
mi(true).

mi((A,B)) :- mi(A), mi(B).

mi(assert(Rule)) :- assert_kb_clause(Rule).

mi(retract(Rule)) :- retract_kb_clause(Rule).

mi(term_string(Term,String)) :- term_string(Term,String).

mi(format(string(String), Template, Values)) :- format(string(String), Template, Values).

mi(json_write(JSON,String)) :- with_output_to(string(String), json_write_dict(current_output, JSON)).

mi(findall(What,Goal,Results)) :- findall(What,mi(Goal),Results).

mi(kb_clause(KB_Clause)) :- kb_clause(KB_Clause).

mi(goal(Head)) :- kb_clause(Head :- Body), mi(Body).

mi(goal(Fact)) :- kb_clause(Fact).

% escape-hatch: unsafe
% note that all the builtins except assert/retract and ',' can be treated by going through meta
% mi(meta(Goal)) :- Goal.

io(Input) :- mi(goal(io(Input,Output))), write(Output).
