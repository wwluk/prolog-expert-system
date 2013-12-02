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
zasoby_pieniezne(srednie) :-
        zasoby_pieniezne(duze).

zasoby_pieniezne(male) :-
        xzapisane(zasoby_pieniezne, _) -> xzapisane(zasoby_pieniezne, male); zapisz(zasoby_pieniezne), xzapisane(zasoby_pieniezne, male).
zasoby_pieniezne(male) :-
        zasoby_pieniezne(srednie).
zasoby_pieniezne(male) :-
        zasoby_pieniezne(duze).

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
        pozytywne(czy, mobilnosc),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(ma, wifi),
        negatywne(ma, zyroskop),
        negatywne(czy, zlozone_gry),
        negatywne(komfort_gry, komfort_gry_wysoki).

konsola_jest(tablet_drogi) :-
        zasoby_pieniezne(duze),
        telewizor(nie),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(ma, lacznosc_komorkowa),
        pozytywne(ma, wifi),
        pozytywne(ma, zyroskop),
        pozytywne(ma, wysoka_jakosc),
        negatywne(czy, zlozone_gry),
        negatywne(komfort_gry, komfort_gry_wysoki).

konsola_jest(xbox) :-
        preferowana_marka(microsoft),
        zasoby_pieniezne(male),
        negatywne(komfort_gry, komfort_gry_wysoki),
        negatywne(ma, lacznosc),
        negatywne(ma, kontroler_ruchu),
        negatywne(czy, mobilnosc),
        telewizor(tak).

konsola_jest(xbox360) :-
        zasoby_pieniezne(srednie),
        base(xbox360),
        negatywne(ma, kontroler_ruchu).

konsola_jest(xbox360_kinect) :-
        zasoby_pieniezne(duze),
        base(xbox360),
        pozytywne(ma, kontroler_ruchu).        

konsola_jest(ps3) :-
        base(ps3),
        negatywne(ma, kontroler_ruchu).

konsola_jest(ps3_move) :-
        base(ps3),
        pozytywne(ma, kontroler_ruchu).

konsola_jest(psp) :-
        preferowana_marka(sony),
        zasoby_pieniezne(srednie),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, wifi),
        negatywne(ma, kontroler_ruchu),
        negatywne(komfort_gry, komfort_gry_wysoki),
        telewizor(nie).

konsola_jest(pspvita) :-
        preferowana_marka(sony),
        zasoby_pieniezne(duze),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, duzy_ekran),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        pozytywne(ma, wifi),
        pozytywne(ma, lacznosc_komorkowa),
        negatywne(ma, kontroler_ruchu),
        telewizor(nie).

konsola_jest(wii) :-
        preferowana_marka(nintendo),
        zasoby_pieniezne(srednie),
        pozytywne(ma, kontroler_ruchu),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        negatywne(ma, gamepad),
        negatywne(czy, mobilnosc),
        telewizor(tak).

konsola_jest(wiiu) :-
        preferowana_marka(nintendo),
        zasoby_pieniezne(srednie),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, kontroler_ruchu),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        negatywne(ma, gamepad).

konsola_jest(dsi) :-
        preferowana_marka(nintendo),
        zasoby_pieniezne(srednie),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        pozytywne(ma, wifi),
        negatywne(ma, kontroler_ruchu),
        telewizor(nie).

konsola_jest(dsixl) :-
        preferowana_marka(nintendo),
        zasoby_pieniezne(srednie),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, duzy_ekran),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        pozytywne(ma, wifi),
        negatywne(ma, kontroler_ruchu),
        telewizor(nie).

konsola_jest(dsixl) :-
        preferowana_marka(nintendo),
        zasoby_pieniezne(srednie),
        pozytywne(czy, mobilnosc),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(czy, gry_3d),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        pozytywne(ma, wifi),
        negatywne(ma, kontroler_ruchu),
        telewizor(nie).

konsola_jest(komputer_tani) :-
        zasoby_pieniezne(male),
        pozytywne(pozwala, ulepszyc_pozniej),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        negatywne(ma, kontroler_ruchu),
        negatywne(czy, mobilnosc),
        telewizor(tak).

konsola_jest(komputer_sredni) :-
        zasoby_pieniezne(srednie),
        pozytywne(pozwala, ulepszyc_pozniej),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        negatywne(ma, kontroler_ruchu),
        telewizor(tak).

konsola_jest(komputer_sredni) :-
        zasoby_pieniezne(srednie),
        pozytywne(pozwala, ulepszyc_pozniej),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(ma, lacznosc_komorkowa),
        pozytywne(ma, ekran_dotykowy),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        negatywne(ma, kontroler_ruchu),
        telewizor(tak).

base(xbox360) :- 
        preferowana_marka(microsoft),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(komfort_gry, komfort_gry_wysoki),
        negatywne(czy, mobilnosc),
        telewizor(tak).

base(ps3) :-
        preferowana_marka(sony),
        zasoby_pieniezne(duze),
        pozytywne(ma, ethernet),
        pozytywne(ma, wifi),
        pozytywne(ma, blueray),
        pozytywne(komfort_gry, komfort_gry_wysoki),
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
        !, write('potrzebujesz '), write(Y), write(' ? (t/n)\n'),
        readln([Replay]),
        pamietaj(X, Y, Replay),
        odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
        !, write('potrzebujesz '), write(Y), write(' ? (t/n)\n'),
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