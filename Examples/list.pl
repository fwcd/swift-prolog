list(empty).
list(cons(E, L)) :- list(L).

concat(empty, R, R).
concat(cons(E, L), R, cons(E, LR)) :- concat(L, R, LR).
