

    1. Wykorzystując polecenie
    show tables from baza_danych
	show tables from firma
	
    zobacz, ile i jakie tabele zawiera baza FIRMA.
    2. Korzystając z polecenia
    DESCRIBE baza_danych.nazwa_tabeli;
    wyświetl nazwy i typy atrybutów tabel właściciela FIRMA.
	
	DESCRIBE firma.pracownicy
	
    3. Wśród udostępnionych baz danych odszukaj w panelu nawigacji tabelę PRACOWNICY użytkownika FIRMA. Zapoznaj się ze strukturą i zawartością tej tabeli.
    4. Posortuj dane w tabeli następująco:
        rosnąco według nazwiska,
		SELECT * from pracownicy ORDER BY pracownicy.nazwisko ASC 
		
        malejąco według imienia,
		SELECT * from pracownicy ORDER BY pracownicy.IMIE DESC 
		
        najpierw kobiety, potem mężczyźni,
		SELECT * FROM `pracownicy` order BY pracownicy.PLEC ASC 
		
        według daty urodzenia od osób najstarszych do najmłodszych,
		SELECT * FROM `pracownicy` order BY pracownicy.DATA_URODZENIA ASC 
		
        rosnąco według wykształcenia, a w obrębie tego samego wykształcenia rosnąco według nazwiska,
		
        rosnąco według płci, a w obrębie tej samej płci od osób najmłodszych do najstarszych.
		
    5. Utwórz w języku SQL zapytania, przy pomocy których zostaną wyświetlone następujące informacje:
        imiona i nazwiska pracowników firmy,
		SELECT imie,nazwisko FROM firma.pracownicy 
		
        imiona i nazwiska pracowników firmy posortowane według nazwiska,
		SELECT imie,nazwisko FROM firma.pracownicy ORDER BY nazwisko ASC 
		
        imiona, nazwiska i daty zatrudnienia pracowników posortowane malejąco według daty zatrudnienia,
		SELECT imie,nazwisko,DATA_ZATRUDNIENIA FROM firma.pracownicy ORDER BY DATA_ZATRUDNIENIA DESC 
		
        imiona, nazwiska i wydziały pracowników posortowane względem kodu wydziału, a w obrębie jednego wydziału, względem nazwiska,
		SELECT imie,nazwisko,KOD_WYDZIALU FROM firma.pracownicy ORDER BY KOD_WYDZIALU, NAZWISKO
		
        imiona, nazwiska, kody wykształcenia i wydziału pracowników o wykształceniu wyższym (wykształcenie wyższe ma kod 'w'),
		SELECT imie,nazwisko,KOD_WYKSZTALCENIA, KOD_WYDZIALU FROM firma.pracownicy WHERE kod_wyksztalcenia='w' 
		
        imiona i nazwiska, kody wykształcenia i wydziału pracowników administracji (wydział 'w1') o wykształceniu średnim lub zawodowym,
		SELECT imie,nazwisko,KOD_WYKSZTALCENIA, KOD_WYDZIALU FROM firma.pracownicy WHERE kod_wydzialu='w1' AND (KOD_WYKSZTALCENIA= 's' OR KOD_WYKSZTALCENIA='z')

        imiona i nazwiska oraz kody wydziałów mężczyzn z wydziałów w1, w3 i w5 wraz z ich płacą dodatkową,
		SELECT imie,nazwisko, KOD_WYDZIALU, PLACA_DODATKOWA FROM firma.pracownicy WHERE plec='m' AND (KOD_WYDZIALU='w1' OR KOD_WYDZIALU='w3' or KOD_WYDZIALU='w5')
		
        imiona i nazwiska oraz płace podstawowe i dodatkowe osób, które otrzymują płace dodatkowe,
		SELECT imie,nazwisko,PLACA_PODSTAWOWA, PLACA_DODATKOWA FROM firma.pracownicy WHERE PLACA_DODATKOWA is not null
		
        dane pracowników, którzy zarabiają pomiędzy 3000 zł a 4000 zł,
		SELECT * FROM firma.pracownicy WHERE PLACA_PODSTAWOWA + ifnull(placa_dodatkowa,0) BETWEEN 3000 AND 4000 
		
        imiona i nazwiska pracowników oraz wartość wypłacanych im w ciągu roku płac podstawowych i dodatkowych (w oddzielnych kolumnach) - kolumnom nadaj odpowiednio nazwy "Roczna podstawowa", "Roczna dodatkowa",
		select imie, NAZWISKO, 12*PLACA_PODSTAWOWA as "Roczna podstawowa", 12*PLACA_DODATKOWA as "Roczna dodoatkowwa" from firma.pracownicy 
		
        imiona, nazwiska i całkowitą płacę roczną pracownika (uwzględniając płacę dodatkową) - dane posortuj względem płacy rocznej,
		select imie, NAZWISKO,
		12*( PLACA_PODSTAWOWA + ifnull(PLACA_DODATKOWA,0) )
		from firma.pracownicy
		order by 3             //sortuje wg 3 kolumny
		
		select imie, NAZWISKO, 12*( PLACA_PODSTAWOWA + ifnull(PLACA_DODATKOWA,0) ) as "Roczna płaca" from firma.pracownicy order by `roczna płaca`         //inny sposób, nazwa kolumny w odwróconym apostrofie
		
		
        imiona i nazwiska tych pracowników, którzy dostają płacę dodatkową oraz informację, jaki procent płacy podstawowej ona stanowi,
		SELECT imie, nazwisko,PLACA_PODSTAWOWA, PLACA_DODATKOWA,
		PLACA_DODATKOWA/placa_podstawowa * 100 as "Jaki to % pensji" 
		FROM firma.pracownicy 
		WHERE PLACA_DODATKOWA is not null
	
        dane pracowników, których nazwiska nie zaczynają się na literę S, posortowane malejąco względem nazwiska,
		SELECT * FROM firma.pracownicy WHERE NAZWISKO not like 's%' order by NAZWISKO DESC 
		
        dane pracowników, których nazwiska są czteroliterowe,
		SELECT * FROM firma.pracownicy WHERE NAZWISKO like '____' order by NAZWISKO
		
        dane pracowników, których nazwiska kończą się na 'ski' lub 'ska',
		SELECT * FROM firma.pracownicy WHERE NAZWISKO like '%ski' OR nazwisko like '%ska' order by NAZWISKO
		
        pełną informację o wydziałach firmy,
		SELECT * FROM firma.wydzialy 
        kody stanowisk, płace minimalne i maksymalne na tych stanowiskach oraz w czwartej kolumnie o nazwie Różnica różnicę między maksymalną a minimalną płacą na każdym stanowisku,
       

Wypisz tabele należące do bazy czek oraz obok każdej tabeli podaj liczbę wierszy w tej tabeli.
show tables from czek

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
