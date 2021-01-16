
    Utwórz w języku SQL zapytania do bazy FIRMA, przy pomocy których zostaną wyświetlone informacje:
        różnica pomiędzy najwyższą a najniższą płacą podstawową,
        select kod_stanowiska, max(placa_podstawowa) - min(placa_podstawowa)
        from firma.pracownicy 
        group by kod_stanowiska;
		
        różnica pomiędzy najwyższą a najniższą płacą podstawową na każdym stanowisku,
        
        suma wypłat miesięcznych dla kobiet,
        
        średnia płaca podstawowa dla kobiet i mężczyzn w każdym wydziale,
        select kod_wydzialu, plec, avg(placa_podstawowa)
		from firma.pracownicy
		group by kod_wydzialu , plec
		
        liczba pracowników urodzonych w każdym z miesięcy, posortowane rosnąco względem miesiąca,
        select extract(month from data_urodzenia) as "miesiac", count(id_prac)
		from firma.pracownicy 
		group by extract(month from data_urodzenia)
		order by miesiac asc
		
        wiek pracowników (w latach),
        
        średnia płaca podstawowa dla osób z tym samym wykształceniem,
        
        kody stanowisk, na których średnia płaca podstawowa wynosi 3000 zł lub więcej,
        select kod_stanowiska, avg(placa_podstawowa)
		from firma.pracownicy
		group by kod_stanowiska
		having avg(placa_podstawowa)>= 3000;
		
        kody wydziałów oraz średnie zarobki w tych wydziałach, które zatrudniają przynajmniej 5 pracowników,
		select kod_wydzialu, avg(placa_podstawowa + ifnull(placa_dodatkowa,0)) as "placa", count(id_prac) as "ilosc pracownikow"
		from firma.pracownicy
		group by kod_wydzialu
		having count(id_prac) >=5;
		
        liczba osób z wydziału 'w1' posiadających wykształcenie wyższe ('w'),
		
		select count(id_prac), kod_wydzialu
		from firma.pracownicy
		where kod_wyksztalcenia = 'w'and kod_wydzialu='w1'
		
        dla każdego wydziału podaj liczbę osób z wykształceniem średnim ('s'),
		
		select count(id_prac), kod_wydzialu, kod_wyksztalcenia
		from firma.pracownicy
		where kod_wyksztalcenia='s'
		group by kod_wydzialu;
		
    Utwórz w języku SQL zapytania do bazy FIRMA, przy pomocy których zostaną wyświetlone informacje:
        imię i nazwisko pracownika oraz nazwę wydziału,
		
		select imie, nazwisko, nazwa
		from firma.pracownicy p JOIN firma.wydzialy w
		on p.kod_wydzialu = w.kod_wydzialu
		
		select p.imie, p.nazwisko, w.nazwa
		from firma.pracownicy p JOIN firma.wydzialy w
		on p.kod_wydzialu = w.kod_wydzialu
		
        imię i nazwisko pracownika oraz rodzaj wykształcenia, posortowane względem nazwiska,
		
		select p.imie, p.nazwisko, w.nazwa
		from firma.pracownicy p JOIN firma.wyksztalcenie w 
		on p.kod_wyksztalcenia = w.kod_wyksztalcenia
		order by p.nazwisko asc
		
        imiona i nazwiska pracowników, których płaca podstawowa wykracza poza zakres przewidziany dla danego stanowiska. Wyświetl także płacę podstawową pracownika oraz płacę minimalną i maksymalną dla stanowiska.
		
		select p.imie, p.nazwisko, p.placa_podstawowa as "placa", s.placa_min, s.placa_max, s.nazwa
		from firma.pracownicy p Join firma.stanowiska s
		on s.kod_stanowiska = p.kod_stanowiska
		where p.placa_podstawowa < s.placa_min or p.placa_podstawowa > s.placa_max
		
		
        imię i nazwisko pracownika, pleć, rodzaj wykształcenia, nazwę wydziału oraz nazwę stanowiska,
		
		select p.imie, p.nazwisko, p.plec, wyk.nazwa, wyd.nazwa, s.nazwa
		from firma.pracownicy p Join firma.wyksztalcenie wyk on wyk.kod_wyksztalcenia = p.kod_wyksztalcenia
		Join firma.wydzialy wyd on p.kod_wydzialu = wyd.kod_wydzialu
		Join firma.stanowiska s on s.kod_stanowiska = p.kod_stanowiska
		
        dla każdej nazwy wydziału podaj imię i nazwisko kierownika wydziału,
		
		select p.imie, p.nazwisko, w.nazwa, w.kod_wydzialu, p.kod_wydzialu
		from firma.pracownicy p Join firma.wydzialy w on p.id_prac = w.id_kierownika
		group by w.nazwa
		
        podaj nazwy stanowisk i liczby pracowników na tych stanowiskach, gdzie pracuje przynajmniej 4 pracowników,
		
		select s.nazwa, count(id_prac)
		from firma.pracownicy p Join firma.stanowiska s 
		on p.kod_stanowiska = s.kod_stanowiska
		group by nazwa
		having count(id_prac) >=4;
		
        podaj nazwę wydziału oraz liczbę pracowników,
		
		select w.nazwa, count(p.id_prac)
		from firma.pracownicy p Join firma.wydzialy w on p.kod_wydzialu = w.kod_wydzialu
		group by w.nazwa
		
        podaj nazwy wszystkich wydziałów oraz liczbę zatrudnionych w nich pracowników (wypisz także wydziały, które nie zatrudniają pracowników),
		
		select w.nazwa, count(p.id_prac)
		from firma.pracownicy p left outer Join  firma.wydzialy w on p.kod_wydzialu = w.kod_wydzialu
		group by nazwa;
		
		
    Utwórz w języku SQL zapytania do bazy FIRMA, przy pomocy których zostaną wyświetlone informacje:
        imiona i nazwiska pracowników, którzy otrzymują najwyższą płacę podstawową,
		//mechanizm podzapytań, tutaj nieskorelowane
		
		select imie, nazwisko
		from firma.pracownicy
		where placa_podstawowa = 
				(select max(placa_podstawowa) from firma.pracownicy)
		
        imiona i nazwiska pracowników, którzy zostali zatrudnieni najwcześniej,
		
		select imie, nazwisko, data_zatrudnienia
		from firma.pracownicy
		where data_zatrudnienia = 
				(select min(data_zatrudnienia) from firma.pracownicy)
		
        imiona i nazwiska pracowników, którzy zarabiają więcej niż średnia płaca podstawowa,
		
		select imie, nazwisko
		from firma.pracownicy 
		where placa_podstawowa >  
					(select avg(placa_podstawowa)
					from firma.pracownicy );
					
        imiona i nazwiska pracowników, którzy zarabiają więcej niż średnia płaca podstawowa w ich wydziale,
		
		//podzapytanie skorelowane
		
		select imie, nazwisko, placa_podstawowa
		from firma.pracownicy p
		where placa_podstawowa >  
					(select avg(placa_podstawowa)
					from firma.pracownicy 
					where kod_wydzialu = p.kod_wydzialu);
		
        podaj listę pracowników pracujących na tym samym stanowisku co Sobczak Robert,
		
		select imie, nazwisko
		from firma.pracownicy 
		where kod_stanowiska =   
					(select kod_stanowiska
					from firma.pracownicy 
					where imie = 'Robert' and nazwisko = 'Sobczak');
					
        nazwy wydziałów, w których nie ma zatrudnionych pracowników,
		//not in //ważne!!!
		
		select nazwa
		from firma.wydzialy
		where kod_wydzialu not in 
					(select kod_wydzialu from firma.pracownicy)
		
        imiona, nazwiska, kody wydziałów, płacę podstawową tych pracowników, którzy otrzymują najwyższe płace podstawowe w swoich wydziałach,
		
		//porownywanie 2 kolumn jednoczesnie z uzyciem in (zawiera)
		
		select imie, nazwisko, kod_wydzialu, placa_podstawowa
		from firma.pracownicy
		where (kod_wydzialu, placa_podstawowa) IN 
		(select kod_wydzialu, max(placa_podstawowa)
		from firma.pracownicy
		group by kod_wydzialu)
		
        zmodyfikuj podpunkt poprzedni tak, aby wyświetlana była nazwa wydziału zamiast kodu wydziału,
		
		select p.imie, p.nazwisko, w.nazwa, p.placa_podstawowa
		from firma.pracownicy p join firma.wydzialy w on p.kod_wydzialu = w.kod_wydzialu
		where (p.kod_wydzialu, p.placa_podstawowa) IN 
		(select kod_wydzialu, max(placa_podstawowa)
		from firma.pracownicy
		group by kod_wydzialu)
		
        maksymalna średnia płac podstawowych z poszczególnych wydziałów,
		
		//korzystanie z roboczej tabeli//
		
		select max(srednia)
		from
				(select kod_wydzialu, avg(placa_podstawowa) as "srednia"
				from firma.pracownicy 
				group by kod_wydzialu) as robocza;
		
        kody wydziałów i średnie płac w tych wydziałach, w których średnie przekraczają średnią płac w całej firmie.
		
		select kod_wydzialu, avg(placa_podstawowa) as "srednia"
		from firma.pracownicy 
		group by kod_wydzialu
		having avg(placa_podstawowa) > 
		(select avg(placa_podstawowa) from firma.pracownicy)
		
