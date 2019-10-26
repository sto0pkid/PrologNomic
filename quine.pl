:- module(quine, [quine/1]).

:- dynamic quine/1.

quine(X) :- duplicate("quine(X) :- duplicate(\"~w\",L), format(string(X), \"~w\", L)",L), format(string(X), "quine(X) :- duplicate(\"~w\",L), format(string(X), \"~w\", L)",L).
duplicate(X,[Y,Y]) :-
	escape_str(X,Y).

escape_str(Str, Escaped_Str) :- 
	atom_chars(Str,Chars),
	findall(
		Escaped_Char,
		(
			member(Char,Chars),
			escape_char(Char,Escaped_Char)
		),
		Escaped_Chars0
	),
	flatten(Escaped_Chars0,Escaped_Chars),
	atom_chars(Escaped_Atom,Escaped_Chars),
	atom_string(Escaped_Atom,Escaped_Str).

escape_char('\\',['\\','\\']) :- !.
escape_char('"',['\\','"']) :- !.
escape_char(X,X).

:- quine(X), read_term_from_atom(X, Quine_Rule, []), retract(Quine_Rule).
