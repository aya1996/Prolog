:- dynamic(fib/2).

fib(X,Y) :- X1 is X - 1, X2 is X - 2, fib(X1,Y1), fib(X2,Y2), Y is Y1 + Y2,
	asserta(fib(X,Y)).
readit:-open('fibData', read, Str),readit2(Str).
readit2(Str):-  at_end_of_stream(Str),close(Str).
readit2(Str):- \+  at_end_of_stream(Str), read(Str,X), read(Str,Y),asserta(fib(X,Y)),readit2(Str).




writethis:-open('fibData', write, Str),writethis1(Str),close(Str).
writethis1(Str):-retract(fib(X,Y)),!,write(Str, X),write(Str, .),write(Str, '\n'), write(Str, Y),write(Str, .),write(Str, '\n'), writethis1(Str).
writethis1(Str).