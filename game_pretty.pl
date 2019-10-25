:- module(game, [run/3, kb_clause/1]).

:- use_module(library(yall)).

:- [persistence].

mi(true) :- !.

mi((A,B)) :-
	!,
	mi(A),
	mi(B).

mi(assert(Rule)) :-
	!,
	(
		Rule = (Head :- Body)
	->
		true
	;
		(Rule = Head, Body = true)
	),
	\+predicate_property(Head, built_in),
	assert_kb_clause(Head :- Body).

/* should maybe be direct string equivalence */
mi(retract(Rule)) :-
	!,
	(
		Rule = (Head :- Body)
	->
		true
	;
		(Rule = Head, Body = true)
	),
	retract_kb_clause(Head :- Body).

mi(retractall(Rule)) :-
	!,
	(
		Rule = (Head :- Body)
	->
		true
	;
		(Rule = Head, Body = true)
	),
	retractall_kb_clause(Head :- Body).

mi(Goal) :-
	kb_clause(Goal :- Body),
	mi(Body).

run(Player, Goal, Result) :-
	(
		mi(is_valid(Player, Goal))
	->
		(
			Result = Goal,
			mi(Goal)
		)
	;
		Result = "Invalid move"
	).
