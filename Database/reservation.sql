-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2025 at 03:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `places_disponibles` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `titre`, `prix`, `places_disponibles`) VALUES
(1, 'Concert du samedi', 25.00, 100),
(2, 'Spectacle de danse', 40.00, 80),
(3, 'Théâtre du soir', 30.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `quantite` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `date_reservation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `event_id`, `nom`, `email`, `quantite`, `total`, `date_reservation`) VALUES
(1, 1, 'Dupont', 'dupont@test.com', 3, 75.00, '2025-10-14 13:51:27'),
(2, 1, 'Dupont', 'dupont@test.com', 3, 75.00, '2025-10-14 19:47:24'),
(3, 1, 'Dupont', 'dupont@test.com', 3, 75.00, '2025-10-15 01:33:35'),
(4, 1, 'Dupont', 'dupont@test.com', 3, 75.00, '2025-10-15 01:37:59'),
(5, 3, 'a', 'a@a.a', 1, 30.00, '2025-10-15 01:40:51'),
(6, 3, 'a', 'a@a.a', 1, 30.00, '2025-10-15 01:40:56'),
(7, 3, 'a', 'a@a.a', 1, 30.00, '2025-10-15 01:49:11'),
(8, 3, 'a', 'a@a.a', 1, 30.00, '2025-10-15 01:49:16'),
(9, 3, 'a', 'a@a.a', 1, 30.00, '2025-10-15 02:04:38'),
(10, 1, 'a', 'a@a.a', 1, 25.00, '2025-10-15 02:05:37'),
(11, 1, 'a', 'a@a.a', 1, 25.00, '2025-10-15 02:08:56'),
(12, 1, 'a', 'a@a.a', 2, 50.00, '2025-10-15 02:09:36'),
(13, 1, 'aa', 'a@a.a', 2, 50.00, '2025-10-15 02:11:11'),
(14, 1, 'a', 'a@a.a', 1, 25.00, '2025-10-15 02:24:04'),
(15, 1, 'a', 'a@a.a', 1, 25.00, '2025-10-15 02:27:01'),
(16, 3, 'a', 'a@a.a', 44, 1320.00, '2025-10-15 02:49:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
