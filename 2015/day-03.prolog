:- use_module(library(dcg/basics)).

steps([]) --> eos, !.
steps([[-1, 0]|Ss]) --> `<`, !, steps(Ss).
steps([[ 1, 0]|Ss]) --> `>`, !, steps(Ss).
steps([[ 0,-1]|Ss]) --> `^`, !, steps(Ss).
steps([[ 0, 1]|Ss]) --> `v`, !, steps(Ss).

trace(Steps, Coordinates) :- scanl(maplist(plus), Steps, [0,0], Coordinates).
count_unique(List, Count) :- sort(List, S), length(S, Count).

% take_turns(`abcdef`, `ace`, `bdf`).
take_turns([], [], []).
take_turns([H|T], [H|U], V) :- take_turns(T, V, U).

answer(N1, N2) :-
    phrase_from_file(steps(Steps), 'input-03.txt'),
    trace(Steps, C),
    count_unique(C, N1),
    print(N1),
    
    take_turns(Steps, Pr, Ps),
    trace(Pr, Cr),
    trace(Ps, Cs),
    append(Cr, Cs, Cboth),
    count_unique(Cboth, N2).

