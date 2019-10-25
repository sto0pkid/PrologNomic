:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/json)).
:- use_module(game_pretty).
:- use_module(library(yall)).

:- http_handler(root(.), http_reply_file('index.html',[]), []).
:- http_handler(root(move), submit_move, []).
:- http_handler(root(rules), return_rules, []).

submit_move(Request) :-
	format('Content-type: application/json~n~n'),
	member(search(Options), Request),
	member(player=Player, Options),
	member(move=Move_String, Options),
	findall(
		Output_String,
		(
			run_atom(Player, Move_String, Result),
			format(string(Output_String),"~w",[Result])
		),
		Output
	),
	get_rules(Rules),
	json_write_dict(current_output, _{output:Output,rules:Rules}).

return_rules(_) :-
	get_rules(Rules),
	format('Content-type: application/json~n~n'),
	json_write_dict(current_output, _{rules:Rules}).

get_rules(Rules) :-
	findall(
		Rulestring,
		(
			kb_clause(Rule),
			format(string(Rulestring), "~w", [Rule])
		),
		Rules
	).


:- http_daemon.
