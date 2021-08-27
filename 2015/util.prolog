:- use_module(library(dcg/basics)).

lines([]) --> eos, !.
lines([Line|Lines]) --> line(Line), !, lines(Lines).

line([]) --> ( "\r" | "\r\n" | "\n" | eos ), !.
line([Char|Chars]) --> [Char], !, line(Chars).

phrase_lines_from_file(Body, Filename, Items) :-
  phrase_from_file(lines(Ls), Filename),
  bagof(I, L^(member(L,Ls), phrase(call(Body, I), L)), Items).