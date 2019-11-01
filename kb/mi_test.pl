created(1572028872.8950489).
assert(kb_clause(io(Input,Output) :- (goal(get_http_request(Input,Request)), goal(process_request(Request,Output_JSON)), goal(http_json(Output_JSON,Output))))).
assert(kb_clause(process_request(request(Request),_{results:Result_List}) :- (goal(is_valid(Request)), findall(Result, (goal(mi(Request)), format(string(Result),"~w",[Request])), Result_List)))).
assert(kb_clause(process_request(get_rules,_{rules:Rules}) :- (findall(Rule_String, (kb_clause(Rule), format(string(Rule_String), "~w", [Rule])), Rules)))).
assert(kb_clause(process_request(get_internal_rules,_{rules:Rules}) :- (findall(Rule, kb_clause(rule(Rule,_)), Rules)))).
assert(kb_clause(id(X,X))).
assert(kb_clause(naf(X) :- findall(dummy, X, []))).
assert(kb_clause(member(X, [X|_]))).
assert(kb_clause(member(X, [Y|Rest]) :- goal(member(X,Rest)))).
assert(kb_clause(is_valid(Request))).
assert(kb_clause(http_json(JSON,Output) :- (json_write(JSON, JSON_String), format(string(Output), "Content-type: application/json~n~n~w", [JSON_String])))).
assert(kb_clause(get_http_request(Request,Output) :- (goal(member(search(Options),Request)), goal(member(request=Request_String, Options)), term_string(Output, Request_String)))).
assert(kb_clause(peer(8.8.8.8))).
assert(kb_clause(mi(true))).
assert(kb_clause(mi((A,B)) :- (goal(mi(A)), goal(mi(B))))).
assert(kb_clause(mi(assert(Rule_String)) :- (term_string(Rule, Rule_String), assert(rule(Rule_String,Rule))))).
assert(kb_clause(mi(retract(Rule_String)) :- retract(rule(Rule_String,_)))).
assert(kb_clause(mi(retractall(Rule_String)) :- (kb_clause(rule(Rule_String, Rule)), term_string(Rule_Found, Rule_String), subsumes_term(Rule,Rule_Found), retract(rule(Rule_String,Rule))))).
assert(kb_clause(mi(goal(Head)) :- (kb_clause(rule(_,Head :- Body)), goal(mi(Body))))).
assert(kb_clause(mi(goal(Fact)) :- (kb_clause(rule(_,Fact))))).
assert(kb_clause(mi(meta(Goal)) :- Goal)).
assert(kb_clause(rule("foo(Bar,Baz)",foo(_,_)))).
assert(kb_clause(rule("foo(1,2)",foo(1,2)))).
assert(kb_clause(rule("foo(2,3)",foo(2,3)))).
assert(kb_clause(rule("foo(1,3)",foo(1,3)))).
retract(kb_clause(rule("foo(Bar,Baz)",foo(1,_)))).
retract(kb_clause(rule("foo(1,2)",foo(1,2)))).
retract(kb_clause(rule("foo(1,3)",foo(1,3)))).
assert(kb_clause(rule("foo(1,2)",foo(1,2)))).
assert(kb_clause(rule("foo(1,3)",foo(1,3)))).
assert(kb_clause(rule("foo(1,4)",foo(1,4)))).
assert(kb_clause(rule("foo(Bar,Baz)",foo(_,_)))).
retract(kb_clause(rule("foo(1,2)",foo(1,2)))).
retract(kb_clause(rule("foo(1,3)",foo(1,3)))).
retract(kb_clause(rule("foo(1,4)",foo(1,4)))).
retract(kb_clause(rule("foo(Bar,Baz)",foo(1,_)))).
assert(kb_clause(rule("foo(Bar,Baz)",foo(_,_)))).
assert(kb_clause(rule("foo(1,2)",foo(1,2)))).
assert(kb_clause(rule("foo(1,3)",foo(1,3)))).
retract(kb_clause(rule("foo(1,2)",foo(1,2)))).
retract(kb_clause(rule("foo(1,3)",foo(1,3)))).
assert(kb_clause(rule("meta(io(Input,Output) :- (goal(get_http_request(Input,Request)), goal(process_request(Request,Output_JSON)), goal(http_json(Output_JSON,Output))))", meta(io(Input,Output) :- (goal(get_http_request(Input,Request)), goal(process_request(Request,Output_JSON)), goal(http_json(Output_JSON,Output))))))).
assert(kb_clause(rule("meta(process_request(request(Request),_{results:Result_List}) :- (goal(is_valid(Request)), findall(Result, (goal(mi(Request)), format(string(Result),\"~w\",[Request])), Result_List)))",meta(process_request(request(Request),_{results:Result_List}) :- (goal(is_valid(Request)), findall(Result, (goal(mi(Request)), format(string(Result),"~w",[Request])), Result_List)))))).
assert(kb_clause(rule("meta(process_request(get_rules,_{rules:Rules}) :- (findall(Rule_String, (kb_clause(Rule), format(string(Rule_String), \"~w\", [Rule])), Rules)))",meta(process_request(get_rules,_{rules:Rules}) :- (findall(Rule_String, (kb_clause(Rule), format(string(Rule_String), "~w", [Rule])), Rules)))))).
assert(kb_clause(rule("meta(process_request(get_internal_rules,_{rules:Rules}) :- (findall(Rule, kb_clause(rule(Rule,_)), Rules)))",meta(process_request(get_internal_rules,_{rules:Rules}) :- (findall(Rule, kb_clause(rule(Rule,_)), Rules)))))).
assert(kb_clause(rule("meta(id(X,X))",meta(id(X,X))))).
assert(kb_clause(rule("meta(naf(X) :- findall(dummy, X, []))",meta(naf(X) :- findall(dummy, X, []))))).
assert(kb_clause(rule("meta(member(X, [X|_]))",meta(member(X, [X|_]))))).
assert(kb_clause(rule("meta(member(X, [Y|Rest]) :- goal(member(X,Rest)))",meta(member(X, [Y|Rest]) :- goal(member(X,Rest)))))).
assert(kb_clause(rule("meta(is_valid(Request))",meta(is_valid(Request))))).
assert(kb_clause(rule("meta(http_json(JSON,Output) :- (json_write(JSON, JSON_String), format(string(Output), \"Content-type: application/json~n~n~w\", [JSON_String])))",meta(http_json(JSON,Output) :- (json_write(JSON, JSON_String), format(string(Output), "Content-type: application/json~n~n~w", [JSON_String])))))).
assert(kb_clause(rule("meta(get_http_request(Request,Output) :- (goal(member(search(Options),Request)), goal(member(request=Request_String, Options)), term_string(Output, Request_String)))",meta(get_http_request(Request,Output) :- (goal(member(search(Options),Request)), goal(member(request=Request_String, Options)), term_string(Output, Request_String)))))).
assert(kb_clause(rule("meta(mi(true))",meta(mi(true))))).
assert(kb_clause(rule("meta(mi((A,B)) :- (goal(mi(A)), goal(mi(B))))",meta(mi((A,B)) :- (goal(mi(A)), goal(mi(B))))))).
assert(kb_clause(rule("meta(mi(assert(Rule_String)) :- (term_string(Rule, Rule_String), assert(rule(Rule_String,Rule))))",meta(mi(assert(Rule_String)) :- (term_string(Rule, Rule_String), assert(rule(Rule_String,Rule))))))).
assert(kb_clause(rule("meta(mi(retract(Rule_String)) :- retract(rule(Rule_String,_)))",meta(mi(retract(Rule_String)) :- retract(rule(Rule_String,_)))))).
assert(kb_clause(rule("meta(mi(retractall(Rule_String)) :- (kb_clause(rule(Rule_String, Rule)), term_string(Rule_Found, Rule_String), subsumes_term(Rule,Rule_Found), retract(rule(Rule_String,Rule))))",meta(mi(retractall(Rule_String)) :- (kb_clause(rule(Rule_String, Rule)), term_string(Rule_Found, Rule_String), subsumes_term(Rule,Rule_Found), retract(rule(Rule_String,Rule))))))).
assert(kb_clause(rule("meta(mi(goal(Head)) :- (kb_clause(rule(_,Head :- Body)), goal(mi(Body))))",meta(mi(goal(Head)) :- (kb_clause(rule(_,Head :- Body)), goal(mi(Body))))))).
assert(kb_clause(rule("meta(mi(goal(Fact)) :- (kb_clause(rule(_,Fact))))",meta(mi(goal(Fact)) :- (kb_clause(rule(_,Fact))))))).
assert(kb_clause(rule("meta(mi(meta(Goal)) :- Goal))",meta(mi(meta(Goal)) :- Goal)))).
assert(kb_clause(rule("foo(1,2)",foo(1,2)))).
assert(kb_clause(rule("foo(1,3)",foo(1,3)))).
assert(kb_clause(rule("foo(1,4)",foo(1,4)))).
assert(kb_clause(rule("foo(1,5)",foo(1,5)))).
assert(kb_clause(rule("foo(1,6)",foo(1,6)))).
assert(kb_clause(rule("foo(1,7)",foo(1,7)))).
