-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 30, 2024 at 03:56 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `empdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`) VALUES
(1, 'AD'),
(2, 'TAURUS'),
(3, 'AC'),
(4, 'CM'),
(5, 'CO'),
(6, 'CS'),
(7, 'DD'),
(8, 'EMP'),
(9, 'HR'),
(10, 'IT'),
(11, 'MD'),
(12, 'MK'),
(13, 'PU'),
(14, 'QS');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `fname` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `lname` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `department_id` int NOT NULL,
  `code_emp` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `fname`, `lname`, `department_id`, `code_emp`, `phone`) VALUES
(1, 'Pimuk', 'Artharnnarong', 10, 'EMP-123', '0989952134');

-- --------------------------------------------------------

--
-- Table structure for table `equipments`
--

CREATE TABLE `equipments` (
  `id` int NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `location_id` int NOT NULL,
  `user_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `store_id` int NOT NULL,
  `asset_number` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `document_number` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `image` text COLLATE utf8mb4_general_ci,
  `date_in` date NOT NULL,
  `date_out` date DEFAULT NULL,
  `status` int DEFAULT NULL,
  `note` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipments`
--

INSERT INTO `equipments` (`id`, `name`, `location_id`, `user_id`, `employee_id`, `store_id`, `asset_number`, `document_number`, `price`, `quantity`, `image`, `date_in`, `date_out`, `status`, `note`) VALUES
(902, 'Wood', 1, 53, 1, 1, '123', '123', 1990, 22, '123', '2024-03-11', '2024-03-19', 2, ''),
(903, 'grsg', 1, 56, 1, 2, 'gsgs', 'fesf', 22, 22, NULL, '2024-03-25', NULL, 1, 'fef');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `action` text COLLATE utf8mb4_general_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(256) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `address`) VALUES
(1, 'EMP', '');

-- --------------------------------------------------------

--
-- Table structure for table `notebooks`
--

CREATE TABLE `notebooks` (
  `id` int NOT NULL,
  `brand` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `cpu` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `gpu` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `ram` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `storage` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `os` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `asset_number` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `license_window` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `store_id` int NOT NULL,
  `date_in` date NOT NULL,
  `date_out` date DEFAULT NULL,
  `status` int DEFAULT NULL,
  `note` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notebooks`
--

INSERT INTO `notebooks` (`id`, `brand`, `model`, `cpu`, `gpu`, `ram`, `storage`, `os`, `asset_number`, `license_window`, `user_id`, `employee_id`, `store_id`, `date_in`, `date_out`, `status`, `note`) VALUES
(28, 'Asus', 'Tuf f15', 'i5 11400h', 'RTX 3050 ti', '16', '256', 'Windows 11', 'EMP-123456789', '123', 53, 1, 2, '2024-03-11', '2024-03-29', 0, ''),
(30, '11', '11', '11', '11', '123', '123', '123', '123', '123', 53, 1, 2, '2024-03-14', '2024-03-05', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `department_id` int NOT NULL,
  `location_id` int NOT NULL,
  `user_id` int NOT NULL,
  `date` date NOT NULL,
  `date_use` date NOT NULL,
  `note` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'Manager'),
(3, 'Member');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` int NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(256) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `name`, `address`) VALUES
(1, 'JIB', ''),
(2, 'Advice', ''),
(4, 'I Have CPU', '139 ถ. รามอินทรา แขวงอนุสาวรีย์ เขตบางเขน กรุงเทพมหานคร 10220');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `fname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `lname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `department_id` int DEFAULT NULL,
  `role_id` int NOT NULL,
  `email` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `date_in` date DEFAULT NULL,
  `image` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `department_id`, `role_id`, `email`, `password`, `phone`, `date_in`, `image`) VALUES
(53, 'Pimuk', 'Artharnnarong', 14, 1, 'pimuk.a64@rsu.ac.th', '$2b$10$a8iGEKDpdtafJqe4/SFlUelMxLsNQK7NEQzKSwZH1e3EntLIk9VB2', '0989952134', '2024-03-11', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr7pAxGJMqyvP2MHxdLmhp31yIe-Effp1oDRZe_aeJpIbhzuCl_h1h3iQ676jlluaYZOA&usqp=CAU'),
(56, 'พิมุกต์', 'อาจหาญณรงค์', 10, 1, 'pimukchall@hotmail.com', '$2b$10$smatct2wY9NCdXSBu78qwOPq67qbmeeHSaqaKLvuU.CVHFJ2aA/Ai', '0989952134', '2024-03-14', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr7pAxGJMqyvP2MHxdLmhp31yIe-Effp1oDRZe_aeJpIbhzuCl_h1h3iQ676jlluaYZOA&usqp=CAU');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_emp` (`code_emp`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `equipments`
--
ALTER TABLE `equipments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asset_number` (`asset_number`),
  ADD UNIQUE KEY `asset_number_2` (`asset_number`),
  ADD KEY `id_location` (`location_id`),
  ADD KEY `id` (`user_id`),
  ADD KEY `id_store` (`store_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notebooks`
--
ALTER TABLE `notebooks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`user_id`),
  ADD KEY `id_store` (`store_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_department` (`department_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `equipments`
--
ALTER TABLE `equipments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=904;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notebooks`
--
ALTER TABLE `notebooks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Constraints for table `equipments`
--
ALTER TABLE `equipments`
  ADD CONSTRAINT `equipments_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `equipments_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `equipments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `equipments_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `notebooks`
--
ALTER TABLE `notebooks`
  ADD CONSTRAINT `notebooks_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `notebooks_ibfk_5` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `notebooks_ibfk_6` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
