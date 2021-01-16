Wypisz tabele należące do bazy czek oraz obok każdej tabeli podaj liczbę wierszy w tej tabeli.
show table status from czek where rows

Napisz w języku SQL zapytania wyświetlające następujące informacje z bazy danych czek:
imiona i nazwiska klientów z Katowic posortowane malejąco względem nazwiska;
select imie, nazwisko from czek.klienci where klienci.miasto = 'Katowice' order by nazwisko desc

imiona i nazwiska klientów nieposiadających telefonu;
select imie, nazwisko from czek.klienci where telefon is null

nazwy, ceny i liczby sztuk w magazynie pudełek, których cena jest większa niż 30 lub jest ich w magazynie przynajmniej 500 sztuk;
select nazwa, cena_pudelka, sztuk_w_magazynie from czek.pudelka where cena_pudelka>30 or sztuk_w_magazynie >=500;

wszystkie informacje o zamówieniach złożonych przez klientów o numerach 7, 30, 44, 50;
select * from czek.zamowienia where id_klienta = 7 or id_klienta = 30 or id_klienta = 44 or id_klienta = 50;

nazwy czekoladek z nadzieniem marcepanowym, wykonane z czekolady mlecznej lub białej,
select nazwa, rodzaj_czekolady, rodzaj_nadzienia from czek.czekoladki where rodzaj_nadzienia like 'marcep%' and (rodzaj_czekolady like '%mleczn%' or rodzaj_czekolady like '%bial%');

identyfikatory, nazwy i liczby sztuk w magazynie tych pudełek, których liczba sztuk zawiera się w przedziale [200,300],
select id_pudelka, nazwa, sztuk_w_magazynie from czek.pudelka where sztuk_w_magazynie between 200 and 300;

identyfikatory, nazwy i koszt czekoladek oraz nową cenę czekoladek, w przypadku podwyżki o 20% (ostatniej kolumnie nadaj odpowiednią nazwę),
select id_czek, nazwa, koszt, koszt*1.2 as "cena po podwyżce 20%" from czek.czekoladki 

imiona i nazwiska klientów, którzy mieszkają w mieście o kodzie zaczynającym się na 70 lub zaczynającym się i kończącym na 1.
select imie, nazwisko from czek.klienci where kod like '70&' or kod like '1%1';
