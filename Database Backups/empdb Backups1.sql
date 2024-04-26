-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2024 at 09:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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
  `id` int(255) NOT NULL,
  `name` varchar(256) NOT NULL
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
  `id` int(255) NOT NULL,
  `fname` varchar(256) NOT NULL,
  `lname` varchar(256) NOT NULL,
  `department_id` int(255) NOT NULL,
  `code_emp` varchar(256) NOT NULL,
  `phone` varchar(10) NOT NULL
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
  `id` int(255) NOT NULL,
  `name` varchar(256) NOT NULL,
  `location_id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `employee_id` int(255) NOT NULL,
  `store_id` int(255) NOT NULL,
  `asset_number` varchar(256) NOT NULL,
  `document_number` varchar(256) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(255) NOT NULL,
  `image` text DEFAULT NULL,
  `date_in` date NOT NULL,
  `date_out` date DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `note` text DEFAULT NULL
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
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `action` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(255) NOT NULL,
  `name` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL
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
  `id` int(255) NOT NULL,
  `brand` varchar(256) NOT NULL,
  `model` varchar(256) NOT NULL,
  `cpu` varchar(256) NOT NULL,
  `gpu` varchar(256) NOT NULL,
  `ram` varchar(256) NOT NULL,
  `storage` varchar(256) NOT NULL,
  `os` varchar(256) NOT NULL,
  `asset_number` varchar(256) NOT NULL,
  `license_window` varchar(256) NOT NULL,
  `user_id` int(255) NOT NULL,
  `employee_id` int(255) NOT NULL,
  `store_id` int(255) NOT NULL,
  `date_in` date NOT NULL,
  `date_out` date DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `note` text DEFAULT NULL
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
  `id` int(255) NOT NULL,
  `name` varchar(256) NOT NULL,
  `department_id` int(255) NOT NULL,
  `location_id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `date` date NOT NULL,
  `date_use` date NOT NULL,
  `note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(255) NOT NULL,
  `name` varchar(256) NOT NULL
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
  `id` int(255) NOT NULL,
  `name` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL
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
  `id` int(255) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `department_id` int(255) DEFAULT NULL,
  `role_id` int(255) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `date_in` date DEFAULT NULL,
  `image` text DEFAULT NULL
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
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `equipments`
--
ALTER TABLE `equipments`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=904;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notebooks`
--
ALTER TABLE `notebooks`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

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
