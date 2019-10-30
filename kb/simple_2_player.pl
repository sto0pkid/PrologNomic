created(1572028872.8950489).
assert(kb_clause((is_valid(Current,Move):-(current_player(Current),next_player(Current,Next),retract(current_player(Current)),assert(current_player(Next)))))).
assert(kb_clause(current_player(player1))).
assert(kb_clause(next_player(player1,player2))).
assert(kb_clause(next_player(player2,player1))).
