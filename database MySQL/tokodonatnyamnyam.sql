-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2023 at 06:10 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tokodonatnyamnyam`
--

-- --------------------------------------------------------

--
-- Table structure for table `mscustomers`
--

CREATE TABLE `mscustomers` (
  `KdCustomer` char(7) NOT NULL CHECK (char_length(`KdCustomer`) <= 7),
  `KdMember` char(5) NOT NULL CHECK (char_length(`KdMember`) = 5),
  `NamaCustomer` varchar(25) DEFAULT NULL,
  `AlamatCustomer` varchar(25) DEFAULT NULL,
  `TelpCustomer` char(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mscustomers`
--

INSERT INTO `mscustomers` (`KdCustomer`, `KdMember`, `NamaCustomer`, `AlamatCustomer`, `TelpCustomer`) VALUES
('CU001', 'SR001', 'Nana Bone', 'Jln R no 3', '7134529'),
('CU002', 'SR001', 'Weve Hay', 'Jln S no 8', '4640426'),
('CU003', 'NON02', 'Vela vena', 'Jln T no 16', '8144327'),
('CU004', 'GD003', 'Tew Toet', 'Jln U no 9', '7573888'),
('CU005', 'SR001', 'Ncim Ndoet', 'Jln V no 10', '7112042');

-- --------------------------------------------------------

--
-- Table structure for table `msdonat`
--

CREATE TABLE `msdonat` (
  `KdDonat` char(7) NOT NULL CHECK (char_length(`KdDonat`) <= 7),
  `NamaDonat` char(25) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL CHECK (`Stok` > 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `msdonat`
--

INSERT INTO `msdonat` (`KdDonat`, `NamaDonat`, `Harga`, `Stok`) VALUES
('DO001', 'Sugar', '2000.00', 10),
('DO002', 'VanillaRiver', '2000.00', 8),
('DO003', 'Strawberry', '2500.00', 6),
('DO004', 'Blueberry', '2500.00', 7),
('DO005', 'Sausage', '3000.00', 7),
('DO006', 'CheeseMania', '3000.00', 15);

-- --------------------------------------------------------

--
-- Table structure for table `msmember`
--

CREATE TABLE `msmember` (
  `KdMember` char(5) NOT NULL CHECK (char_length(`KdMember`) = 5),
  `Statuts` char(20) DEFAULT NULL,
  `Diskon` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `msmember`
--

INSERT INTO `msmember` (`KdMember`, `Statuts`, `Diskon`) VALUES
('GD003', 'Gold', NULL),
('NON02', 'NonMember', NULL),
('SR001', 'Silver', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mspegawai`
--

CREATE TABLE `mspegawai` (
  `KdPegawai` char(5) NOT NULL CHECK (char_length(`KdPegawai`) = 5),
  `NamaPegawai` varchar(25) DEFAULT NULL,
  `AlamatPegawai` varchar(25) DEFAULT NULL,
  `Shift` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mspegawai`
--

INSERT INTO `mspegawai` (`KdPegawai`, `NamaPegawai`, `AlamatPegawai`, `Shift`) VALUES
('ME001', 'Pa Sum', 'Jln N no 8', 'Pagi'),
('ME002', 'Bu Sum', 'Jln Y no 4', 'Malam'),
('PE001', 'Kawe Acong', 'Jln T no 1', 'Pagi'),
('PE002', 'Almond', 'Jln O no 4', 'Malam'),
('PE003', 'Mi Kua', 'Jln N no 6', 'Pagi');

-- --------------------------------------------------------

--
-- Table structure for table `trans_pembelian`
--

CREATE TABLE `trans_pembelian` (
  `KdPegawai` char(5) NOT NULL CHECK (char_length(`KdPegawai`) = 5),
  `KdDonat` char(7) NOT NULL CHECK (char_length(`KdDonat`) <= 7),
  `KdCustomer` char(7) NOT NULL CHECK (char_length(`KdCustomer`) <= 7),
  `Qty` int(11) DEFAULT NULL,
  `tglBeli` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trans_pembelian`
--

INSERT INTO `trans_pembelian` (`KdPegawai`, `KdDonat`, `KdCustomer`, `Qty`, `tglBeli`) VALUES
('PE003', 'DO006', 'CU002', 5, '0000-00-00 00:00:00'),
('PE001', 'DO002', 'CU001', 10, '0000-00-00 00:00:00'),
('ME002', 'DO006', 'CU002', 7, '0000-00-00 00:00:00'),
('PE003', 'DO006', 'CU004', 8, '0000-00-00 00:00:00'),
('PE001', 'DO005', 'CU002', 5, '0000-00-00 00:00:00'),
('ME001', 'DO001', 'CU003', 4, '0000-00-00 00:00:00'),
('ME002', 'DO004', 'CU004', 5, '0000-00-00 00:00:00'),
('PE003', 'DO003', 'CU005', 6, '0000-00-00 00:00:00'),
('ME002', 'DO004', 'CU003', 8, '0000-00-00 00:00:00'),
('ME002', 'DO002', 'CU004', 10, '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mscustomers`
--
ALTER TABLE `mscustomers`
  ADD PRIMARY KEY (`KdCustomer`),
  ADD KEY `KdMember` (`KdMember`);

--
-- Indexes for table `msdonat`
--
ALTER TABLE `msdonat`
  ADD PRIMARY KEY (`KdDonat`);

--
-- Indexes for table `msmember`
--
ALTER TABLE `msmember`
  ADD PRIMARY KEY (`KdMember`);

--
-- Indexes for table `mspegawai`
--
ALTER TABLE `mspegawai`
  ADD PRIMARY KEY (`KdPegawai`);

--
-- Indexes for table `trans_pembelian`
--
ALTER TABLE `trans_pembelian`
  ADD KEY `KdPegawai` (`KdPegawai`),
  ADD KEY `KdDonat` (`KdDonat`),
  ADD KEY `KdCustomer` (`KdCustomer`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mscustomers`
--
ALTER TABLE `mscustomers`
  ADD CONSTRAINT `mscustomers_ibfk_1` FOREIGN KEY (`KdMember`) REFERENCES `msmember` (`KdMember`);

--
-- Constraints for table `trans_pembelian`
--
ALTER TABLE `trans_pembelian`
  ADD CONSTRAINT `trans_pembelian_ibfk_1` FOREIGN KEY (`KdPegawai`) REFERENCES `mspegawai` (`KdPegawai`),
  ADD CONSTRAINT `trans_pembelian_ibfk_2` FOREIGN KEY (`KdDonat`) REFERENCES `msdonat` (`KdDonat`),
  ADD CONSTRAINT `trans_pembelian_ibfk_3` FOREIGN KEY (`KdCustomer`) REFERENCES `mscustomers` (`KdCustomer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
