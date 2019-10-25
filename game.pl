:- module(game, [run/2, rule/1]).

:- dynamic rule/1.

rule(is_valid(_,_) :- true).

mi(true) :- !.

mi((A,B)) :-
	mi(A),
	mi(B),
	!.

mi(assertz(Rule)) :-
	(
		Rule = (Head :- Body)
	->
		(
			\+predicate_property(Head, built_in),
			assertz(rule(Head :- Body))
		)
	;
		(
			\+predicate_property(Rule, built_in),
			assertz(rule(Rule :- true))
		)
	),
	!.

mi(retract(Rule)) :-
	(
		Rule = (Head :- Body)
	->
		retract(rule(Head :- Body))
	;
		retract(rule(Rule :- true))
	),
	!.

mi(Goal) :-
	rule(Goal :- Body),
	mi(Body).

run(Player, Goal) :-
	mi(is_valid(Player, Goal)),
	mi(Goal).
