created(1572028872.8950489).
assert(kb_clause((is_valid(Player,Move):-true))).
% could also be done as part of the validity check, i.e. don't actually run it until each subgoal has been checked individually
% i.e. not like "transactions" per say w/ assertions and retracts but just some kind of check that would make sure that every part
% will actually go through before running it
% idk, maybe that doesn't make sense

assert(kb_clause((is_valid(Player,assert(tx(X)))))).
assert(kb_clause((is_valid(Player,retract(tx(X)))))).
assert(kb_clause((is_valid(Player,retract(X)) :- tx(assert(X))))).
assert(kb_clause((is_valid(Player,assert(X)) :- tx(retract(X))))).

assert(kb_clause((foo(_,_):-true))).
assert(kb_clause((foo(_,_):-true))).
assert(kb_clause(loves(stoopkid,tacos))).

%assert(kb_clause(X :- kb(X))). % and maybe wouldn't need this yea sounds good i guess
%assert(kb_clause(X :- X \= tx(_), tx(X))). % and i guess whether this is the case would be up to the rules


assert(kb_clause(tx_begin :- retract(tx(_)))).

assert(kb_clause(tx_assert(X) :- (assert(tx(assert(X))),assert(X),!))).
assert(kb_clause(tx_assert(_) :- tx_cancel)).

assert(kb_clause(tx_retract(X) :- (assert(tx(retract(X))), retract(X), !))).
assert(kb_clause(tx_retract(_) :- tx_cancel)).
_
assert(kb_clause(tx_cancel :- tx(assert(X)), retract(X), retract(tx(assert(X))).
assert(kb_clause(tx_cancel :- tx(retract(X)), assert(X), retract(tx(retract(X))).




assert(kb_clause((tx_end :- tx(X), assert(X)))). % maybe just assert(X) here?

% does assert(tx(X)) succeeding imply that assert(X) will succeed?
