-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2019 at 06:33 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `egroup`
--

-- --------------------------------------------------------

--
-- Table structure for table `functions`
--

CREATE TABLE `functions` (
  `id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `module_id` int(10) DEFAULT NULL,
  `module_name` varchar(20) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `group_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `functions`
--

INSERT INTO `functions` (`id`, `name`, `module_id`, `module_name`, `user_id`, `group_id`) VALUES
(1, 'funkcija 1', 1, 'Modulis 1', NULL, NULL),
(2, 'funkcija 2', 3, 'Modulis 1', NULL, NULL),
(3, 'funkcija 3', 4, 'Modulis 2', 3, NULL),
(4, 'funkcija 4', 2, 'Modulis 2', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `function_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `user_id`, `module_id`, `function_id`) VALUES
(1, 'grupe 1', 1, 1, NULL),
(2, 'grupe 2', 2, NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `functions_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `group_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `name`, `functions_id`, `user_id`, `group_id`) VALUES
(1, 'Modulis 1', 1, NULL, 1),
(2, 'Modulis 2', 4, 4, NULL),
(3, 'Modulis 1', 2, NULL, NULL),
(4, 'Modulis 2', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `nickname` varchar(10) NOT NULL,
  `groups_id` int(10) DEFAULT NULL,
  `modules_id` int(10) DEFAULT NULL,
  `functions_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nickname`, `groups_id`, `modules_id`, `functions_id`) VALUES
(1, 'tomjas', 1, NULL, NULL),
(2, 'petlauk', 2, NULL, NULL),
(3, 'tomjan', NULL, NULL, 3),
(4, 'petluk', NULL, 2, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `functions`
--
ALTER TABLE `functions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `functions_ibfk_2` (`user_id`),
  ADD KEY `functions_ibfk_3` (`group_id`),
  ADD KEY `functions_ibfk_4` (`module_id`,`module_name`) USING BTREE;

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `module_id` (`module_id`),
  ADD KEY `function_id` (`function_id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`,`name`) USING BTREE,
  ADD KEY `modules_ibfk_1` (`functions_id`),
  ADD KEY `modules_ibfk_2` (`user_id`),
  ADD KEY `modules_ibfk_3` (`group_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nickname` (`nickname`),
  ADD KEY `users_ibfk_1` (`groups_id`),
  ADD KEY `users_ibfk_3` (`functions_id`),
  ADD KEY `users_ibfk_2` (`modules_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `functions`
--
ALTER TABLE `functions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `functions`
--
ALTER TABLE `functions`
  ADD CONSTRAINT `functions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `functions_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `functions_ibfk_4` FOREIGN KEY (`module_id`,`module_name`) REFERENCES `modules` (`id`, `name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `groups_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `groups_ibfk_3` FOREIGN KEY (`function_id`) REFERENCES `functions` (`id`);

--
-- Constraints for table `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `modules_ibfk_1` FOREIGN KEY (`functions_id`) REFERENCES `functions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modules_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modules_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`modules_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`functions_id`) REFERENCES `functions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
