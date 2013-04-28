:- dynamic(line_number/1).

 concord :- print('Enter the file name '),
		read(Filename),
		see(Filename),
		reset_all,
		repeat,
		read_in(Text),
		process(Text),
		peek_code(-1),
		seen,
		my_word_list(The_words),
		print_the_words(The_words).

reset_all :- set_line_number,
		remove_appears,
		remove_my_word_list,
		asserta(my_word_list([])).

 set_line_number :- line_number(X), retract(line_number(X)), set_line_number.
 set_line_number :- asserta(line_number(0)).

remove_appears :- retract(appears(_,_,_)), remove_appears.
remove_appears.

remove_my_word_list :- retract(my_word_list(_)), remove_my_word_list.
remove_my_word_list.

/* (2 */

process([]) :- !.
process([Word|Text]) :-line_number(Y),check_list(Word),check_exsits(Word,Y),process(Text).

check_list(X):- \+appears(X,S,K),insert_myword(X),!.
check_list(X) :- !.

check_exsits(X,Y):- \+appears(X,Y,Z),insert_process(X,Y,1),!.
check_exsits(X,Y):- appears(X,Y,Z),retract(appears(X,Y,S)),S1 is S+1,insert_process(X,Y,S1),!.

insert_process(X,Y,Z):- assertz(appears(X,Y,Z)),!.

/* (3 Its going to inserting in a list */

insert_myword(Word):- my_word_list(List),insert_word(Word,List,[],NewList2),my_reverse(NewList2,NewList3),retract(my_word_list(S)),asserta(my_word_list(NewList3)).

my_reverse([], []).
my_reverse([N | Xs], Ys) :-
my_reverse(Xs, Zs), append(Zs, [N], Ys).

insert_word(Word,[],NewList,NewList2):- add_to_list(Word,NewList,NewList2),!.

insert_word(Word,[ThisWord],NewList,NewList2):- \+aless(Word,ThisWord),add_to_list(ThisWord,NewList,NewList3),add_to_list(Word,NewList3,NewList2),!.
insert_word(Word,[ThisWord],NewList,NewList2):- aless(Word,ThisWord),add_to_list(Word,NewList,NewList3),add_to_list(ThisWord,NewList3,NewList2),!.

insert_word(Word,[ThisWord|List],NewList,NewList2):- \+aless(Word,ThisWord),add_to_list(ThisWord,NewList,NewList3),insert_word(Word,List,NewList3,NewList2),!.
insert_word(Word,[ThisWord|List],NewList,NewList2):- aless(Word,ThisWord),add_to_list(Word, NewList, NewList3),add_to_list(ThisWord, NewList3, NewList4),insert_word2(List,NewList4,NewList2),!.

insert_word2([ThisWord],NewList,NewList2):- add_to_list(ThisWord,NewList,NewList2),!.
insert_word2([ThisWord|List],NewList,NewList2):- add_to_list(ThisWord,NewList,NewList3),insert_word2(List,NewList3,NewList2),!.

add_to_list(X, Ls, [X|Ls]).


/* (4 Print the Result Here*/


print_the_words([]):- !.
print_the_words([TEST|The_words]):- display(TEST),print_the_line(TEST),display('\n'),print_the_words(The_words).

print_the_line(TEST):- appears(TEST,Y,Z),retract(appears(TEST,Y,Z)),display(' '),display(Y),print_the_count(Z),print_the_line2(TEST).
print_the_line(TEST):- \+appears(TEST,Y,Z),!.

print_the_line2(TEST):- appears(TEST,Y,Z),retract(appears(TEST,Y,Z)),display(','),display(Y),print_the_count(Z),print_the_line2(TEST).
print_the_line2(TEST):- \+appears(TEST,Y,Z),!.

print_the_count(1):- !.
print_the_count(Z):- display('('),display(Z),display(')').
ordered_insert(awl, oldList,newList).
/* code included from clocksin and mellish page 58 */
 aless(X,Y) :- name(X,L), name(Y,M), alessx(L,M).
 alessx([],[_|_]).
 alessx([X|_],[Y|_]) :- X < Y.
 alessx([P|Q],[R|S]) :- P = R, alessx(Q,S).
/* end include */

/* read in a sentence */
	/* ignore punctuation */
 read_in(X) :- peek_code(C),
		punct_char(C),
		get0(_),
		read_in(X).

	/* at the end of line ? */
 read_in([]) :- peek_code(10),
		get0(_),
		retract(line_number(X)), 
		X1 is X + 1, 
		asserta(line_number(X1)), 
		!.

	/* not punctuation or end of line */
 read_in([W|Ws]) :- read_token(W),
		read_in(Ws), !.

/* punctuation characters */
punct_char(33).	/* ! */
punct_char(34).	/* " */
punct_char(40).	/* ( */
punct_char(41).	/* ) */
punct_char(44).	/* , */
punct_char(46).	/* . */
punct_char(58).	/* : */
punct_char(59).	/* ; */
punct_char(63).	/* ? */


