% reduce all of this to quads?
% reduce to triples?
% reduce to pairs?
% replace P(X1,...Xn) with:
% c b_i P X1.
% ...
% c b_i P Xn. 
%
% with fresh constant c_i for each distinct tuple X1,..,Xn..
% 
% P(f1(X1),...,fn(Xn)) with:
% ...
%

% ';' operator
or(X,Y) :- X.
or(X,Y) :- Y.

and(X,Y) :- X, Y.


% false & fail
false --> anything that's not provable


% unification
X = Y :- id(X,Y).
id(X,X).

% not(X)
% related: immutable rules
% the effect of not(X) should be to rule out any assertion that would imply X
% does not necessarily mean it should rule out the retraction of not(X)
%


% cut?
simulate ! with \+

choice :- Foo, !, Bar.
choice :- Baz.

replace with:

choice :- Foo, Bar.
choice :- \+ Foo, Baz.

simulate NAF with cut and fail

foo :- \+X, Y.

replace with:
foo :- X, !, fail.
foo :- Y.


% if then else?
(_->_;_) ?

% simulate if_then_else with <!, ',', ';' ':-'>
if_then_else(X,Y,Z) :- X, !, Y.
if_then_else(X,Y,Z) :- Z.

% take any rules of the form 
% HEAD0 :- ... Start ... , !, ... End ...
% Rule1
% ...
% RuleN
% replace with rule: HEAD0 :- if_then_else(Start, End, or(Rule1,...,RuleN)).


% logical implication?

% immutable rules
* use self-simulation to simulate a version of the game where the rule R is asserted and retract(R) gets interpreted as a no-op.

% quine?
* prolog quine has been demonstrated but not an in-game one

% reflection:
% var
var(X) :- id(X,foo), id(X,bar). % nope

var(X) :- id(X,foo). % nope; but.. this works whenever X is not foo.
var(X) :- id(X,bar).

% can simulate var with findall
var(X) :- findall(X,var_helper(X),[foo,bar]).
var_helper(foo).
var_helper(bar).



% functor



% simulate gensym with assert and retract
current_sym(0).
gensym(X) :- current_sym(X), retract(current_sym(X)), assert(current_sym(s(X))).
clear_gensym :- retract(current_sym(X)), assert(current_sym(0)).

% results counter; findall and length

% simulate findall with assert and retract
current_answers([]).

findall(_,_,_) :- retract(current_answers(_)), fail.
findall(_,_,_) :- assertz(current_answers([])), fail.
findall(What,In,Output) :- In, current_answers(X), retract(current_answers(X)), assertz(current_answers([What|X])), fail.
findall(_,_,Output) :- current_answers(Output).

% list operations
head([Head|Tail],Head).
tail([Head|Tail],Tail).
reverse([],[]).
reverse([X|Rest],Rev) :- reverse(RevRest), append(RevRest, [X], Rev).
append([],L2, L2).
append([X|Rest],L2, [X|Rest2]) :- append(Rest,L2,Rest2).
member(X,[X|Rest]).
member(X,[Y|Rest]) :- naf(id(X,Y)), member(X,Rest).
length([],0).
length([X|Rest],s(LengthRest)) :- length(Rest,LengthRest).

% arithmetic


% turing-completeness
% combinators
run([i,X | Rest]) :- !, run([X | Rest]).
run([k,X,Y | Rest]) :- !, run([X | Rest]).
run([s,X,Y,Z|Rest]) :- !, run([X,Z,[Y,Z] | Rest]).
run([[X|Rest1],Rest) :- !, append(Rest, [X|Rest1], Full), run(Full).
run(X,X).


% safe assert & retract


% self-simulation
% by turing-completeness we know already that we can self-simulate
% cf. the metainterpreter for the self-simulation.
% self-simulation + immersion
% communication and really coherence across meta-levels
%
% homoiconic & non-homoiconic self-simulation
% * ex.. x86.., different implementations of same thing

% subgames
% * mock games & meta-game updates

% hypotheticals

% type theory

% negation as failure
% can simuate with findall
naf(X) :- findall(dummy, X, []).

% block-chain: list of blocks
% really a tree of blocks
next_block(First_Block,Second_Block).

% proof-of-work
% restrictions on next_block relation

% get hash

% public-key crypto
% digital signature
sign(Message,Public_Key,Private_Key,Signed_Message) :-
check_signature(Message, Public_Key).

% encryption
encrypt(Decoded,Encoded)
* bidirectional?


% lambda-auth
% P2P I/O ?
% * can simulate read/write ?
% * peer network
% * peer addresses

% DHT
% web-of-trust
%
% self-replication

% is-valid check

% instead of inflooping, require user-input to keep listing results

% wait for input
receive_message(Message)
* from where?

% send output
send_message(Message)
* Message can include Target
send_message(Message,Target).

% assert that something can't receive input / send output 
% 

% 100% mutability
% always an escape hatch to immutability

% game history
% boot-strapping

% move the entire game into the rules
% 
%
% relativize the rules to the player
% * privacy
% * think of it like, the cards in your hand
% * take entire rule-sets as part of user-configuration
% 
%
% deterministic turing machine
% non-deterministic turing machine
% * non-determinism interpreted as user-input choice-points
% * or maybe just as branching based on some specified non-deterministic component of state
%   * with user-input just being one source of non-deterministic state
%   * or all non-deterministic state interpreted as user-input
% shared information
