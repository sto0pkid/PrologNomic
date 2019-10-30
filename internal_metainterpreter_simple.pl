assert(kb_clause(mi(true))).
assert(kb_clause(mi((A,B)) :- (goal(mi(A)), goal(mi(B))))).
assert(kb_clause(mi(goal(Head)) :- (kb_clause(Head :- Body), goal(mi(Body))))).
assert(kb_clause(mi(goal(Fact)) :- kb_clause(Fact))).
assert(kb_clause(mi(meta(Goal)) :- Goal)).
