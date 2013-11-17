:- module(se2,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2, xzapisane/2]).

zapisz(zasoby_pieniezne) :-
	!, write('jaki jest twoj budzet?'),
	readln([Replay]),
	zapisz_kwote(Replay).

zapisz(preferowana_marka) :-
	!, write('Jaka marke lubisz (Sony, MS, Nintendo)?'),
	readln([Replay]),
	zapisz_marke(Replay).

zapisz_marke(X) :-
	assertz(xzapisane(marka, X)).

zapisz_kwote(X) :-
	X < 400, assertz(xzapisane(zasoby_pieniezne, male)).

zapisz_kwote(X) :-
	X > 399, X < 1000, assertz(xzapisane(zasoby_pieniezne, srednie)).

zapisz_kwote(X) :-
	X > 999, assertz(xzapisane(zasoby_pieniezne, duze)).

zasoby_pieniezne(duze) :-
	(xzapisane(zasoby_pieniezne, _); zapisz(zasoby_pieniezne)), xzapisane(zasoby_pieniezne, duze).

zasoby_pieniezne(srednie) :-
	(xzapisane(zasoby_pieniezne, _); zapisz(zasoby_pieniezne)), xzapisane(zasoby_pieniezne, srednie).

zasoby_pieniezne(male) :-
	(xzapisane(zasoby_pieniezne, _); zapisz(zasoby_pieniezne)), xzapisane(zasoby_pieniezne, male).
	
konsola_jest(tablet_tani) :-
	pozytywne(nie_potrzebuje, telewizor),
	pozytywne(ma, moblinosc),
	pozytywne(ma, ekran_dotykowy),
	pozytywne(nie_posiada, okablowania),
	pozytywne(zasoby_pieniezne, male),
	negatywne(czy, WiFi),
	negatywne(czy, zyroskop),
	negatywne(czy, zlozone_gry),
	negatywne(czy, komfort_gry).

konsola_jest(tablet_drogi) :-
	pozytywne(nie_potrzebuje, telewizor),
	pozytywne(ma, moblinosc),
	pozytywne(ma, ekran_dotykowy),
	pozytywne(nie_posiada, okablowania),
	pozytywne(ma, 3G),
	pozytywne(ma, WiFi),
	pozytywne(ma, zyroskop),
	pozytywne(ma, wysoka_jakosc),
	negatywne(zasoby_pieniezne, duze),
	negatywne(czy, zlozone_gry),
	negatywne(czy, komfort_gry).

konsola_jest(xbox) :-
	pozytywne(zasoby_pieniezne, male),
	pozytywne(preferowana_marka, MS),
	negatywne(czy, komfort_gry),
	negatywne(czy, okablowanie),
	negatywne(ma, lacznosc),
	negatywne(ma, kontroler_ruchu),
	negatywne(czy, mobilnosc),
	negatywne(czy, telewizor).

konsola_jest(xbox360) :-
	pozytywne(zasoby_pieniezne, srednie),
	pozytywne(preferowana_marka, MS),
	pozytywne(ma, ethernet),
	pozytywne(ma, WiFi),
	pozytywne(komfort_gry, wysoki),
	negatywne(czy, okablowanie),
	negatywne(ma, kontroler_ruchu),
	negatywne(czy, mobilnosc),
	negatywne(czy, telewizor).

konsola_jest(kinect) :-
	pozytywne(ma, xbox360),
	pozytywne(ma, kontroler_ruchu),
	pozytywne(preferowana_marka, MS),
	pozytywne(komfort_gry, wysoki),
	negatywne(czy, okablowanie),
	negatywne(zasoby_pieniezne, duze).

konsola_jest(PS3) :-
	pozytywne(zasoby_pieniezne, duze),
	pozytywne(preferowana_marka, Sony),
	pozytywne(ma, ethernet),
	pozytywne(ma, WiFi),
	pozytywne(ma, blueray),
	pozytywne(komfort_gry, wysoki),
	negatywne(czy, okablowanie),
	negatywne(ma, kontroler_ruchu),
	negatywne(czy, mobilnosc),
	negatywne(czy, telewizor).

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
	retractall(xzapisane(_,_)),
	readln(_).

wykonaj :-
	konsola_jest(X), !,
	write('Twoja konsola moze byc '), write(X), nl,
	wyczysc_fakty.

wykonaj :-
	write('\nNie jestem w stanie odgadnac, '),
	write('jakia konsole masz na mysli.\n\n'), wyczysc_fakty.