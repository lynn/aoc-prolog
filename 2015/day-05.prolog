:- [util].

vowel --> `a` | `e` | `i` | `o` | `u`.
any --> string(_).
vowelful --> any, vowel, any, vowel, any, vowel, any.
repetitive --> any, [X, X], any.
banned --> any, (`ab` | `cd` | `pq` | `xy`), any.
nice1(S) :- phrase(vowelful, S), phrase(repetitive, S), \+ phrase(banned, S).

xyxy --> any, [X, Y], any, [X, Y], any.
xyx --> any, [X, _, X], any.
nice2(S) :- phrase(xyxy, S), phrase(xyx, S).

answer(N1, N2) :-
  phrase_from_file(lines(Ls), 'input-05.txt'),
  include(nice1, Ls, N1s), length(N1s, N1),
  include(nice2, Ls, N2s), length(N2s, N2).