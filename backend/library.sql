-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: St 10.Feb 2021, 01:08
-- Verzia serveru: 10.4.17-MariaDB
-- Verzia PHP: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `library`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `autori`
--

CREATE TABLE `autori` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `autori`
--

INSERT INTO `autori` (`id`, `name`) VALUES
(1, 'Joseph Heller'),
(2, 'Jozef Karika'),
(3, 'Mario Puzo'),
(4, 'J.R.R. Tolkien');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `kategorie`
--

CREATE TABLE `kategorie` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `kategorie`
--

INSERT INTO `kategorie` (`id`, `name`) VALUES
(1, 'Akčný'),
(2, 'Triler'),
(3, 'Fantasy'),
(4, 'Román'),
(5, 'Rozprávka');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `knihy`
--

CREATE TABLE `knihy` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `isbn` text NOT NULL,
  `price` double NOT NULL,
  `category` int(11) NOT NULL,
  `author` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `knihy`
--

INSERT INTO `knihy` (`id`, `name`, `isbn`, `price`, `category`, `author`) VALUES
(1, 'Hlava 22', '9780099529118', 12.3, 4, 1),
(2, 'Čierny rok: Vojna mafie', '9788055157528', 118.01, 2, 2),
(3, 'Krstný otec', '9788055146461', 66.95, 2, 3),
(4, 'Pán prsteňov I. - Spoločenstvo prsteňa', '9788055606347', 16.15, 3, 4);

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `autori`
--
ALTER TABLE `autori`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `kategorie`
--
ALTER TABLE `kategorie`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `knihy`
--
ALTER TABLE `knihy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `autori`
--
ALTER TABLE `autori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pre tabuľku `kategorie`
--
ALTER TABLE `kategorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pre tabuľku `knihy`
--
ALTER TABLE `knihy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `knihy`
--
ALTER TABLE `knihy`
  ADD CONSTRAINT `knihy_ibfk_1` FOREIGN KEY (`category`) REFERENCES `kategorie` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
