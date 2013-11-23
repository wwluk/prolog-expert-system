:- module(se2,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2, xzapisane/2]).

zapisz(zasoby_pieniezne) :-
        !, write('jaki jest twoj budzet?'),
        readln([Replay]),
        zapisz_kwote(Replay).

zapisz(preferowana_marka) :-
        !, write('Jaka marke lubisz (sony, microsoft, nintendo)?'),
        readln([Replay]),
        zapisz_marke(Replay).

zapisz_kwote(X) :-
        X < 400, assertz(xzapisane(zasoby_pieniezne, male)).

zapisz_kwote(X) :-
        X > 399, X < 1000, assertz(xzapisane(zasoby_pieniezne, srednie)).

zapisz_kwote(X) :-
        X > 999, assertz(xzapisane(zasoby_pieniezne, duze)).

zasoby_pieniezne(duze) :-
        xzapisane(zasoby_pieniezne, _) -> xzapisane(zasoby_pieniezne, duze); zapisz(zasoby_pieniezne), xzapisane(zasoby_pieniezne, duze).

zasoby_pieniezne(srednie) :-
        xzapisane(zasoby_pieniezne, _) -> xzapisane(zasoby_pieniezne, srednie); zapisz(zasoby_pieniezne), xzapisane(zasoby_pieniezne, srednie).

zasoby_pieniezne(male) :-
        xzapisane(zasoby_pieniezne, _) -> xzapisane(zasoby_pieniezne, male); zapisz(zasoby_pieniezne), xzapisane(zasoby_pieniezne, male).

zapisz_marke(X) :-
        assertz(xzapisane(preferowana_marka, X)).

preferowana_marka(microsoft) :-
        xzapisane(preferowana_marka, _) -> xzapisane(preferowana_marka, microsoft); zapisz(preferowana_marka), xzapisane(preferowana_marka, microsoft).

preferowana_marka(sony) :-
        xzapisane(preferowana_marka, _) -> xzapisane(preferowana_marka, sony); zapisz(preferowana_marka), xzapisane(preferowana_marka, sony).

preferowana_marka(nintendo) :-
        xzapisane(preferowana_marka, _) -> xzapisane(preferowana_marka, nintendo); zapisz(preferowana_marka), xzapisane(preferowana_marka, nintendo).

telewizor(tak) :-
        upozytywne(masz, telewizor);
        upozytywne(mozesz_kupic, telewizor).

telewizor(nie) :- 
        true.
        
konsola_jest(tablet_tani) :-
        zasoby_pieniezne(male),
        telewizor(nie),
        pozytywne(ma, moblinosc),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(nie_posiada, okablowania),
        pozytywne(ma, wifi),
        negatywne(czy, zyroskop),
        negatywne(czy, zlozone_gry),
        negatywne(czy, komfort_gry).

konsola_jest(tablet_drogi) :-
        zasoby_pieniezne(duze),
        telewizor(nie),
        pozytywne(ma, moblinosc),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(nie_posiada, okablowania),
        pozytywne(ma, lacznosc_komorkowa),
        pozytywne(ma, wifi),
        pozytywne(ma, zyroskop),
        pozytywne(ma, wysoka_jakosc),
        negatywne(czy, zlozone_gry),
        negatywne(czy, komfort_gry).

konsola_jest(xbox) :-
        preferowana_marka(microsoft),
        zasoby_pieniezne(male),
        negatywne(czy, komfort_gry),
        negatywne(czy, okablowanie),
        negatywne(ma, lacznosc),
        negatywne(ma, kontroler_ruchu),
        negatywne(czy, mobilnosc),
        telewizor(tak).

konsola_jest(xbox360) :-
        preferowana_marka(microsoft),
        zasoby_pieniezne(srednie),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(komfort_gry, wysoki),
        negatywne(czy, okablowanie),
        negatywne(ma, kontroler_ruchu),
        negatywne(czy, mobilnosc),
        telewizor(tak).

konsola_jest(kinect) :-
        preferowana_marka(microsoft),
        zasoby_pieniezne(male),
        pozytywne(ma, xbox360),
        pozytywne(ma, kontroler_ruchu),
        pozytywne(komfort_gry, wysoki),
        negatywne(czy, okablowanie).
        

konsola_jest(ps3) :-
        preferowana_marka(sony),
        zasoby_pieniezne(duze),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(ma, blueray),
        pozytywne(komfort_gry, wysoki),
        negatywne(czy, okablowanie),
        negatywne(ma, kontroler_ruchu),
        negatywne(czy, mobilnosc),
        telewizor(tak).

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
        !, write(X), write(' ta_konsola '), write(Y), write(' ? (t/n)\n'),
        readln([Replay]),
        pamietaj(X, Y, Replay),
        odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
        !, write(X), write(' ta_konsola '), write(Y), write(' ? (t/n)\n'),
        readln([Replay]),
        pamietaj(X, Y, Replay),
        odpowiedz(Replay, nie).

upozytywne(X, Y) :-
        xpozytywne(X, Y), !.

upozytywne(X, Y) :-
        not(xnegatywne(X, Y)),
        upytaj(X, Y, tak).

unegatywne(X, Y) :-
        xnegatywne(X, Y), !.

unegatywne(X, Y) :-
        not(xpozytywne(X, Y)),
        upytaj(X, Y, nie).

upytaj(X, Y, tak) :-
        !, write('czy '), write(X), write(' '), write(Y), write(' ? (t/n)\n'),
        readln([Replay]),
        pamietaj(X, Y, Replay),
        odpowiedz(Replay, tak).


upytaj(X, Y, nie) :-
        !, write('czy '), write(X), write(' '), write(Y), write(' ? (t/n)\n'),
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
        write('\nNie jestem w stanie doradzic, '),
        write('jaka konsola bedzie dla ciebie odpowiednia.\n\n'), wyczysc_fakty.