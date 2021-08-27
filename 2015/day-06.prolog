:- use_module(library(dcg/basics)).
:- use_module(library(ordsets)).
:- [util].

point(X-Y) --> integer(X), `,`, integer(Y), !.
command(toggle(P0,P1)) --> `toggle `,   point(P0), ` through `, point(P1), !.
command(off(P0,P1))    --> `turn off `, point(P0), ` through `, point(P1), !.
command(on(P0,P1))     --> `turn on `,  point(P0), ` through `, point(P1), !.

% sloooow
% update(toggle(P0,P1), S0, S1) :- rect(P0, P1, R), ord_symdiff(S0, R, S1), !.
% update(off(P0,P1), S0, S1)    :- rect(P0, P1, R), ord_subtract(S0, R, S1), !.
% update(on(P0,P1), S0, S1)     :- rect(P0, P1, R), ord_union(S0, R, S1), !.

% what if... (oh no)
update(A, toggle(X0-X1,Y0-Y1)) :- forall( (between(X0,X1,X), between(Y0,Y1,Y)), (I is X*1000+Y+1, arg(I,A,Old), New is 1-Old, nb_setarg(I,A,New)) ), !.
update(A, off(X0-X1,Y0-Y1)) :- forall( (between(X0,X1,X), between(Y0,Y1,Y)), (I is X*1000+Y+1, nb_setarg(I,A,0)) ), !.
update(A, on(X0-X1,Y0-Y1)) :- forall( (between(X0,X1,X), between(Y0,Y1,Y)), (I is X*1000+Y+1, nb_setarg(I,A,1)) ), !.

answer(N1) :-
  phrase_lines_from_file(command, 'input-06.txt', Cs),
  functor(A, arr, 1000000),
  forall(between(1,1000000,I), nb_setarg(I,A,0)),
  forall(member(C, Cs), update(A, C)), !,
  print(A),
  % then sum the values? oh no this is completely imperative but still sooo slow ;_;
  N1 = 0.