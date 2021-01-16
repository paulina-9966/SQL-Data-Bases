

    Utwórz w języku SQL zapytania, przy pomocy których zostaną wyświetlone informacje:
        nazwy stanowisk w firmie posortowane rosnąco,
        select nazwa from firma.stanowiska order by nazwa asc
        
        imiona, nazwiska i sumę płac tych pracowników, którzy otrzymują płacę dodatkową a ich płaca podstawowa jest większa niż 3000 zł 
        – kolumnom nadaj nazwy Imię, Nazwisko i Suma płac
        select imie,nazwisko, placa_podstawowa + placa_dodatkowa as " suma plac" from firma.pracownicy where placa_dodatkowa 
        is not null and placa_podstawowa > 3000;
        
        roczna pensję podstawową dla każdego pracownika, jeśli dostanie podwyżkę o 250 zł; kolumnę nazwij "Roczna",
        select imie as "Imię", nazwisko as "Nazwisko", (placa_podstawowa+250) *12 as "Roczna po podwyżce"  from firma.pracownicy
        
        
        imiona pracowników – bez powtórzeń,
        select distinct imie from firma.pracownicy order by imie;
        
        imiona i nazwiska kobiet o wykształceniu wyższym wraz z ich płacą całkowitą, zaokrągloną do 100 zł,
       select imie, nazwisko, round(placa_podstawowa + ifnull (placa_dodatkowa,0), -2) as "Pensja calkowita" 
       from firma.pracownicy where lower(kod_wyksztalcenia) = 'w' and lower (plec) = 'k' 
        
        dane pracowników zatrudnionych po 1 stycznia 2000 roku,
        select * from firma.pracownicy 
        where data_zatrudnienia > str_to_date('01.01.2000', '%d.%c.%Y')
        
        liczba dni, jaką przepracował każdy pracownik wydziału 'w1',
        select datediff(curdate(),data_zatrudnienia) as "Liczba dni"
        from firma.pracownicy 
        where kod_wydzialu = 'w1';
        
        dane osób urodzonych w maju,
        select *
        from firma.pracownicy
        where extract (month from data_urodzenia) = 5;
        
        imiona, nazwiska i daty urodzenia pracowników urodzonych przed rokiem 1960,
        select imie, nazwisko, data_urodzenia 
        from firma.pracownicy
        where extract(year from data_urodzenia)<1960
        
        liczba pracowników zatrudnionych na stanowisku informatyka ('inf'),
        select count(id_prac)
        from firma.pracownicy
        where kod_stanowiska = 'inf';
        
        średnia płaca podstawowa w firmie,
        select avg(placa_podstawowa) as "Średnia placa podst"
        from firma.pracownicy;
        
        
        select avg(placa_podstawowa), avg(placa_dodatkowa), sum(placa_dodatkowa)/count(id_prac)
        from firma.pracownicy
        
        
        minimalne i maksymalne zarobki w wydziale 'w2',
        select min(placa_podstawowa + ifnull(placa_dodatkowa,0)) as "Min" , max(placa_podstawowa + ifnull(placa_dodatkowa,0)) as "Max"
        from firma.pracownicy where kod_wydzialu = 'w2' 
        
    

