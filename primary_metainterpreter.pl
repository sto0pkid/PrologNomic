:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(persistency)).

:- persistent kb_clause(term:any).

:- db_attach('GameHistory/history.pl', []).

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

mi(subsumes_term(Generic,Specific)) :- subsumes_term(Generic,Specific).

mi(copy_term(In,Out)) :- copy_term(In,Out).

mi(kb_clause(KB_Clause)) :- kb_clause(KB_Clause).

mi(git_commit) :- 
	setup_call_cleanup(
		process_create("/usr/bin/git", ["--git-dir=.git/modules/GameHistory", "commit", "-a", "-m", "Updating game history"], []),
		true,
		true
	).

%mi(http_get(URL, Data, Options)) :- http_get(URL, Data, Options).

%mi(rsa_verify(Public_Key, Data, Signature, Options)) :- rsa_verify(Public_Key, Data, Signature, Options).

mi(goal(Head)) :- kb_clause(Head :- Body), mi(Body).

mi(goal(Fact)) :- kb_clause(Fact).

% escape-hatch: unsafe
% note that all the builtins except assert/retract and ',' can be treated by going through meta
% mi(meta(Goal)) :- Goal.

io(Input) :- mi(goal(io(Input,Output))), write(Output).
