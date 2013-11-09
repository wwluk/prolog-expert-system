:- module(se2,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2]).

zasoby_pieniezne()


konsola_jest(tablet_tani) :-
	pozytywne(nie_potrzebuje, telewizor)

pozytywne(X, Y) :-
	xpozytywne(X, Y), !.

pozytywne(X, Y) :-
	not(xnegatywne(X, Y)),
	pytaj(X, Y, tak).

negatywne(X, Y) :-
	xnegatywne(X, Y), !.

negatywne(X, Y) :-
	not(xpozytywne(X, Y)),
	pytaj(X, Y, nie).

pytaj(X, Y, tak) :-
	!, write(X), write(' to_konsola '), write(Y), write(' ? (t/n)\n'),
	readln([Replay]),
	pamietaj(X, Y, Replay), 
	odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
	!, write(X), write(' to_konsola '), write(Y), write(' ? (t/n)\n'),
	readln([Replay]),
	pamietaj(X, Y, Replay),
	odpowiedz(Replay, nie).    

odpowiedz(Replay, tak):-
	sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie):-
	sub_string(Replay, 0, _, _, 'n').

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xpozytywne(X, Y)).

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xnegatywne(X, Y)).

wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xpozytywne(_, _)),
	retractall(xnegatywne(_, _)),
	readln(_).

wykonaj :-
	zwierze_jest(X), !,
	write('Twoja konsola moze byc '), write(X), nl,
	wyczysc_fakty.

wykonaj :-
	write('\nNie jestem w stanie odgadnac, '),
	write('jakia konsole masz na mysli.\n\n'), wyczysc_fakty.