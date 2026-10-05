-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 01 jul 2026 om 10:26
-- Serverversie: 10.4.32-MariaDB
-- PHP-versie: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `urenregistratie`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `personen`
--

CREATE TABLE `personen` (
  `id` int(11) NOT NULL,
  `ov_nummer` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `voornaam` varchar(50) NOT NULL,
  `tussenvoegsel` varchar(20) DEFAULT NULL,
  `achternaam` varchar(50) NOT NULL,
  `geboortedatum` date NOT NULL,
  `IT/SD` varchar(4) NOT NULL,
  `gebruikersnaam` varchar(50) NOT NULL,
  `wachtwoord` varchar(50) NOT NULL,
  `gebruiker_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `personen`
--

INSERT INTO `personen` (`id`, `ov_nummer`, `email`, `voornaam`, `tussenvoegsel`, `achternaam`, `geboortedatum`, `IT/SD`, `gebruikersnaam`, `wachtwoord`, `gebruiker_id`) VALUES
(1, '155341', 'shaun.elves@student.gildeopleidingen.nl', 'shaun ', NULL, 'Elves', '2008-11-26', 'IT', 'shaun', 'Gilde123', 'gebruiker'),
(2, '155008', 'jason.vandenhoog@student.gildeopleidingen.nl', 'Jason', 'van den', 'Hoogen', '2009-02-08', 'SD', 'jason', '', ''),
(3, '155247', 'loic.wickert@student.gildeopleidingen.nl', 'Loic', 'Wickert', 'Bessil', '2007-09-28', 'IT', 'loic', '', ''),
(4, '154807', 'aniez.ouaday@student.gildeopleidingen.nl', 'Aniez', NULL, 'Ouaday', '2009-08-04', 'SD', 'aniez', 'Gilde123', 'gebruiker'),
(5, '155901', 'jur.jansen@student.gildeopleidingen.nl', 'Jur', NULL, 'Jansen', '2009-11-27', 'IT', 'jur', 'Gilde123', 'gebruiker'),
(6, '155453', 'ceasar.???@student.gildeopleidingen.nl', 'Ceasar', NULL, '????', '2007-09-28', 'IT', 'ceasar', 'Gilde123', 'gebruiker'),
(7, '', '', '', NULL, '', '0000-00-00', '', 'HR', 'Gilde123', 'HR'),
(8, '', '', '', NULL, '', '0000-00-00', '', 'Facturisatie', 'Gilde123', 'Facturisatie');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `projecten`
--

CREATE TABLE `projecten` (
  `project_id` int(11) NOT NULL,
  `project_naam` varchar(100) NOT NULL,
  `omschrijving` text DEFAULT NULL,
  `productowner` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `projecten`
--

INSERT INTO `projecten` (`project_id`, `project_naam`, `omschrijving`, `productowner`) VALUES
(1, 'Webserver', 'tweede Virtuele Server bouwen als webserver', 'Mark'),
(2, 'Database', 'Een database maken om alles te registreren ', 'Fred'),
(3, 'Website Urenoverzicht', 'Website maken om de uren te registreren en te bekijken met een homepagina', 'Sieske'),
(4, 'Netwerktekening', 'Netwerktekening maken van datacenter met een verslag in het engels en nederlands', 'Johan en (Inez/Pascal)'),
(5, '1D Pong', 'Pongspel maken en programmeren', 'Ruud'),
(6, 'Servicedesk', 'Mensen helpen', ''),
(7, 'Living labs burgerschap ', 'Living labs burgerschap roermond', ''),
(8, 'scrumboard', 'Scrumboard invullen en plannen maken voor wat je gaat doen', ''),
(9, 'Schoolwerk', 'Schoolwerk', ''),
(10, 'testomgeving maken ', 'nieuwe testomgeving maken voor het netwerk om het professioneel beheerd en beveiligd \r\nlaten worden', 'Mark'),
(11, 'applicatie maken', 'schetsen en voorbeelden laten zien hoe alles is gekoppelt en hoe alles er uit gaat zien', 'Ruud'),
(12, 'Urenregistratie', 'het koppelen van de urenregistratie met sql', 'Sieske en Inez'),
(13, 'back ups maken ', 'back ups maken voor server', 'Mark en Johan');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `uren`
--

CREATE TABLE `uren` (
  `project_id` int(11) NOT NULL,
  `persoon_id` int(11) NOT NULL,
  `aantal_uren` decimal(5,2) NOT NULL,
  `werkzaamheden` text DEFAULT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `uren`
--

INSERT INTO `uren` (`project_id`, `persoon_id`, `aantal_uren`, `werkzaamheden`, `datum`) VALUES
(1, 1, 2.75, 'Alles opzetten', '2026-02-09'),
(1, 2, 2.75, 'Alles opzetten', '2026-02-09'),
(1, 3, 2.75, 'Alles opzetten', '2026-02-09'),
(1, 4, 2.75, 'Alles opzetten', '2026-02-09'),
(1, 1, 2.75, 'Flexplek en proxmox', '2026-02-10'),
(1, 2, 2.75, 'Flexplek en proxmox', '2026-02-10'),
(8, 3, 2.75, 'vragen bedenken en die op een blaadje zetten voor een US story', '2026-02-10'),
(8, 4, 2.75, 'vragen bedenken en die op een blaadje zetten voor ...', '2026-02-10'),
(7, 1, 2.75, 'Living labs bekeken', '2026-02-11'),
(9, 2, 2.75, 'Schoolwerk', '2026-02-11'),
(7, 3, 2.75, 'Living labs bekeken', '2026-02-11'),
(7, 4, 2.75, 'Living labs bekeken', '2026-02-11'),
(6, 1, 2.75, 'Helpdesk', '2026-02-12'),
(6, 2, 2.75, 'Helpdesk', '2026-02-12'),
(8, 4, 2.75, 'Vragen bedenken voor US stories', '2026-02-12'),
(6, 1, 2.75, 'Helpdesk', '2026-02-23'),
(6, 2, 2.75, 'Helpdesk', '2026-02-23'),
(8, 4, 2.75, 'Dingen klaarzetten voor morgen', '2026-02-23'),
(3, 1, 2.75, 'Ethernet en server gefixt', '2026-02-24'),
(2, 2, 2.75, 'Database gemaakt en ingevuld met vorige data', '2026-02-24'),
(1, 3, 2.75, 'Ethernet en server gefixt', '2026-02-24'),
(2, 4, 2.75, 'Database gemaakt en ingevuld', '2026-02-24'),
(1, 1, 2.75, 'Uren invullen en onderzoek doen', '2026-02-25'),
(1, 2, 2.75, 'Klaarmaken voor database en webserver', '2026-02-25'),
(1, 3, 2.75, 'Klaarmaken voor database en webserver', '2026-02-25'),
(2, 4, 2.75, 'Onderzoek doen over database', '2026-02-25'),
(2, 2, 2.75, 'Uren invullen en database maken', '2026-02-26'),
(1, 1, 2.75, 'MySQL installeren en zorgen dat het werkt', '2026-02-26'),
(1, 3, 2.75, 'MySQL installeren en zorgen dat het werkt', '2026-02-26'),
(5, 4, 2.75, '1D Pong onderzoeken en programmeren', '2026-02-26'),
(2, 2, 2.75, 'Uren registreren en database klaarmaken', '2026-03-02'),
(1, 1, 2.75, 'Webserver klaarmkane voor de website en de database', '2026-03-02'),
(1, 3, 2.75, 'Shaun helpen met het klaarmaken van andere dingen', '2026-03-02'),
(3, 4, 2.75, 'Homepagina maken ', '2026-03-02'),
(1, 1, 2.75, 'Webserver klaarmaken voor de website en database', '2026-03-03'),
(1, 3, 2.75, 'Shaun helpen met de webserver klaarmaken voor de website en de database', '2026-03-03'),
(3, 4, 2.75, 'Homepagina aanpassen', '2026-03-03'),
(1, 3, 2.75, 'Shaun helpen met de webserver klaarmaken voor de website en de database', '2026-03-04'),
(1, 1, 2.75, 'Webserver klaarmaken voor de website en de database', '2026-03-04'),
(3, 4, 2.75, 'Urenregistratie maken ', '2026-03-04'),
(1, 3, 2.75, 'Shaun helpen met het fixen van de instelling in proxmox', '2026-03-05'),
(1, 1, 2.75, 'Fixen instellingen in proxmox', '2026-03-05'),
(3, 4, 2.75, 'Urenregistratie mooier maken ', '2026-03-05'),
(1, 1, 2.75, 'PHP opnieuw installeren en configreren', '2026-03-09'),
(1, 3, 2.75, 'Shaun helpen met het configreren en opnieuw installeren van PHP', '2026-03-09'),
(5, 4, 2.75, 'het programmeren en kijken naar de code van het pongspel', '2026-03-09'),
(1, 1, 2.75, '2de website maken', '2026-03-10'),
(1, 3, 2.75, 'Shaun helpen met 2de website maken ', '2026-03-10'),
(5, 4, 2.75, 'code bekijken en dingen aanpassen', '2026-03-10'),
(1, 1, 2.75, '2 websites laten draaien los van default', '2026-03-11'),
(1, 3, 2.75, 'Shaun helpen met 2 websites laten draaien los van default', '2026-03-11'),
(5, 4, 2.75, 'Pongspel programmeren en code bekijken', '2026-03-11'),
(4, 1, 2.75, 'netwerktekeningen maken voor een documentatie voor nederlands en engels', '2026-03-12'),
(3, 3, 2.75, 'Shaun helpen met de netwerktekeing maken voor de documentatie van nederlands en engels', '2026-03-12'),
(1, 4, 2.75, 'nieuwe tabel aanmaken (projecten)en koppelen met de andere tabel', '2026-03-12'),
(9, 1, 2.75, 'Schoolwerk', '2026-03-15'),
(4, 3, 2.75, 'netwerktekening maken', '2026-03-15'),
(2, 4, 2.75, 'de urenregistratie op de proxmox zetten', '2026-03-15'),
(3, 4, 2.75, 'webpagina mooier maken ', '2026-03-24'),
(5, 1, 2.00, 'Pong spel nachecken', '2026-03-24'),
(3, 4, 1.15, 'urenoverzicht aanpassen(met de posities en section spelen)', '2026-03-25'),
(10, 5, 2.25, 'VM`s downloaden', '2026-05-18'),
(10, 5, 2.25, 'VM\'s downloaden', '2026-05-18'),
(10, 5, 2.25, 'VM\'s downloaden', '2026-05-19'),
(10, 5, 2.75, 'VM\'s downloaden', '2026-05-20'),
(10, 5, 2.75, 'VM\'s instellen', '2026-05-21'),
(6, 5, 2.75, 'mensen helpen', '2026-05-22'),
(6, 5, 2.75, 'mensen helpen', '2026-06-25'),
(10, 5, 2.75, 'VM\'s instellen ', '2026-05-26'),
(9, 5, 2.75, 'Netwerk fixen', '2026-05-27'),
(10, 5, 2.75, 'VM\'s koppelen', '2026-05-28'),
(9, 5, 2.75, 'huiswerk', '2026-05-29'),
(9, 5, 2.75, 'huiswerk', '2026-06-01'),
(9, 5, 2.75, 'huiswerk', '2026-06-02'),
(9, 5, 2.75, 'Netwerk fixen', '2026-06-03'),
(10, 5, 2.75, 'VM\'s koppelen', '2026-06-04'),
(9, 5, 2.75, 'huiswerk', '2026-06-05'),
(10, 5, 2.25, 'Packet Tracer netwerk', '2026-06-08'),
(10, 5, 2.25, 'VM\'s instellingen aanpassen', '2026-06-09'),
(10, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-10'),
(9, 5, 2.75, 'huiswerk', '2026-06-12'),
(10, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-16'),
(10, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-17'),
(8, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-18'),
(9, 5, 2.75, 'huiswerk', '2026-06-19'),
(10, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-23'),
(10, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-24'),
(9, 5, 2.75, 'huiswerk', '2026-06-27'),
(1, 5, 2.25, 'VM\'s downloaden', '2026-05-18'),
(1, 1, 2.75, 'Gezamelijke bestanden', '2026-05-18'),
(3, 4, 2.75, 'Vragen PO over US3', '2026-05-18'),
(1, 5, 2.25, 'VM\'s opzetten', '2026-05-19'),
(1, 1, 2.75, 'Gezamelijke bestanden', '2026-05-19'),
(2, 4, 2.75, 'Usecase-diagram', '2026-05-19'),
(1, 5, 2.75, 'VM\'s opzetten', '2026-05-20'),
(4, 1, 2.75, 'Urenregistratie', '2026-05-20'),
(2, 4, 2.25, 'Usecase-diagram', '2026-05-20'),
(1, 5, 2.75, 'VM\'s instellen', '2026-05-21'),
(1, 1, 2.75, 'Testrapport', '2026-05-21'),
(5, 5, 2.75, 'Helpdesk', '2026-05-25'),
(5, 1, 2.75, 'Helpdesk', '2026-05-25'),
(1, 5, 2.75, 'VM\'s instellen', '2026-05-26'),
(1, 1, 2.75, 'Testrapport', '2026-05-26'),
(3, 4, 2.75, 'Database maken', '2026-05-26'),
(3, 4, 2.75, 'Database opzetten', '2026-05-27'),
(1, 5, 2.75, 'VM\'s koppelen', '2026-05-28'),
(1, 1, 2.75, 'Testrapport', '2026-05-28'),
(3, 4, 2.75, 'Database opzetten', '2026-05-28'),
(3, 4, 2.75, 'Database koppelen PHP', '2026-06-02'),
(3, 4, 2.75, 'Database opzetten', '2026-06-03'),
(1, 5, 2.75, 'VM\'s koppelen', '2026-06-04'),
(3, 4, 2.75, 'Query PDO met PHP', '2026-06-04'),
(1, 5, 2.25, 'Packet Tracer netwerk', '2026-06-08'),
(3, 4, 2.75, 'Low/high fadelity', '2026-06-08'),
(7, 6, 2.75, 'Huiswerk', '2026-06-08'),
(1, 5, 2.25, 'VM\'s instellingen aanpassen', '2026-06-09'),
(1, 1, 2.75, 'Testrapport', '2026-06-09'),
(1, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-10'),
(3, 1, 2.75, 'Schets maken van eind product', '2026-06-10'),
(3, 4, 2.75, 'Vragen PO over US3', '2026-06-10'),
(3, 4, 2.75, 'Dataverlies fixen', '2026-06-11'),
(1, 1, 2.75, 'Documenteren', '2026-06-15'),
(3, 4, 2.75, 'Low/high fadelity', '2026-06-15'),
(1, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-16'),
(1, 1, 2.75, 'Documenteren', '2026-06-16'),
(3, 4, 2.75, 'Alles koppelen en vaststellen', '2026-06-16'),
(7, 6, 2.75, 'Huiswerk', '2026-06-16'),
(1, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-17'),
(1, 1, 2.75, 'Documenteren', '2026-06-17'),
(3, 4, 2.75, 'Alles koppelen en vaststellen', '2026-06-17'),
(1, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-18'),
(1, 1, 2.75, 'Documenteren', '2026-06-18'),
(3, 4, 2.75, 'Alles koppelen en vaststellen', '2026-06-18'),
(1, 1, 2.75, 'Userstory 1', '2026-06-22'),
(3, 4, 2.75, 'Userstory 3', '2026-06-22'),
(1, 5, 2.75, 'VM\'s instellingen aanpassen', '2026-06-23'),
(1, 1, 2.75, 'Documenteren', '2026-06-23'),
(3, 4, 2.75, 'Alles koppelen en vaststellen', '2026-06-23'),
(7, 6, 2.75, 'Huiswerk', '2026-06-23'),
(1, 5, 2.75, 'Userstory 1', '2026-06-24'),
(1, 1, 2.75, 'Userstory 1', '2026-06-24'),
(3, 4, 2.75, 'Userstory 3', '2026-06-24'),
(1, 1, 2.75, 'Userstory 1', '2026-06-25'),
(3, 4, 2.75, 'Userstory 3', '2026-06-25'),
(5, 5, 2.75, 'Servicedesk', '2026-05-22'),
(5, 1, 2.75, 'Servicedesk', '2026-05-22'),
(7, 4, 2.75, 'Huiswerk', '2026-05-22'),
(7, 6, 2.75, 'Huiswerk', '2026-05-22'),
(7, 5, 2.75, 'Huiswerk', '2026-05-29'),
(7, 1, 2.75, 'Huiswerk', '2026-05-29'),
(7, 4, 2.75, 'Huiswerk', '2026-05-29'),
(7, 6, 2.75, 'Huiswerk', '2026-05-29'),
(7, 6, 2.75, 'Leren CCNA', '2026-06-03'),
(7, 5, 2.75, 'Huiswerk', '2026-06-05'),
(7, 1, 2.75, 'Huiswerk', '2026-06-05'),
(7, 4, 2.75, 'Huiswerk', '2026-06-05'),
(7, 6, 2.75, 'Huiswerk', '2026-06-05'),
(7, 5, 2.75, 'Huiswerk', '2026-06-12'),
(7, 1, 2.75, 'Huiswerk', '2026-06-12'),
(7, 4, 2.75, 'Huiswerk', '2026-06-12'),
(7, 6, 2.75, 'Huiswerk', '2026-06-12'),
(7, 5, 2.75, 'Huiswerk', '2026-06-19'),
(7, 1, 2.75, 'Huiswerk', '2026-06-19'),
(7, 4, 2.75, 'Huiswerk', '2026-06-19'),
(7, 6, 2.75, 'Huiswerk', '2026-06-19'),
(1, 5, 2.75, 'Userstory 1', '2026-06-22'),
(1, 5, 2.75, 'Userstory 1', '2026-06-25'),
(7, 5, 2.75, 'Huiswerk', '2026-06-27'),
(7, 1, 2.75, 'Huiswerk', '2026-06-27'),
(7, 4, 2.75, 'Huiswerk', '2026-06-27'),
(7, 6, 2.75, 'Huiswerk', '2026-06-27');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `personen`
--
ALTER TABLE `personen`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `projecten`
--
ALTER TABLE `projecten`
  ADD KEY `project_id` (`project_id`);

--
-- Indexen voor tabel `uren`
--
ALTER TABLE `uren`
  ADD KEY `persoon_id` (`persoon_id`),
  ADD KEY `project_id` (`project_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `personen`
--
ALTER TABLE `personen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `uren`
--
ALTER TABLE `uren`
  ADD CONSTRAINT `uren_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`project_id`),
  ADD CONSTRAINT `uren_ibfk_3` FOREIGN KEY (`persoon_id`) REFERENCES `personen` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
