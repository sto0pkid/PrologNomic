:- module(game, [run_atom/3, kb_clause/1]).

:- use_module(library(yall)).

:- [persistence].

/*
Begin core game interpreter
*/

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

run_atom(Player, Goal_Atom, Result) :-
	atom_to_term(Goal_Atom, Goal, Vars),
	pretty_vars(Vars),
	run(Player, Goal, Result).

/*
End core game interpreter
*/


% helper function to replace variables with their proper names
pretty_vars(Vars) :-
	maplist([X,Y]>>(X = (Z=_), Y = '$VAR'(Z)),Vars, Vars3),
	maplist([S,T]>>(S = (_=T)),Vars,Vars4),
	maplist([M,N,O]>>(O = (M=N)), Vars3, Vars4, Vars5),
	maplist(ignore,Vars5).




/*
assert the initial move-validity check; this must bypass `run_atom` because in an empty kb, `is_valid(_,_)` is always false
could alternatively just be hardcoded into the kb
*/
:- 	atom_to_term("is_valid(Player, Move) :- true", Rule, Vars), 
	pretty_vars(Vars), 
	assert_kb_clause(Rule).
