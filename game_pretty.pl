:- module(game, [run_atom/3, run/3, rule/1, pretty_rule/1, assertz_with_names/2, retract_with_names/2, clause_with_names/3, names/2]).

%:- use_module(library(dialect/ifprolog)).
:- use_module(library(yall)).

:- dynamic rule/1.
:- dynamic names/2.

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
		(
			\+predicate_property(Head, built_in),
			assertz_with_names(rule(Head :- Body), Vars)
		)
	;
		(
			\+predicate_property(Rule, built_in),
			assertz_with_names(rule(Rule :- true), Vars)
		)
	).

mi(retract(Rule), Vars) :-
	!,
	(
		Rule = (Head :- Body)
	->
		retract_with_names(rule(Head :- Body), Vars)
	;
		retract_with_names(rule(Rule :- true), Vars)
	).

mi(Goal, Vars) :-
	rule(Goal :- Body),
	mi(Body, Vars).

run(Player, Goal, Vars) :-
	mi(is_valid(Player, Goal), Vars),
	mi(Goal, Vars).

run_atom(Player, Goal_Atom, Goal) :-
	atom_to_term(Goal_Atom, Goal, Vars),
	run(Player, Goal, Vars),
	pretty_vars(Vars).

pretty_rule(Rule) :-
	clause_with_names(rule(Rule),true,Vars),
	pretty_vars(Vars).
	/*
	maplist([X,Y]>>(X = (Z=_), Y = '$VAR'(Z)),Vars2, Vars3),
	maplist([S,T]>>(S = (_=T)),Vars2,Vars4),
	maplist([M,N,O]>>(O = (M=N)), Vars3, Vars4, Vars5),
	maplist(ignore,Vars5).
	*/
pretty_vars(Vars) :-
	maplist([X,Y]>>(X = (Z=_), Y = '$VAR'(Z)),Vars, Vars3),
	maplist([S,T]>>(S = (_=T)),Vars,Vars4),
	maplist([M,N,O]>>(O = (M=N)), Vars3, Vars4, Vars5),
	maplist(ignore,Vars5).



/*
because library(dialect/ifprolog) is broken
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

make_bindings([], [], []).
make_bindings([Name|NT], [Var|VT], [Name=Var|BT]) :-
	make_bindings(NT, VT, BT).

:- assertz_with_names(rule(is_valid(Player,Move) :- true), ['Player'=Player, 'Move'=Move]).
