:- use_module(library(md5)).

zeroes_string(N, String) :-
  findall(0, between(1, N, _), Zs),
  atomics_to_string(Zs, String).

answer(ZeroCount, N) :-
  zeroes_string(ZeroCount, Z),
  between(0, inf, N),
  number_string(N, Ns),
  string_concat("yzbqklnj", Ns, Text),
  md5_hash(Text, Hash, []),
  sub_string(Hash, 0, _, _, Z), !.

answers(N1, N2) :- answer(5, N1), answer(6, N2).
