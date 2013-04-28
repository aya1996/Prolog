queens(N,Queen_places) :- range(1,N,N_list),
			my_permutation(N_list,Queen_places),safe(Queen_places),
			print_board(Queen_places,N).


print_board([Q|Qp],N):- D is N*2,print_dashes(D),nl,B is N+1, print_bars(Q,B,1),nl,print_board(Qp,N).
print_board([],N):- D is N*2,print_dashes(D).

print_bars(Q,1,I):-display('|'),!, display(' '), !.
print_bars(Q,B,I):-display('|'),!,print_queen(Q,I),I2 is I+1,B2 is B-1,print_bars(Q,B2,I2).

print_dashes(1):- display('--'),!.
print_dashes(D):- display('-'),!,D1 is D-1, print_dashes(D1).



print_queen(I,I):-display('Q'),!.
print_queen(Q,I):-display(' '),!.


my_permutation(Xs,[Z|Zs]) :- select(Z,Xs,Ys), my_permutation(Ys,Zs).
my_permutation([],[]).


select(X,[X|Xs],Xs).
select(X,[Y|Ys],[Y|Zs]) :- select(X,Ys,Zs).
range(M,N,[M|Ns]) :- M < N, M1 is M + 1, range(M1,N,Ns).
range(N,N,[N]).

safe([Q|Rest]):- \+ attacks(Q,1,Rest),safe(Rest).
safe([]).
attacks(Check,Row,[Q|Rest]):- Check+Row=:=Q.
attacks(Check,Row,[Q|Rest]):- Check-Row=:=Q.
attacks(Check,Row,[Q|Rest]):- R1 is Row +1, attack(Check,R1,Rest).