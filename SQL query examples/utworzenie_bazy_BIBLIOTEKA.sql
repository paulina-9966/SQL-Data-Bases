-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Czas generowania: 25 Maj 2019, 11:10
-- Wersja serwera: 10.1.37-MariaDB-0+deb9u1
-- Wersja PHP: 5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `paulp_biblioteka`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `czytelicy`
--

CREATE TABLE `czytelicy` (
  `nr_karty` int(10) NOT NULL,
  `pesel` varchar(11) DEFAULT NULL,
  `nazwisko` varchar(30) NOT NULL,
  `imie` varchar(20) DEFAULT NULL,
  `adres` varchar(150) DEFAULT NULL,
  `data_zapisu` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ksiazki`
--

CREATE TABLE `ksiazki` (
  `sygnatura` int(10) NOT NULL,
  `isbn` varchar(13) NOT NULL,
  `tytul` varchar(50) NOT NULL,
  `autorzy` varchar(150) NOT NULL,
  `wartosc` decimal(6,2) NOT NULL,
  `rok wydania` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `ksiazki`
--

INSERT INTO `ksiazki` (`sygnatura`, `isbn`, `tytul`, `autorzy`, `wartosc`, `rok wydania`) VALUES(1, 'tgsvuy6729348', 'Pan Tadeusz', 'Adam Mickiewicz', 34.00, 2002);
INSERT INTO `ksiazki` (`sygnatura`, `isbn`, `tytul`, `autorzy`, `wartosc`, `rok wydania`) VALUES(4, 'gdjfnsh632764', 'Noce i Dnie', 'Maria Dąbrowska', 29.00, 1987);
INSERT INTO `ksiazki` (`sygnatura`, `isbn`, `tytul`, `autorzy`, `wartosc`, `rok wydania`) VALUES(6, 'hsdfhsfghr457', 'Faraon', 'Władysław Reymont', 76.00, 1999);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wypozyczenia`
--

CREATE TABLE `wypozyczenia` (
  `id_wypozyczenia` int(10) NOT NULL,
  `sygnatura` int(10) NOT NULL,
  `nr_karty` int(10) NOT NULL,
  `data_wypozyczenia` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `czytelicy`
--
ALTER TABLE `czytelicy`
  ADD PRIMARY KEY (`nr_karty`),
  ADD UNIQUE KEY `pesel` (`pesel`);

--
-- Indexes for table `ksiazki`
--
ALTER TABLE `ksiazki`
  ADD PRIMARY KEY (`sygnatura`);

--
-- Indexes for table `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD PRIMARY KEY (`id_wypozyczenia`),
  ADD KEY `nr_karty` (`nr_karty`),
  ADD KEY `sygnatura` (`sygnatura`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `czytelicy`
--
ALTER TABLE `czytelicy`
  MODIFY `nr_karty` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `ksiazki`
--
ALTER TABLE `ksiazki`
  MODIFY `sygnatura` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT dla tabeli `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  MODIFY `id_wypozyczenia` int(10) NOT NULL AUTO_INCREMENT;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD CONSTRAINT `wypozyczenia_ibfk_1` FOREIGN KEY (`nr_karty`) REFERENCES `czytelicy` (`nr_karty`),
  ADD CONSTRAINT `wypozyczenia_ibfk_2` FOREIGN KEY (`sygnatura`) REFERENCES `ksiazki` (`sygnatura`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-----------------------------------------------------------------

--6 
---Podnieść o 10% wartość książek wydanych w roku 2018.

update ksiazki
set wartosc = 1.1*wartosc
where rok_wydania = 2002

--7  
--Dla wypożyczeń dokonanych przez czytelnika o numerze karty 1234567890 książek o sygnaturach: 9876543215, 4567891233, 7418529635 ustaw datę zwrotu na dzisiejszą.

update data_zwrotu


