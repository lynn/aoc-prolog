:- use_module(library(dcg/basics)).

sizes([]) --> eos, !.
sizes([size(L,W,H)|Ss]) --> integer(L), "x", integer(W), "x", integer(H), blanks, sizes(Ss).

area(size(L,W,H), N) :-
  S1 is L*W,
  S2 is W*H,
  S3 is H*L,
  N is 2*(S1+S2+S3) + min(S1,min(S2,S3)).

ribbon(size(L,W,H), N) :-
  N is L*W*H + 2*(L+W+H-max(L,max(W,H))).

answers(N1, N2) :-
  phrase_from_file(sizes(Ss), 'input-2.txt'),
  maplist(area,   Ss, As), sum_list(As, N1),
  maplist(ribbon, Ss, Rs), sum_list(Rs, N2).

% phrase_from_file(sizes(Ss), 'input-2.txt').
