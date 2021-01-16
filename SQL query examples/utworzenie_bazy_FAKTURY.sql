-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Czas generowania: 08 Cze 2019, 21:33
-- Wersja serwera: 10.1.37-MariaDB-0+deb9u1
-- Wersja PHP: 5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `paulp_faktura`
--
CREATE DATABASE IF NOT EXISTS `paulp_faktura` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;
USE `paulp_faktura`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `faktury`
--

CREATE TABLE `faktury` (
  `nr_faktury` int(10) NOT NULL,
  `data_wystawienia` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `termin_platnosci` int(2) NOT NULL,
  `kod_nabywcy` int(10) NOT NULL,
  `czy_zaplacona` varchar(1) COLLATE utf8mb4_polish_ci NOT NULL DEFAULT 'n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `nabywcy`
--

CREATE TABLE `nabywcy` (
  `kod_nabywcy` int(10) NOT NULL,
  `nazwa` text COLLATE utf8mb4_polish_ci NOT NULL,
  `nip` varchar(10) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `adres` text COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `nabywcy`
--

INSERT INTO `nabywcy` (`kod_nabywcy`, `nazwa`, `nip`, `adres`) VALUES
(1, 'Pączki i spółka', '1234567895', 'ul. Ametystowa 12'),
(3, 'Bajeczna piekarnia', '3546576835', 'ul. Koralowa 345'),
(4, 'Sklep ogrodniczy Fikołek', '464564vgr6', 'ul. Ogrodniczki 45');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `towary`
--

CREATE TABLE `towary` (
  `id_towaru` int(10) NOT NULL,
  `nazwa` text COLLATE utf8mb4_polish_ci NOT NULL,
  `jednostka` text COLLATE utf8mb4_polish_ci NOT NULL,
  `stan` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `towary_na_fakturze`
--

CREATE TABLE `towary_na_fakturze` (
  `id_towaru` int(10) NOT NULL,
  `nr_faktury` int(10) NOT NULL,
  `ilosc` double NOT NULL,
  `cena` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `faktury`
--
ALTER TABLE `faktury`
  ADD PRIMARY KEY (`nr_faktury`),
  ADD KEY `kod_nabywcy` (`kod_nabywcy`);

--
-- Indexes for table `nabywcy`
--
ALTER TABLE `nabywcy`
  ADD PRIMARY KEY (`kod_nabywcy`);

--
-- Indexes for table `towary`
--
ALTER TABLE `towary`
  ADD PRIMARY KEY (`id_towaru`);

--
-- Indexes for table `towary_na_fakturze`
--
ALTER TABLE `towary_na_fakturze`
  ADD PRIMARY KEY (`nr_faktury`),
  ADD UNIQUE KEY `id_towaru` (`id_towaru`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `faktury`
--
ALTER TABLE `faktury`
  MODIFY `nr_faktury` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `nabywcy`
--
ALTER TABLE `nabywcy`
  MODIFY `kod_nabywcy` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT dla tabeli `towary`
--
ALTER TABLE `towary`
  MODIFY `id_towaru` int(10) NOT NULL AUTO_INCREMENT;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `faktury`
--
ALTER TABLE `faktury`
  ADD CONSTRAINT `faktury_ibfk_1` FOREIGN KEY (`kod_nabywcy`) REFERENCES `nabywcy` (`kod_nabywcy`);

--
-- Ograniczenia dla tabeli `towary_na_fakturze`
--
ALTER TABLE `towary_na_fakturze`
  ADD CONSTRAINT `towary_na_fakturze_ibfk_1` FOREIGN KEY (`id_towaru`) REFERENCES `towary` (`id_towaru`),
  ADD CONSTRAINT `towary_na_fakturze_ibfk_2` FOREIGN KEY (`nr_faktury`) REFERENCES `faktury` (`nr_faktury`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


update nabywcy
set adres = 'Lublin, ul.Słoneczna 13'
where nip= 1234567895

update faktury
set termin_platnosci = 30
where data_wystawienia= '2019-05-10'

Usuń towary, których stan wynosi 0.
delete from towary 
where stan = 0

Nadaj użytkownikowi 'ajakostu' uprawnienia odczytu danych z prawem przekazywania do tabeli towary z bazy faktura.

Grant select
on 'paulp_faktura'.'towary'
to 'ajakostu'@'localhost'
with grant options



