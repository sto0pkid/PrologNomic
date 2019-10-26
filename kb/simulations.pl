% disjunction
or(X,Y) :- X.
or(X,Y) :- Y.

% false & fail
false --> anything that's not provable


% unification
X = Y :- id(X,Y).
id(X,X).

% not(X)
is_valid(assert(X)) :- false.
is_valid(assert(is_valid(assert(X)) :- Y)) :- false
is_valid(retract(is_valid(assert(X)) :- false)) :- false.



% cut?

% if then else?
(_->_;_) ?

% logical implication?

% is it possible to make a rule that says that it can't be retracted?
is_valid(retract(X)) :- false.

% quine
quine(quine(X) :- subst(X,quine(X) :- Y), subst(Z)) :- subst(X, quine(X) :- Y), subst(Z,)

quine(X) :- format(string(X), "~w [\"~w\"]).", ["quine(X) :- format(string(X), \"~w [\"~w\"]).\""]).



quine(X) :- X = quine(

% var

% substitution

% turing-completeness
