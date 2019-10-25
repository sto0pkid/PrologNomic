:- module(game, [run_atom/3, run/4, rule/1, pretty_rule/1, assertz_with_names/2, retract_with_names/2, clause_with_names/3, names/2]).

:- use_module(library(yall)).

:- dynamic rule/1.  % wrapper functor for in-game rules
:- dynamic names/2. % used to keep track of variable names by the ifprolog stuff below

/*
Begin core game interpreter
*/

mi(true, _) :- !.

mi((A,B), Vars) :-
	!,
	mi(A, Vars),
	mi(B, Vars).

mi(assert(Rule), Vars) :-
	!,
	(
		Rule = (Head :- Body)
	->
		true
	;
		(Rule = Head, Body = true)
	),
	\+predicate_property(Head, built_in),
	assertz_with_names(rule(Head :- Body), Vars).

mi(retract(Rule), Vars) :-
	!,
	(
		Rule = (Head :- Body)
	->
		true
	;
		(Rule = Head, Body = true)
	),
	retract_with_names(rule(Head :- Body), Vars).

mi(Goal, Vars) :-
	rule(Goal :- Body),
	mi(Body, Vars).

run(Player, Goal, Vars, Result) :-
	(
		mi(is_valid(Player, Goal), Vars)
	->
		(
			Result = Goal,
			mi(Goal, Vars)
		)
	;
		Result = "Invalid move"
	).

run_atom(Player, Goal_Atom, Result) :-
	atom_to_term(Goal_Atom, Goal, Vars),
	run(Player, Goal, Vars, Result),
	pretty_vars(Vars).

/*
End core game interpreter
*/



/*
these two predicates are for actually replacing variables in a given term with their proper variable names
*/
pretty_rule(Rule) :-
	clause_with_names(rule(Rule),true,Vars),
	pretty_vars(Vars).

/*
some crazy hackery a la dmiles to actually perform the variable-name replacement
*/
pretty_vars(Vars) :-
	maplist([X,Y]>>(X = (Z=_), Y = '$VAR'(Z)),Vars, Vars3),
	maplist([S,T]>>(S = (_=T)),Vars,Vars4),
	maplist([M,N,O]>>(O = (M=N)), Vars3, Vars4, Vars5),
	maplist(ignore,Vars5).



/*
these predicates are just like regular assert/retract but they don't lose variable names
originally from library(dialect/ifprolog), but the code there is broken
*/
assertz_with_names(Clause, VarNames) :-
	term_varnames(Clause, VarNames, VarTerm),
	assertz(Clause, Ref),
	asserta(names(Ref, VarTerm)).

term_varnames(Term, VarNames, VarTerm) :-
	findall(
		Vars,
		( 
			term_variables(Term, Vars),
			bind_names(VarNames)
		),
		[ VarList ]
	),
	VarTerm =.. [ v | VarList ].

bind_names([]).
bind_names([Name=Var|T]) :-
	Name=Var,
	bind_names(T).

clause_with_names(Head, Body, VarNames) :-
	% wrap variable goals in the Body with call/1 to match what will be returned by clause/3
	replace_vars_with_calls(Body, Body_Calls),
	clause(Head, Body_Calls, Ref),
	(   names(Ref, VarTerm)
	->  
		(
			term_variables((Head:-Body), Vars),
			VarTerm =.. [v|NameList],
			make_bindings(NameList, Vars, VarNames)
		)
	;   
			VarNames = []
	).

retract_with_names(Rule, VarNames) :-
	(
		Rule = (Head :- Body)
	->
		true
	;
		(
			Head = Rule,
			Body = true
		)
	),
	% wrap variable goals in the Body with call/1 to match what will be returned by clause/3
	replace_vars_with_calls(Body, Body_Calls),
	clause(Head, Body_Calls, Ref),
	erase(Ref),
	(   
		retract(names(Ref, VarTerm))
	->  
		(
			term_variables((Head :- Body), Vars),
			VarTerm =.. [v|NameList],
			make_bindings(NameList, Vars, VarNames)
		)
	;   
		VarNames = []
	).

make_bindings([], [], []).
make_bindings([Name|NT], [Var|VT], [Name=Var|BT]) :-
	make_bindings(NT, VT, BT).


/*
this is part of the fix for the ifprolog assert/retract/clause_with_names stuff above

if you assert a rule like:
assertz(and(X,Y) :- (X, Y)), the variable goals in the body get automatically wrapped in call/1 by prolog
if you want to then find those rules using ex. clause/3, you can't just use the original form,
you need the variable goals to be wrapped in call/1
so far I can't find a built-in predicate that will do this

*/
replace_vars_with_calls(Goal, call(Goal)) :-
	var(Goal),
	!.
	
replace_vars_with_calls(Goal, Goal_Calls) :-
	Goal =.. [',' | Rest],
	!,
	findall(
		Subgoal_Call,
		(
			member(Subgoal, Rest),
			replace_vars_with_calls(Subgoal, Subgoal_Call)
		),
		Goal_Call_List
	),
	Goal_Calls =.. [',' | Goal_Call_List].

replace_vars_with_calls(Goal, Goal).


/*
assert the initial move-validity check
*/
:- assertz_with_names(rule(is_valid(Player,Move) :- true), ['Player'=Player, 'Move'=Move]).
