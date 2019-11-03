-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2019 at 06:30 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hus_web`
--
CREATE DATABASE IF NOT EXISTS `hus_web` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci;
USE `hus_web`;

-- --------------------------------------------------------

--
-- Table structure for table `ability_dictionary`
--
-- Creation: Nov 03, 2019 at 04:04 AM
--

DROP TABLE IF EXISTS `ability_dictionary`;
CREATE TABLE `ability_dictionary` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `type_id` int(11) NOT NULL,
  `description` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `ability_dictionary`:
--   `type_id`
--       `ability_type` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `ability_type`
--
-- Creation: Nov 03, 2019 at 04:05 AM
--

DROP TABLE IF EXISTS `ability_type`;
CREATE TABLE `ability_type` (
  `id` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `ability_type`:
--

-- --------------------------------------------------------

--
-- Table structure for table `intern_ability`
--
-- Creation: Nov 03, 2019 at 04:07 AM
--

DROP TABLE IF EXISTS `intern_ability`;
CREATE TABLE `intern_ability` (
  `intern_id` int(11) NOT NULL,
  `ability_id` int(11) NOT NULL,
  `rate` varchar(10) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `intern_ability`:
--   `intern_id`
--       `intern_profile` -> `id`
--   `ability_id`
--       `ability_dictionary` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `intern_profile`
--
-- Creation: Nov 03, 2019 at 04:01 AM
--

DROP TABLE IF EXISTS `intern_profile`;
CREATE TABLE `intern_profile` (
  `id` int(11) NOT NULL,
  `code` varchar(15) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `first_name` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `last_name` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `join_date` date NOT NULL,
  `class_name` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `intern_profile`:
--

-- --------------------------------------------------------

--
-- Table structure for table `organization_profile`
--
-- Creation: Nov 03, 2019 at 04:10 AM
--

DROP TABLE IF EXISTS `organization_profile`;
CREATE TABLE `organization_profile` (
  `id` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `name_organization` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `employee_count` int(11) NOT NULL,
  `gross_revenue` int(11) NOT NULL,
  `address` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `contact` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `tax_number` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `password` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `organization_profile`:
--

-- --------------------------------------------------------

--
-- Table structure for table `register`
--
-- Creation: Nov 03, 2019 at 04:18 AM
--

DROP TABLE IF EXISTS `register`;
CREATE TABLE `register` (
  `id` int(11) NOT NULL,
  `intern_id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `date_created` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `register`:
--   `intern_id`
--       `intern_profile` -> `id`
--   `request_id`
--       `request` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `request`
--
-- Creation: Nov 03, 2019 at 04:15 AM
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `position` varchar(11) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `date_created` date NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `request`:
--   `organization_id`
--       `organization_profile` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `request_ability`
--
-- Creation: Nov 03, 2019 at 04:36 AM
--

DROP TABLE IF EXISTS `request_ability`;
CREATE TABLE `request_ability` (
  `request_id` int(11) NOT NULL,
  `ability_id` int(11) NOT NULL,
  `ability_required` int(11) NOT NULL,
  `description` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `request_ability`:
--   `request_id`
--       `request` -> `id`
--   `ability_id`
--       `ability_dictionary` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `request_assignment`
--
-- Creation: Nov 03, 2019 at 04:23 AM
--

DROP TABLE IF EXISTS `request_assignment`;
CREATE TABLE `request_assignment` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `intern_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` int(11) NOT NULL,
  `date_created` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `request_assignment`:
--   `request_id`
--       `request` -> `id`
--   `intern_id`
--       `intern_profile` -> `id`
--   `status`
--       `status` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `status`
--
-- Creation: Nov 03, 2019 at 04:23 AM
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `status`:
--

-- --------------------------------------------------------

--
-- Table structure for table `teacher_profile`
--
-- Creation: Nov 03, 2019 at 04:21 AM
--

DROP TABLE IF EXISTS `teacher_profile`;
CREATE TABLE `teacher_profile` (
  `id` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `contact` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- RELATIONSHIPS FOR TABLE `teacher_profile`:
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ability_dictionary`
--
ALTER TABLE `ability_dictionary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `ability_type`
--
ALTER TABLE `ability_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `intern_ability`
--
ALTER TABLE `intern_ability`
  ADD KEY `intern_id` (`intern_id`),
  ADD KEY `ability_id` (`ability_id`);

--
-- Indexes for table `intern_profile`
--
ALTER TABLE `intern_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organization_profile`
--
ALTER TABLE `organization_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`id`),
  ADD KEY `intern_id` (`intern_id`),
  ADD KEY `request_id` (`request_id`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `request_ability`
--
ALTER TABLE `request_ability`
  ADD KEY `request_id` (`request_id`),
  ADD KEY `ability_id` (`ability_id`);

--
-- Indexes for table `request_assignment`
--
ALTER TABLE `request_assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `intern_id` (`intern_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacher_profile`
--
ALTER TABLE `teacher_profile`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ability_dictionary`
--
ALTER TABLE `ability_dictionary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ability_type`
--
ALTER TABLE `ability_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `intern_profile`
--
ALTER TABLE `intern_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `organization_profile`
--
ALTER TABLE `organization_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `register`
--
ALTER TABLE `register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_assignment`
--
ALTER TABLE `request_assignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_profile`
--
ALTER TABLE `teacher_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ability_dictionary`
--
ALTER TABLE `ability_dictionary`
  ADD CONSTRAINT `ability_dictionary_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `ability_type` (`id`);

--
-- Constraints for table `intern_ability`
--
ALTER TABLE `intern_ability`
  ADD CONSTRAINT `intern_ability_ibfk_1` FOREIGN KEY (`intern_id`) REFERENCES `intern_profile` (`id`),
  ADD CONSTRAINT `intern_ability_ibfk_2` FOREIGN KEY (`ability_id`) REFERENCES `ability_dictionary` (`id`);

--
-- Constraints for table `register`
--
ALTER TABLE `register`
  ADD CONSTRAINT `register_ibfk_1` FOREIGN KEY (`intern_id`) REFERENCES `intern_profile` (`id`),
  ADD CONSTRAINT `register_ibfk_2` FOREIGN KEY (`request_id`) REFERENCES `request` (`id`);

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization_profile` (`id`);

--
-- Constraints for table `request_ability`
--
ALTER TABLE `request_ability`
  ADD CONSTRAINT `request_ability_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `request` (`id`),
  ADD CONSTRAINT `request_ability_ibfk_2` FOREIGN KEY (`ability_id`) REFERENCES `ability_dictionary` (`id`);

--
-- Constraints for table `request_assignment`
--
ALTER TABLE `request_assignment`
  ADD CONSTRAINT `request_assignment_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `request` (`id`),
  ADD CONSTRAINT `request_assignment_ibfk_2` FOREIGN KEY (`intern_id`) REFERENCES `intern_profile` (`id`),
  ADD CONSTRAINT `request_assignment_ibfk_3` FOREIGN KEY (`status`) REFERENCES `status` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
