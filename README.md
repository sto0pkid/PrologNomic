# PrologNomic

A Nomic game platform based on SWI-Prolog.

### How to Play
A move is made by submitting any Prolog code (actually only a limited fragment of Prolog is supported). The "Current Rules" represent the current Prolog knowledge-base. A move is a query against this knowledge base. For example, if the current ruleset is:

```
loves(alice,tacos)
loves(alice,burritos)
loves(bob,pancakes)
```

then the move `loves(alice,What)` will return the results:

```
loves(alice,tacos)
`loves(alice,burritos)
```

Variables are represented as uppercase terms, for example in `loves(alice,What)`, the term alice is a literal term, but the term What is a variable that can match with any other term.

If you want to assert a new fact or rule, you do so using the `assert` keyword. For example, the move `assert(loves(bob,waffles))` will add the fact `loves(bob,waffles)` to the current rule-set. If you want to retract a fact or rule, this can be done by using the `retract` keyword instead of assert.

Rules are represented using the `:-` keyword. For example:

`parent_of(Parent,Child) :- child_of(Child,Parent).`

This can be interpreted as saying, "If Child is the child of Parent, then Parent is the parent of Child."

Moves are guarded by the `is_valid` predicate. For any move, `Move`, by a player, `Player`, the following query will be executed against the current code-base: `is_valid(Player,Move)`. If this query succeeds, then the move will be executed, and otherwise it won't be. This predicate can be changed just like any other, and this is what makes it into a Nomic game instead of just a shared Prolog knowledge-base.

For more information on Prolog, there are many tutorials available online, for example https://en.wikibooks.org/wiki/Prolog/Introduction 
