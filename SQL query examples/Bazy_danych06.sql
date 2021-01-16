
identyfikator zamówienia i liczbę pełnych dni, jakie upłynęły od daty tego zamówienia,

select id_zam as "id zamowienia" , datediff(curdate(),data_zam) as "Liczba dni", data_zam
        from czek.zamowienia ;
        
dla każdego zamówienia z października, które opłacono przelewem, wyświetlić identyfikatory zamówienia, dostawcy i klienta,
miasta, z których pochodzą klienci - bez powtórzeń,

select id_zam, id_klienta, id_dostawcy, data_zam, forma_zaplaty
from czek.zamowienia 
where extract(month from data_zam) = 10 and forma_zaplaty="p";

miasta, z których pochodzą klienci - bez powtórzeń,

select distinct miasto 
from klienci

maksymalną, minimalną oraz średnią cenę pudełek z czekoladkami
select max(cena_pudelka), min(cena_pudelka), avg(cena_pudelka)
from czek.pudelka
group by nazwa

średni koszt czekoladek, w których opisie występuje słowo 'migdał',
select avg(czekoladki.koszt) as "srednia cena"
from czek.czekoladki 
where koszt is not null

nazwy regionów i liczbę klientów z tych regionów uporządkowane alfabetycznie według regionów,
select count(id_klienta) as "liczba klientow", region as "region"
from czek.klienci  
group by region
ORDER BY region DES

identyfikatory klientów i liczbę złożonych przez nich zamówień.
select count(id_zam) as "liczba zamowien", id_klienta
from czek.zamowienia
group by id_klienta;





miasta oraz liczbę klientów z tych, gdzie jest przynajmniej trzech klientów,
select miasto, count(id_klienta) 
from czek.klienci
group by miasto
having count(id_klienta) > 4;

liczbę czekoladek wykonanych z czekolady mlecznej,
select count(id_czek)
from czek.czekoladki 
where rodzaj_czekolady = "mleczna";

dla każdego zamówienia podaj numer zamówienia, datę zamówienia, imię i nazwisko klienta, posortowane malejąco względem daty zamówienia,
select z.id_zam, z.data_zam, k.imie, k.nazwisko 
from czek.zamowienia z Join czek.klienci k on k.id_klienta = z.id_klienta
group by data_zam desc;

dla każdego zamówienia podaj numer zamówienia, datę zamówienia, imię i nazwisko klienta, imię i nazwisko dostawcy. Kolumnom nadaj odpowiednie nagłówki.

select z.id_zam as "id zamówienia" , z.data_zam as "data zamówienia", k.imie as "imie klienta", k.nazwisko as "nazwisko klienta", d.imie as "imie dostawcy", d.nazwisko as "nazwisko dostawcy"
from czek.zamowienia z 
Join czek.klienci k on z.id_klienta = k.id_klienta
Join czek.dostawcy d  on z.id_dostawcy = d.id_dostawcy;

podaj liczbę zamówień złożonych każdego dnia (tylko dla tych dni, kiedy było coś zamawiane). Dane posortuj względem liczby złożonych zamówień

select count(id_zam) as "liczba zamówień", data_zam
from czek.zamowienia
group by extract(day from data_zam) 
order by count(id_zam) desc

wyświetl pełną informację o zawartości pudełek: nazwę pudełka, nazwę czekoladki oraz liczbę sztuk czekoladek w pudełku. Dane posortuj względem nazwy pudełka oraz nazwy czekoladki.

select p.nazwa as "nazwa pudełka", cz.nazwa as "nazwa czekoladki", o.l_sztuk as "liczba sztuk w pudełku"
from czek.pudelka p Join czek.o_pudelkach o on p.id_pudelka = o.id_pudelka
Join czek.czekoladki cz on o.id_czek = cz.id_czek
group by p.nazwa, cz.nazwa

dla każdego identyfikatora pudełka podaj łączną liczbę (sumę) czekoladek w pudełku,

select p.id_pudelka, o.l_sztuk as "liczba szt w pudelku"
from czek.pudelka p Join czek.o_pudelkach o on p.id_pudelka = o.id_pudelka

identyfikatory zamówień, na których łączna liczba zamówionych pudełek jest >5,
select id_zam, count(ile_sztuk)
from czek.szczegolowe_zam
group by id_zam
having count(ile_sztuk) >5;

dla zamówień, które opłacono gotówką ('g') podaj ile zamówień złożono każdym ze sposobów zamawiania.
select id_zam, forma_zaplaty, sposob_zam
from czek.zamowienia
group by sposob_zam
having forma_zaplaty = 'g'
