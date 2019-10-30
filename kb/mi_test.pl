created(1572028872.8950489).
assert(kb_clause(io(Input,Output) :- (goal(member(search(Options),Input)), goal(member(request=Request_String,Options)), term_string(Request, Request_String), goal(is_valid(Request)), findall(Result, (Request, format(string(Result),"~w",[Request])), Result_List), json_write(_{results:Result_List}, JSON), format(string(Output), "Content-type: application/json~n~n~w", [JSON])))).
assert(kb_clause(io(Input,Output) :- (goal(member(search(Options),Input)), goal(member(rules='get_rules',Options)), findall(Rule_String, (kb_clause(Rule), format(string(Rule_String), "~w", [Rule])), Rules), json_write(_{rules:Rules}, JSON), format(string(Output), "Content-type: application/json~n~n~w", [JSON])))).
assert(kb_clause(id(X,X))).
assert(kb_clause(naf(X) :- findall(dummy, X, []))).
assert(kb_clause(member(X, [X|_]))).
assert(kb_clause(member(X, [Y|Rest]) :- goal(member(X,Rest)))).
assert(kb_clause(is_valid(Request))).
