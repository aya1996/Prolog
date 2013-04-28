talk :- write('Enter the file name: '),
	read(Filename),
	see(Filename),
	repeat,
	read_in(Sentence),
	write_out(Sentence),
	process(Sentence,Clause),
	Clause = stop,
	seen.
	
write_out([Mylist]):-display(Mylist),display('\n'),!.
write_out([Mylist|Mylists]):-display(' '),display(Mylist),write_out(Mylists).


process([X, is, a, Y, Punct], go) :-  Term =.. [Y, X],asserta(Term),display('ok \n').

process([a, X, is, a, Y, Punct], go) :-Term =.. [Y,A],
                                      Term2 =.. [X, A],
                                       Term3 =.. [':-',Term, Term2],
                                       asserta(Term3),display('ok \n').
                                       
process([is, X, a, Y, Punct], go) :-Term =.. [Y, X],call(Term),display('yes\n').

process([is, X, a, Y, Punct], go) :-Term =.. [Y, X],\+ call(Term),display('unknown\n').
process([stop, Punct], stop).



/* read in a sentence */
read_in([W|Ws]) :- get0(C),
			readword(C,W,C1),
			restsent(W,C1,Ws).

/*
	given a word and the character after it, read
	in the rest of the sentence.
*/

restsent(W,_,[]) :- lastword(W), !.
restsent(W,C,[W1|Ws]) :- readword(C,W1,C1), restsent(W1,C1,Ws).

/*
	read in a single word, given an initial character,
	and remembering what character came after the word.
*/
readword(C,W,C1) :- single_character(C), !, name(W,[C]), get0(C1).
readword(C,W,C2) :- in_word(C,NewC), !, get0(C1), restword(C1,Cs,C2),
			name(W,[NewC|Cs]).
readword(C,W,C2) :- get0(C1), readword(C1,W,C2).

restword(C,[NewC|Cs],C2) :- in_word(C, NewC), !, get0(C1), restword(C1,Cs,C2).
restword(C,[],C).

/* these characters form words on their own */
single_character(44).	/* , */
single_character(59).	/* ; */
single_character(58).	/* : */
single_character(63).	/* ? */
single_character(33).	/* ! */
single_character(46).	/* . */

/*
	these characters can appear within a word.  the second
	in_word clause converts characters to lower-case.
*/
in_word(C,C) :- C>96, C<123.		/* a through z */
in_word(C,L) :- C>64, C<91, L is C+32.	/* A through Z */
in_word(C,C) :- C>47, C<58.		/* 1 through 9 */
in_word(39,39).				/* ' */
in_word(45,45).				/* - */

/* these words terminate a sentence */
lastword('.').
lastword('!').
lastword('?').


