:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/json)).
:- use_module(game_pretty).
:- use_module(library(yall)).

:- http_handler(root(.), http_reply_file('index.html',[]), []).
:- http_handler(root(move), submit_move, []).
:- http_handler(root(rules), return_rules, []).




submit_move(Request) :-
	member(search(Options), Request),
	member(player=Player, Options),
	member(move=Move_String, Options),
	term_string(Move, Move_String),
	findall(
		Output_String,
		(
			run(Player, Move, Result),
			format(string(Output_String),"~w",[Result])
		),
		Output
	),
	get_rules(Rules),
	send_output(json(_{output:Output,rules:Rules})).

% typed streams


% rules_message + get_rules + send_output
return_rules(_) :-
	get_rules(Rules),
	send_output(json(_{rules:Rules})).

% term-string instead of format
get_rules(Rules) :-
	findall(
		Rulestring,
		(
			kb_clause(Rule),
			format(string(Rulestring), "~w", [Rule])
		),
		Rules
	).
