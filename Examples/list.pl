list(empty).
list(cons(E, L)) :- list(L).

concat(empty, R, R).
concat(cons(E, L), R, LR) :- concat(L, R, LR), cons(E, LR).
