% Internal metainterpreter; can interpret itself.
mi(true).

mi((A,B)) :- mi(A), mi(B).

mi(assert(Rule)) :- assert(Rule).

mi(retract(Rule)) :- retract(Rule).

mi(term_string(Term,String)) :- term_string(Term,String).

mi(write(Output)) :- write_output(Output).

mi(format(string(String), Template, Values)) :- format(string(String), Template, Values).

mi(json_write(string(String), JSON)) :- json_write(string(String), JSON).

mi(findall(What,Goal,Results)) :- findall(What,Goal,Results).

mi(kb_clause(KB_Clause)) :- kb_clause(KB_Clause).

mi(http_reply_file("index.html")) :- http_reply_file("index.html").

mi(goal(Head)) :- kb_clause(Head :- Body), mi(Body).

mi(goal(Fact)) :- kb_clause(Fact).
