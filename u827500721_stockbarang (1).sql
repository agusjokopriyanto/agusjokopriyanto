-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Waktu pembuatan: 31 Okt 2023 pada 02.13
-- Versi server: 10.5.19-MariaDB-cll-lve
-- Versi PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u827500721_stockbarang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(20) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `stok` int(11) NOT NULL,
  `satuan_kd` char(20) NOT NULL,
  `kategori_kd` char(20) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `stok`, `satuan_kd`, `kategori_kd`, `create_at`) VALUES
('AAA001', 'Panci', 6, 'PCS', 'AD', '2023-10-13 23:29:52'),
('AAA002', 'Wajan', 6, 'PCS', 'AD', '2023-10-13 23:29:52'),
('GKA0100', 'pulpen ', 8, 'PCS', 'Fufit', '2023-10-13 06:56:57'),
('GKA01243', 'laptop', 0, 'PCS', 'IT', '2023-10-02 08:58:01'),
('GKA0200', 'hp', 0, 'PCS', 'Fufit', '2023-10-13 06:56:57'),
('GKA0300', 'kalkulataor', 0, 'PCS', 'Fufit', '2023-10-13 06:56:57'),
('GKA0353', 'Tusuk Sate Stainless', 0, 'KG', 'Co', '2023-09-27 08:04:01'),
('GKA0355', 'Hot Warmer', 0, 'KG', 'Co', '2023-09-27 08:04:01'),
('GKA0380', 'gunting', 11, 'PCS', 'Fufit', '2023-10-13 06:56:57'),
('GKA0389', 'kulkas', 10, 'PCS', 'Fufit', '2023-10-13 06:56:57'),
('GKA0390', 'gelas ', 10, 'PCS', 'Fufit', '2023-10-13 06:56:57'),
('GKB0029', 'Box Container 70L, Shinpo', 0, 'PCS', 'Fufit', '2023-09-27 08:04:01'),
('GKBS004', '[EQPT00037629] Display Chiller Expo-416P ( 338 Ltr ), Gea, 1 Pcs', 0, 'PCS', 'Ge', '2023-09-27 08:04:01'),
('GKC0269', '[ITEQ00058598] CCTV Camera, Hikvision, 1 Pcs', 98, 'PCS', 'Fufix', '2023-09-27 08:04:01'),
('GKCA041', '[OFEQ00064534] Kunci Inggris 12 Inch, Tekiro, 1 pcs', 0, 'PCS', 'In', '2023-09-27 08:04:01'),
('GKD0280', '[OFEQ00056234] Printer Thermal, 1 pcs', 121, 'PCS', 'Ksup', '2023-09-27 08:04:01'),
('GKG0339', '[OFFC00065618] Galon Aqua / Vit / Dll', 0, 'KG', 'Ofsup', '2023-09-27 08:04:01'),
('GKHB018', 'AC 1 PK  Panasonic', 33, 'UNIT', 'IT', '2023-09-27 08:04:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_broken`
--

CREATE TABLE `barang_broken` (
  `no_po` varchar(13) NOT NULL,
  `tanggal_` date NOT NULL,
  `status` enum('1','0') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_broken_d`
--

CREATE TABLE `barang_broken_d` (
  `d_po` char(13) NOT NULL,
  `barang_id` char(10) NOT NULL,
  `qty_bkn` float NOT NULL,
  `harga_j` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `barang_broken_d`
--

INSERT INTO `barang_broken_d` (`d_po`, `barang_id`, `qty_bkn`, `harga_j`) VALUES
('BK19-0001', 'AAA002', 1, 250000);

--
-- Trigger `barang_broken_d`
--
DELIMITER $$
CREATE TRIGGER `delete_stokbrg_bkn` AFTER DELETE ON `barang_broken_d` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + OLD.qty_bkn WHERE `barang`.`id_barang` = OLD.barang_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_stokbrg_bkn` BEFORE INSERT ON `barang_broken_d` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.qty_bkn WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_west`
--

CREATE TABLE `barang_west` (
  `id_barang_west` char(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_west` float NOT NULL,
  `tanggal_west` date NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `brg_masuk`
--

CREATE TABLE `brg_masuk` (
  `no_po` varchar(13) NOT NULL,
  `tanggal_` date NOT NULL,
  `tanggal_bm` date DEFAULT NULL,
  `supplier_id` int(11) NOT NULL,
  `status` enum('1','0') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `brg_masuk`
--

INSERT INTO `brg_masuk` (`no_po`, `tanggal_`, `tanggal_bm`, `supplier_id`, `status`) VALUES
('PO-0001', '2023-09-30', '2023-09-30', 1, '0'),
('PO-0002', '2023-09-30', '2023-09-30', 4, '0'),
('PO-0003', '2023-09-30', '2023-09-30', 5, '0'),
('PO19-0003', '2023-10-13', '2023-10-13', 8, '0'),
('PO19-0004', '2023-10-13', NULL, 22, '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `brg_masuk_d`
--

CREATE TABLE `brg_masuk_d` (
  `id` int(11) NOT NULL,
  `d_po` char(13) NOT NULL,
  `barang_id` char(10) NOT NULL,
  `qty` float NOT NULL,
  `harganet` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `grade` varchar(5) NOT NULL,
  `kd_lokasi` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `brg_masuk_d`
--

INSERT INTO `brg_masuk_d` (`id`, `d_po`, `barang_id`, `qty`, `harganet`, `price`, `harga`, `grade`, `kd_lokasi`) VALUES
(1, 'PO-0001', 'GKA0001', 200, 200000, 10, 180000, 'C', 'RAK1'),
(2, 'PO-0001', 'GKA0002', 200, 200000, 0, 200000, 'C', 'RAK1'),
(3, 'PO-0002', 'GKHB018', 30, 2500000, 10, 2250000, 'B', 'RAK2'),
(4, 'PO-0003', 'GKC0269', 100, 500000, 0, 500000, 'A', 'RAK4'),
(5, 'PO-0003', 'GKD0280', 100, 1500000, 0, 1500000, 'A', 'RAK4'),
(55, 'BK20-0001', 'GKD0280', 1, 0, 0, 0, '12000', ''),
(56, 'PO20-0001', 'GKD0280', 20, 0, 0, 0, 'A', ''),
(57, 'PO20-0001', 'GKHB018', 5, 0, 0, 0, 'B', ''),
(142, 'PO19-0003', 'GKA0389', 20, 1000000, 0, 1000000, 'A', 'RAK02'),
(143, 'PO19-0003', 'GKA0100', 20, 200000, 10, 180000, 'A', 'RAK03'),
(144, 'PO19-0003', 'GKA0390', 20, 300000, 0, 300000, 'A', 'RAK05'),
(145, 'PO19-0003', 'GKA0380', 20, 500000, 3, 485000, 'A', 'RAK06'),
(146, 'PO19-0004', 'AAA001', 6, 0, 0, 0, 'B', ''),
(147, 'PO19-0004', 'AAA002', 7, 0, 0, 0, 'B', '');

--
-- Trigger `brg_masuk_d`
--
DELIMITER $$
CREATE TRIGGER `delete_stokbrg_masuk` AFTER DELETE ON `brg_masuk_d` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - OLD.qty WHERE `barang`.`id_barang` = OLD.barang_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_stokbrg_masuk` BEFORE INSERT ON `brg_masuk_d` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + NEW.qty WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer`
--

CREATE TABLE `customer` (
  `id_cust` int(11) NOT NULL,
  `nama_cust` varchar(200) NOT NULL,
  `no_hp` text NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `jenis_usaha` varchar(200) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `customer`
--

INSERT INTO `customer` (`id_cust`, `nama_cust`, `no_hp`, `alamat`, `jenis_usaha`, `create_at`) VALUES
(1, 'Johan', '088899898989', 'Bekasi', 'Otomotif', '2023-10-05 08:43:00'),
(2, 'Jonatan', '0898989999', 'Jl Belakang2', 'Kuliner', '2023-10-05 08:44:19'),
(3, 'iwan', '56789098', 'jakarta timur', 'usaha bisnis', '2023-10-13 07:25:06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `customer_d`
--

CREATE TABLE `customer_d` (
  `id_` int(11) NOT NULL,
  `nota_cs` char(20) NOT NULL,
  `cs_id` int(11) NOT NULL,
  `cicilan` int(11) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `customer_d`
--

INSERT INTO `customer_d` (`id_`, `nota_cs`, `cs_id`, `cicilan`, `create_at`) VALUES
(1, 'CS19-0001', 2, 300000, '2023-10-06 04:27:50'),
(2, 'CS19-0001', 2, 500000, '2023-10-06 04:34:33'),
(3, 'CS19-0001', 2, 200000, '2023-10-06 06:31:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `kd_kategori` char(20) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `kd_kategori`, `nama_kategori`, `create_at`) VALUES
(1, 'Cl', 'Cleaning Supplies', '2023-09-27 08:02:50'),
(2, 'Co', 'Cold Storage', '2023-09-27 08:02:50'),
(3, 'Fufit', 'Furniture & Fittings', '2023-09-27 08:02:50'),
(4, 'Fufix', 'Furniture & Fixture', '2023-09-27 08:02:50'),
(6, 'In', 'In House', '2023-09-27 08:02:50'),
(7, 'IT', 'IT Equipment', '2023-09-27 08:02:50'),
(8, 'Ksup', 'Kitchen Supplies', '2023-09-27 08:02:50'),
(9, 'Kut', 'Kitchen Utensils', '2023-09-27 08:02:50'),
(10, 'Ofeq', 'Office Equipment', '2023-09-27 08:02:50'),
(37, 'AD', 'Alat Dapur', '2023-10-13 23:25:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `no_notap` varchar(13) NOT NULL,
  `tanggal_` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `status` enum('Approve','Not Approve') NOT NULL DEFAULT 'Not Approve',
  `subtotal` int(11) NOT NULL,
  `nego` int(11) NOT NULL,
  `voucher` int(11) NOT NULL,
  `payment` enum('DANA','OVO','CASH','TRANSFER','EDC','AKULAKU') NOT NULL,
  `grandtotal` int(11) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `selesai` enum('0','1') NOT NULL DEFAULT '0',
  `cust_id` int(11) NOT NULL,
  `cust_dp` int(11) NOT NULL,
  `kd_cs` int(11) DEFAULT NULL,
  `status_cicil` enum('UTANG','SELESAI') NOT NULL DEFAULT 'UTANG'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`no_notap`, `tanggal_`, `user_id`, `sales_id`, `status`, `subtotal`, `nego`, `voucher`, `payment`, `grandtotal`, `create_at`, `selesai`, `cust_id`, `cust_dp`, `kd_cs`, `status_cicil`) VALUES
('CS19-0001', '2023-10-06', 19, 5, 'Approve', 7000000, 6900000, 10021, 'TRANSFER', 6885000, '2023-10-06 01:24:25', '1', 2, 1000000, 1, 'UTANG'),
('CS19-0002', '2023-10-13', 19, 4, 'Approve', 580000, 500000, 0, 'OVO', 500000, '2023-10-13 07:35:27', '1', 3, 20000, 1, 'UTANG'),
('P19-0001', '2023-10-02', 19, 2, 'Approve', 1500000, 0, 0, 'OVO', 1500000, '2023-10-02 01:57:45', '1', 0, 0, 0, 'UTANG'),
('P19-0002', '2023-10-03', 19, 2, 'Approve', 1300000, 1200000, 0, 'CASH', 1200000, '2023-10-03 15:41:33', '1', 0, 0, 0, 'UTANG'),
('P19-0003', '2023-10-03', 19, 5, 'Approve', 1400000, 1300000, 10026, 'CASH', 1260000, '2023-10-03 15:57:14', '1', 0, 0, 0, 'UTANG'),
('P19-0004', '2023-10-03', 19, 7, 'Approve', 3200000, 3000000, 10024, 'CASH', 2970000, '2023-10-03 16:30:58', '1', 0, 0, 0, 'UTANG'),
('P19-0005', '2023-10-13', 19, 11, 'Approve', 550000, 500000, 0, 'OVO', 500000, '2023-10-13 07:30:41', '1', 0, 0, NULL, 'UTANG'),
('P19-0006', '2023-10-13', 19, 1, 'Not Approve', 4000, 0, 0, 'CASH', 4000, '2023-10-14 00:07:30', '0', 0, 0, NULL, 'UTANG'),
('P23-0001', '2023-09-30', 23, 3, 'Approve', 4000000, 0, 0, 'TRANSFER', 4000000, '2023-09-30 03:44:31', '1', 0, 0, 0, 'UTANG'),
('P23-0002', '2023-09-30', 23, 3, 'Approve', 6000000, 0, 0, 'TRANSFER', 6000000, '2023-09-30 04:03:25', '1', 0, 0, 0, 'UTANG'),
('P23-0003', '2023-10-03', 19, 2, 'Approve', 1360000, 1350000, 0, 'CASH', 1350000, '2023-10-03 16:09:40', '1', 0, 0, 0, 'UTANG'),
('P24-0001', '2023-09-30', 24, 9, 'Approve', 6000000, 5800000, 0, 'CASH', 5800000, '2023-09-30 03:46:22', '1', 0, 0, 0, 'UTANG'),
('P24-0002', '2023-10-02', 24, 9, 'Approve', 6600000, 0, 0, 'TRANSFER', 6600000, '2023-10-01 09:24:25', '1', 0, 0, 0, 'UTANG');

--
-- Trigger `penjualan`
--
DELIMITER $$
CREATE TRIGGER `update_status_voucher` BEFORE INSERT ON `penjualan` FOR EACH ROW UPDATE `voucher` SET `voucher`.`status` = '1' WHERE `voucher`.`kd_voucher` = NEW.voucher
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan_d`
--

CREATE TABLE `penjualan_d` (
  `d_pj` char(13) NOT NULL,
  `barang_id` char(10) NOT NULL,
  `harga` int(11) NOT NULL,
  `qty` float NOT NULL,
  `status` enum('OK','RETUR','CANCEL') NOT NULL DEFAULT 'OK'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `penjualan_d`
--

INSERT INTO `penjualan_d` (`d_pj`, `barang_id`, `harga`, `qty`, `status`) VALUES
('P23-0002', 'GKHB018', 3000000, 2, 'OK'),
('P24-0002', 'GKC0269', 600000, 2, 'OK'),
('P24-0002', 'GKA0002', 200000, 5, 'OK'),
('P19-0002', 'GKA0001', 200000, 1, 'OK'),
('P19-0002', 'GKA0001', 300000, 1, 'OK'),
('P19-0002', 'GKA0002', 500000, 1, 'OK'),
('P19-0003', 'GKA0001', 200000, 1, 'OK'),
('P19-0003', 'GKA01235', 1000000, 1, 'OK'),
('P23-0003', 'GKA01236', 500000, 2, 'OK'),
('P23-0001', 'GKA0002', 2000000, 1, 'OK'),
('P19-0004', 'GKA0001', 200000, 1, 'OK'),
('P19-0004', 'GKA01236', 2000000, 1, 'OK'),
('P23-0003', 'GKA0002', 180000, 2, 'OK'),
('P19-0002', 'GKA0001', 500000, 2, 'OK'),
('CS19-0001', 'GKA01235', 5200000, 1, 'OK'),
('P19-0005', 'GKA0389', 500000, 1, 'OK'),
('P19-0006', 'GKA0100', 2000, 2, 'OK');

--
-- Trigger `penjualan_d`
--
DELIMITER $$
CREATE TRIGGER `delete_stokbrg_keluar` AFTER DELETE ON `penjualan_d` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + OLD.qty WHERE `barang`.`id_barang` = OLD.barang_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_stokbrg_keluar` BEFORE INSERT ON `penjualan_d` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.qty WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `po_invoice`
--

CREATE TABLE `po_invoice` (
  `no_po_inv` varchar(13) NOT NULL,
  `kategori` varchar(10) NOT NULL,
  `tanggal_` date NOT NULL,
  `tanggal_tempo` date NOT NULL,
  `data` text NOT NULL,
  `subtotal` float NOT NULL,
  `pajak` float NOT NULL,
  `total` float NOT NULL,
  `pajak_inc` tinytext NOT NULL,
  `jumlah_tagihan` tinytext NOT NULL,
  `status` enum('1','0') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `po_invoice_d`
--

CREATE TABLE `po_invoice_d` (
  `d_po_inv` char(13) NOT NULL,
  `namabarang` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL,
  `qty` float NOT NULL,
  `harga_d` float NOT NULL,
  `diskon` float NOT NULL,
  `pajak_d` tinytext NOT NULL,
  `jumlah_d` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `purchase_order`
--

CREATE TABLE `purchase_order` (
  `no_po` varchar(13) NOT NULL,
  `tanggal_` date NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `status` enum('1','0') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `purchase_order`
--

INSERT INTO `purchase_order` (`no_po`, `tanggal_`, `supplier_id`, `status`) VALUES
('PO-0001', '2023-09-30', 1, '0'),
('PO-0002', '2023-09-30', 4, '0'),
('PO-0003', '2023-09-30', 5, '0'),
('PO19-0003', '2023-10-13', 8, '0'),
('PO19-0004', '2023-10-13', 22, '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `purchase_order_d`
--

CREATE TABLE `purchase_order_d` (
  `d_po` char(13) NOT NULL,
  `barang_id` char(10) NOT NULL,
  `qty` float NOT NULL,
  `grade` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `purchase_order_d`
--

INSERT INTO `purchase_order_d` (`d_po`, `barang_id`, `qty`, `grade`) VALUES
('PO-0001', 'GKA0001', 200, 'C'),
('PO-0001', 'GKA0002', 200, 'C'),
('PO-0002', 'GKHB018', 30, 'B'),
('PO-0003', 'GKD0280', 100, 'A'),
('PO-0003', 'GKC0269', 100, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('786987687', 'GKA32432', 12, 'A'),
('7658765564', 'GKA32433', 12, 'A'),
('6547658769', 'GKA32434', 12, 'A'),
('564535879856', 'GKA32435', 12, 'A'),
('347567564', 'GKA32436', 12, 'A'),
('BK20-0001', 'GKD0280', 1, '12000'),
('PO20-0001', 'GKD0280', 20, 'A'),
('PO20-0001', 'GKHB018', 5, 'B'),
('PO12345', 'pisau', 5, 'A'),
('PO12346', 'spidol', 5, 'A'),
('PO12347', 'tv', 5, 'A'),
('PO12348', 'kulkas', 5, 'A'),
('PO12345', '1111111111', 5, 'A'),
('PO12345', '2222222222', 5, 'A'),
('PO12345', '333333333', 5, 'A'),
('PO12345', '4444444444', 5, 'A'),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('PO12345', 'GKA0389', 20, 'A'),
('PO12345', 'GKA0380', 20, 'A'),
('PO12345', 'GKA0390', 20, 'A'),
('PO12345', 'GKA0100', 20, 'A'),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('PO12345', 'GKA0389', 20, 'A'),
('PO12345', 'GKA0380', 20, 'A'),
('PO12345', 'GKA0390', 20, 'A'),
('PO12345', 'GKA0100', 20, 'A'),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('PO12345', 'GKA0389', 20, 'A'),
('PO12345', 'GKA0380', 20, 'A'),
('PO12345', 'GKA0390', 20, 'A'),
('PO12345', 'GKA0100', 20, 'A'),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('PO12345', 'GKA0389', 20, 'A'),
('PO12345', 'GKA0380', 20, 'A'),
('PO12345', 'GKA0390', 20, 'A'),
('PO12345', 'GKA0100', 20, 'A'),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('PO19-0003', 'GKA0389', 20, 'A'),
('PO19-0003', 'GKA0380', 20, 'A'),
('PO19-0003', 'GKA0390', 20, 'A'),
('PO19-0003', 'GKA0100', 20, 'A'),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('', '', 0, ''),
('PO19-0004', 'AAA001', 6, 'B'),
('PO19-0004', 'AAA002', 7, 'B');

-- --------------------------------------------------------

--
-- Struktur dari tabel `retur`
--

CREATE TABLE `retur` (
  `d_pj` char(13) NOT NULL,
  `barang_id` char(10) NOT NULL,
  `qty` float NOT NULL,
  `status` enum('RETUR','CANCEL') NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `retur`
--

INSERT INTO `retur` (`d_pj`, `barang_id`, `qty`, `status`, `create_at`) VALUES
('P24-0002', 'GKD0280', 1, 'RETUR', '2023-10-01 14:00:53'),
('P24-0001', 'GKHB018', 2, 'RETUR', '2023-10-03 16:02:39'),
('P23-0001', 'GKA0001', 20, 'RETUR', '2023-10-03 16:11:55'),
('P19-0001', 'GKA0002', 20, 'RETUR', '2023-10-03 16:14:17'),
('P23-0003', 'GKA0002', 2, 'RETUR', '2023-10-04 01:06:26'),
('P23-0003', 'GKA0002', 2, 'RETUR', '2023-10-04 01:10:02'),
('P23-0003', 'GKA0002', 2, 'RETUR', '2023-10-04 01:12:23'),
('P23-0003', 'GKA0002', 2, 'RETUR', '2023-10-04 01:20:41'),
('P19-0001', 'GKA0001', 1, 'RETUR', '2023-10-05 02:48:04'),
('P19-0002', 'GKA01235', 1, 'RETUR', '2023-10-05 02:48:37'),
('CS19-0002', 'GKA0389', 1, 'RETUR', '2023-10-13 07:41:08'),
('CS19-0002', 'GKA0380', 2, 'RETUR', '2023-10-13 07:41:26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sales`
--

CREATE TABLE `sales` (
  `id_sales` int(11) NOT NULL,
  `kd_sales` char(20) NOT NULL,
  `nama_sales` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `sales`
--

INSERT INTO `sales` (`id_sales`, `kd_sales`, `nama_sales`, `created_at`) VALUES
(1, '111111', 'Ayu', '2023-09-29 01:29:39'),
(2, '111112', 'Putri', '2023-09-29 01:29:39'),
(3, '111113', 'Hana', '2023-09-29 01:29:39'),
(4, '111114', 'Dwi', '2023-09-29 01:29:39'),
(5, '111115', 'Nana', '2023-09-29 01:29:39'),
(6, '111116', 'Tri', '2023-09-29 01:29:39'),
(7, '111117', 'Wulan', '2023-09-29 01:29:39'),
(8, '111118', 'Febri', '2023-09-29 01:29:39'),
(9, '111119', 'Okta', '2023-09-29 01:29:39'),
(10, '111120', 'Novi', '2023-09-29 01:29:39'),
(11, '88888888', 'Eko P', '2023-10-02 06:47:44'),
(17, '211111', 'Wulandari', '2023-10-13 23:14:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `satuan`
--

CREATE TABLE `satuan` (
  `id_satuan` int(11) NOT NULL,
  `kd_satuan` char(20) NOT NULL,
  `nama_satuan` varchar(100) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `satuan`
--

INSERT INTO `satuan` (`id_satuan`, `kd_satuan`, `nama_satuan`, `create_at`) VALUES
(1, 'PCS', 'PCS', '2023-09-27 08:02:40'),
(2, 'UNIT', 'UNIT', '2023-09-27 08:02:40'),
(3, 'KG', 'KG', '2023-09-27 08:02:40'),
(4, 'M', 'METER', '2023-10-02 06:53:51'),
(5, 'CM', 'CENTI METER', '2023-10-02 06:53:51'),
(9, 'MM', 'MILIMETER', '2023-10-13 23:23:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `kd_supplier` char(10) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `kd_supplier`, `nama_supplier`, `no_telp`, `alamat`) VALUES
(1, '11111', 'UD PUTRA WIJAYA', '082122568620', 'Kp. Cirewed RT 003 RW 002 Desa Sukadamai - Cikupa kab. Tangerang Banten'),
(2, '11112', 'RIDHO KARTON PACKING/BOX', '087879124910', 'CILINCING JAKARTA UTARA RT 03 RW 04 NO. 3'),
(3, '11113', 'CV RYO MULTI MAKMUR', '085813527166', 'KALIBARU BARAT NO 23 CILINCING JAKARTA UTARA'),
(4, '11114', 'CV SETIA BERSAMA', '02189107785', 'JL RAYA IMAM BONJOL KM 48 KP GARDU SAWAH CIBITUNG - BEKASI'),
(5, '11115', 'PD TUNAS KARYA', '081318921356', 'JL RAYA SERANG KM 15 LAPANGAN BARU KRAGILAN SERANG BANTEN'),
(6, '123456789', 'agusj jp', '1234567890', 'Jakarta Utara kelapa gading'),
(7, '1234567891', 'yulia', '123456789086', 'jakarta utara'),
(8, '11111111', 'gusti', '123456789', 'jakarta'),
(9, '1212243', 'temi', '23123432', 'jakarta utara'),
(10, '1234567890', 'HImalaya', '123456789', 'jakarata selatan 1'),
(22, 'SP11111', 'PT XYZ', '021111111111', 'Jl Baru'),
(23, 'SP22222', 'PT JKL', '021111111112', 'Jl Lama');

-- --------------------------------------------------------

--
-- Struktur dari tabel `suratjalan`
--

CREATE TABLE `suratjalan` (
  `no_suratjalan` varchar(15) NOT NULL,
  `tgl_suratjalan` date DEFAULT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `alamat` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `suratjalan_d`
--

CREATE TABLE `suratjalan_d` (
  `no_suratjalan` varchar(15) NOT NULL,
  `nm_barang` varchar(15) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `keterangan` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tandaterima`
--

CREATE TABLE `tandaterima` (
  `id_tandaterima` int(11) NOT NULL,
  `dari` varchar(100) NOT NULL,
  `kepada` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `nominal` tinytext NOT NULL,
  `keterangan` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tandaterima`
--

INSERT INTO `tandaterima` (`id_tandaterima`, `dari`, `kepada`, `tanggal`, `nominal`, `keterangan`) VALUES
(5, 'a', 'a', '2023-09-25', '1111', 'sasds');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `role` enum('gudang','admin','owner','kasir') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  `foto` text NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `email`, `no_telp`, `role`, `password`, `created_at`, `foto`, `is_active`) VALUES
(1, 'Adminisitrator', 'admin', 'admin@admin.com', '025123456789', 'admin', '$2y$10$wMgi9s3FEDEPEU6dEmbp8eAAEBUXIXUy3np3ND2Oih.MOY.q/Kpoy', 1568689561, 'admin.png', 0),
(18, 'welaadmin', 'welaadmin', 'wela@gmail.com', '08521467909', 'gudang', '$2y$10$AfeisA9HAK9y71Fa/FVu.uuhkzLdXdxdKHnEJPCUGthH7go2hTQqO', 1675099040, 'user.png', 1),
(19, 'haryono', 'haryono', 'haryono@gmail.com', '08521467909', 'owner', '$2y$10$e94UE826b2xQ2r6aTwWkk.ciqqs4XkwJKzvEXYX4qN/KHjg86W2XG', 1675099088, 'user.png', 1),
(20, 'mando', 'mando', 'mando@gmail.com', '08123456789', 'gudang', '$2y$10$fEt9lwbaiTPAY1D/BO8BYuQV/RIDaX/9P31MXd78ECnVS2gQVloYa', 1675666404, 'user.png', 1),
(21, 'icha', 'icha', 'inca@gmail.com', '081513236022', 'owner', '$2y$10$B9KtWchxojTVbYL6TuQkKeRZ8lJ1G5fqQJhkSPt7TveDgYE5.7u/a', 1675868563, 'user.png', 1),
(22, 'Miftahul R', 'Pramesta', 'miftahulrohman104@gmail.com', '082112209849', 'gudang', '$2y$10$HlJJRy5gbkx3JHdr7KzZU.D350jU5sgp8OBoB7TEVk79ClTNM.sNG', 1677949003, 'user.png', 0),
(23, 'Linda Fitri', 'linda', 'linda@gmail.com', '0887776689987', 'kasir', '$2y$10$oYpQQdwuciY4i.Or4avsJePLKVuCiGypWcXef1DVlYZeNRH.INvi2', 1696037213, 'user.png', 1),
(24, 'Nanda Febrian', 'nanda', 'nanda@gmail.com', '09999999999', 'kasir', '$2y$10$rvEF1hOirU6QeWXProIaFOMJcaIrZ54hjAhLewJhsz2n8pLzIJnXy', 1696045525, 'user.png', 1),
(25, 'Agus Joko priyanto', 'admingudang', 'priyantoagus338@gmail.com', '085217039585', 'owner', '$2y$10$Rmd/8OhgmBd/Gyk3OQMle.FQmCjbExKTotaOI3/dcZRRoz74UWJ6i', 1697704909, 'user.png', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `voucher`
--

CREATE TABLE `voucher` (
  `id_voucher` int(11) NOT NULL,
  `kd_voucher` int(11) NOT NULL,
  `nominal` int(11) NOT NULL,
  `tgl_expired` date NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `voucher`
--

INSERT INTO `voucher` (`id_voucher`, `kd_voucher`, `nominal`, `tgl_expired`, `status`, `created_at`) VALUES
(1, 10001, 100000, '2023-09-30', '1', '2023-09-28 01:33:20'),
(2, 10002, 200000, '2023-09-30', '0', '2023-09-28 01:33:20'),
(3, 10003, 300000, '2023-09-30', '0', '2023-09-28 01:33:20'),
(4, 10004, 400000, '2023-09-28', '0', '2023-09-28 01:33:20'),
(5, 10005, 550000, '2023-09-28', '0', '2023-09-28 01:33:20'),
(6, 10006, 600000, '2023-10-01', '0', '2023-09-28 01:33:20'),
(7, 10021, 15000, '2023-10-20', '1', '2023-10-02 06:52:00'),
(8, 10022, 20000, '2023-10-20', '0', '2023-10-02 06:52:00'),
(9, 10023, 25000, '2023-10-20', '1', '2023-10-02 06:52:00'),
(10, 10024, 30000, '2023-10-20', '1', '2023-10-02 06:52:00'),
(11, 10025, 35000, '2023-10-20', '0', '2023-10-02 06:52:00'),
(12, 10026, 40000, '2023-10-20', '1', '2023-10-02 06:52:00'),
(13, 10027, 45000, '2023-10-20', '0', '2023-10-02 06:52:00'),
(17, 10028, 42500, '2023-10-20', '0', '2023-10-13 23:18:30');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indeks untuk tabel `barang_broken`
--
ALTER TABLE `barang_broken`
  ADD PRIMARY KEY (`no_po`);

--
-- Indeks untuk tabel `barang_west`
--
ALTER TABLE `barang_west`
  ADD PRIMARY KEY (`id_barang_west`),
  ADD KEY `id_user` (`user_id`),
  ADD KEY `barang_id` (`barang_id`);

--
-- Indeks untuk tabel `brg_masuk`
--
ALTER TABLE `brg_masuk`
  ADD PRIMARY KEY (`no_po`);

--
-- Indeks untuk tabel `brg_masuk_d`
--
ALTER TABLE `brg_masuk_d`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_cust`);

--
-- Indeks untuk tabel `customer_d`
--
ALTER TABLE `customer_d`
  ADD PRIMARY KEY (`id_`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`no_notap`);

--
-- Indeks untuk tabel `po_invoice`
--
ALTER TABLE `po_invoice`
  ADD PRIMARY KEY (`no_po_inv`);

--
-- Indeks untuk tabel `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD PRIMARY KEY (`no_po`);

--
-- Indeks untuk tabel `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id_sales`);

--
-- Indeks untuk tabel `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`id_satuan`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indeks untuk tabel `suratjalan`
--
ALTER TABLE `suratjalan`
  ADD PRIMARY KEY (`no_suratjalan`);

--
-- Indeks untuk tabel `tandaterima`
--
ALTER TABLE `tandaterima`
  ADD PRIMARY KEY (`id_tandaterima`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeks untuk tabel `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`id_voucher`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `brg_masuk_d`
--
ALTER TABLE `brg_masuk_d`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT untuk tabel `customer`
--
ALTER TABLE `customer`
  MODIFY `id_cust` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `customer_d`
--
ALTER TABLE `customer_d`
  MODIFY `id_` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `sales`
--
ALTER TABLE `sales`
  MODIFY `id_sales` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `satuan`
--
ALTER TABLE `satuan`
  MODIFY `id_satuan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `tandaterima`
--
ALTER TABLE `tandaterima`
  MODIFY `id_tandaterima` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `voucher`
--
ALTER TABLE `voucher`
  MODIFY `id_voucher` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
