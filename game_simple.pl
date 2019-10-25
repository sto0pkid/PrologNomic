:- module(game, [run/2, rule/1]).

:- dynamic rule/1.

rule(is_valid(_,_) :- true).

mi(true) :- !.

mi((A,B)) :-
	!,
	mi(A),
	mi(B).

mi(assertz(Head :- Body)) :-
	!,
	\+predicate_property(Head, built_in),
	assertz(rule(Head :- Body)).

mi(retract(Rule)) :-
	!,
	retract(rule(Rule)).

mi(Goal) :-
	rule(Goal :- Body),
	mi(Body).

run(Player, Goal) :-
	mi(is_valid(Player, Goal)),
	mi(Goal).
