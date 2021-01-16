-- ------------------------------------------------------   
-- UTWORZENIE BAZY DANYCH
-- ------------------------------------------------------   

-- CREATE DATABASE IF NOT EXISTS `login_transport` DEFAULT CHARACTER SET utf8;
-- USE `login_transport` ;

-- ------------------------------------------------------   
-- USUNIĘCIE TABEL
-- ------------------------------------------------------   

-- DROP TABLE IF EXISTS dzialy;
-- DROP TABLE IF EXISTS klienci;
-- DROP TABLE IF EXISTS pojazdy;
-- DROP TABLE IF EXISTS pracownicy;
-- DROP TABLE IF EXISTS kursy;

-- --------------------------------------------------------   
-- DDL TABELI DZIALY
-- --------------------------------------------------------   

CREATE TABLE IF NOT EXISTS dzialy (
	id_dzialu int(10) PRIMARY KEY,
	nazwa varchar(20) NOT NULL,
	adres varchar(40) NOT NULL,
	telefon varchar(11)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------   
-- DDL TABELI KLIENCI
-- --------------------------------------------------------   

CREATE TABLE IF NOT EXISTS klienci (
	id_klienta int(10) PRIMARY KEY,
	nazwa varchar(20) NOT NULL,
	nip char(7) NOT NULL UNIQUE,
	miasto varchar(20) NOT NULL,
	adres_kl varchar(40) NOT NULL,
	telefon varchar(11)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------   
-- DDL TABELI POJAZDY
-- --------------------------------------------------------   

CREATE TABLE IF NOT EXISTS pojazdy (
	id_pojazdu int(10) PRIMARY KEY, 
	marka varchar(20) NOT NULL, 
	nr_rej char(8) NOT NULL, 
	data_przegladu date, 
	typ char(1), 
	przebieg int(10) DEFAULT 0
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------   
-- DDL TABELI PRACOWNICY
-- --------------------------------------------------------   

CREATE TABLE IF NOT EXISTS pracownicy (
 	id_pracownika int(10), 
	nazwisko varchar(20), 
	imie varchar(20), 
	pesel char(11), 
	kategorie varchar(10), 
	stanowisko varchar(20), 
	pensja float(10,2), 
	data_zatrud date, 
	id_dzialu int(10)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------   
-- DDL TABELI KURSY
-- --------------------------------------------------------   

CREATE TABLE IF NOT EXISTS kursy (
	id_kursu int(10) PRIMARY KEY AUTO_INCREMENT,
	wyjazd date NOT NULL,
	powrot date,
	id_klienta int(10) NOT NULL,
	id_kierowcy int(10) NOT NULL,
	id_pojazdu int(10) NOT NULL,
	cel_miasto varchar(30) NOT NULL, 
	cel_adres varchar(60) NOT NULL, 
	odl_km float(6,2) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------   
-- CONSTRAINTS DO TABELI PRACOWNICY
-- --------------------------------------------------------  

ALTER TABLE pracownicy ADD PRIMARY KEY (id_pracownika);
ALTER TABLE pracownicy MODIFY nazwisko varchar(20) NOT NULL;
ALTER TABLE pracownicy MODIFY imie varchar(20) NOT NULL;
ALTER TABLE pracownicy MODIFY pesel char(11) NOT NULL UNIQUE;
ALTER TABLE pracownicy MODIFY stanowisko varchar(20) NOT NULL;
ALTER TABLE pracownicy MODIFY data_zatrud datetime DEFAULT current_timestamp NOT NULL ;

-- --------------------------------------------------------   
-- POWIĄZANIA POMIĘDZY TABELAMI
-- --------------------------------------------------------  

ALTER TABLE kursy ADD CONSTRAINT fk_kursy_klienci 
	FOREIGN KEY (id_klienta) REFERENCES klienci(id_klienta) ON DELETE CASCADE;
	
ALTER TABLE kursy ADD CONSTRAINT fk_kursy_pracownicy
	FOREIGN KEY (id_kierowcy) REFERENCES pracownicy(id_pracownika) ON DELETE CASCADE;

ALTER TABLE kursy ADD CONSTRAINT fk_kursy_pojazdy
	FOREIGN KEY (id_pojazdu) REFERENCES pojazdy(id_pojazdu) ON DELETE CASCADE;
	
ALTER TABLE pracownicy ADD CONSTRAINT fk_pracownicy_dzialy
	FOREIGN KEY (id_dzialu) REFERENCES dzialy(id_dzialu) ON DELETE CASCADE;



-- --------------------------------------------------------   
-- WPROWADZENIE PRZYKŁADOWYCH DANYCH
-- -------------------------------------------------------- 

INSERT INTO dzialy (ID_DZIALU,NAZWA,ADRES,TELEFON) 
	VALUES ('12','Transport','Lublin, ul. Jasna 3','81 2341111');
INSERT INTO dzialy (ID_DZIALU,NAZWA,ADRES,TELEFON) 
	VALUES ('13','Księgowość','Lublin, ul. Jasna 3','81 2341131');
INSERT INTO dzialy (ID_DZIALU,NAZWA,ADRES,TELEFON) 
	VALUES ('14','Zarząd','Lublin, ul. Jasna 3','81 2341134');

	
INSERT INTO klienci (ID_KLIENTA,NAZWA,NIP,MIASTO,ADRES_KL) 
	VALUES ('501','Empatia LTD','7123456','Lublin','Mełgiewska 3');
INSERT INTO klienci (ID_KLIENTA,NAZWA,NIP,MIASTO,ADRES_KL) 
	VALUES ('502','Jan Górski','7145321','Warszawa','Al. Jerozolimskie 43');
INSERT INTO klienci (ID_KLIENTA,NAZWA,NIP,MIASTO,ADRES_KL) 
	VALUES ('503','Stonoga SA','7123666','Lublin','Jasna 5');	
	
INSERT INTO pojazdy (ID_POJAZDU,MARKA,NR_REJ,DATA_PRZEGLADU,TYP,PRZEBIEG) 
	VALUES ('901','Ford Transit','LU1456V',str_to_date('20114/07/27','%Y/%m/%d'),'C','15600');
INSERT INTO pojazdy (ID_POJAZDU,MARKA,NR_REJ,DATA_PRZEGLADU,TYP,PRZEBIEG) 
	VALUES ('902','Fiat Ducato','WX1456A',str_to_date('2013/05/23','%Y/%m/%d'),'C','66600');
INSERT INTO pojazdy (ID_POJAZDU,MARKA,NR_REJ,DATA_PRZEGLADU,TYP,PRZEBIEG) 
	VALUES ('903','Ford Mondeo','LU14500',str_to_date('2015/07/23','%Y/%m/%d'),'O','546546');

