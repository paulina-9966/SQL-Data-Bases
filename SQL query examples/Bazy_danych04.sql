Napisz w języku SQL zapytania wyświetlające następujące informacje z bazy danych czek:
nazwę pudełka oraz liczbę zamówień, na których występuje,
select p.nazwa, count(s.id_zam) 
from czek.pudelka p join czek.szczegolowe_zam s on p.id_pudelka = s.id_pudelka 
where p.nazwa is not null
group by p.nazwa

imiona i nazwiska dostawców wraz z liczbą dostarczonych zamówień, dla tych dostawców, którzy obsłużyli przynajmniej 15 zamówień,

select d.imie, d.nazwisko, count(z.id_zam)
from czek.dostawcy d join czek.zamowienia z on d.id_dostawcy = z.id_dostawcy
group by d.id_dostawcy
having count(z.id_zam) >=15;


imiona i nazwiska klientów wraz z liczbą złożonych zamówień. Wypisz także klientów, którzy nie złożyli żadnego zamówienia.
select k.imie, k.nazwisko, count(z.id_zam) as "ilość zamówień" from czek.klienci k left join czek.zamowienia z on k.id_klienta = z.id_klienta group by k.id_klienta

dla pudełka o nazwie 'Kolekcja alpejska' wypisz nazwy czekoladek, które znajdują się w tym pudełku,

select cz.nazwa, p.nazwa
from czek.o_pudelkach o join czek.czekoladki cz
                    on o.id_czek = cz.id_czek
                    join czek.pudelka p 
                    on o.id_pudelka = p.id_pudelka
where p.nazwa = upper('kolekcja alpejska')

nazwy i stan pudełek, których jest najmniej w magazynie,

select nazwa, sztuk_magazynie
		from czek.pudelka
		where sztuk_w_magzynie = 
				(select min(sztuk_w_magazynie) from czek.pudelka)
		

identyfikatory, imiona i nazwiska klientów, którzy nie złożyli żadnego zamówienia, 
select k.id_klienta, k.imie, k.nazwisko, z.id_zam
from czek.klienci k left join czek.zamowienia z on k.id_klienta = z.id_klienta
where z.id_zam is null

identyfikatory zamówień na najtańsze pudełko,

select z.id_zam, p.cena_pudelka, p.nazwa
		from czek.szczegolowe_zam sz join
        czek.zamowienia z on 
		sz.id_zam = z.id_zam
        join czek.pudelka p on sz.id_pudelka = p.id_pudelka    
        where cena_pudelka = 
				(select min(cena_pudelka) from czek.pudelka)
		

nazwy i koszt czekoladek oraz rodzaj czekolady, dla najdroższych czekoladek z każdego rodzaju czekolady,

select nazwa,koszt, rodzaj_czekolady
from czek.czekoladki
group by rodzaj_czekolady
order by max(koszt) 

maksymalną liczbę sztuk (sumę) zamówionych pudełek z poszczególnych zamówień.

select id_zam, count(ile_sztuk)
from czek.szczegolowe_zam
group by id_zam





