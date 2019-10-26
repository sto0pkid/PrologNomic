:- module(game, [run/3, kb_clause/1]).

:- use_module(library(yall)).

:- [persistence].

mi(true) :- !.

mi((A,B)) :- !, mi(A), mi(B).

mi(assert(Rule)) :- !, assert_kb_clause(Rule).

mi(retract(Rule)) :- !, retract_kb_clause(Rule).

mi(Head) :-
	kb_clause(Head :- Body),
	!,
	mi(Body).

mi(Fact) :- kb_clause(Fact).

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
