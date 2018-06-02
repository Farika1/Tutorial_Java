-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 01 Jun 2018 pada 06.46
-- Versi Server: 10.1.13-MariaDB
-- PHP Version: 5.5.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baru`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `akses` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `login`
--

INSERT INTO `login` (`username`, `password`, `akses`) VALUES
('kasir', 'kasir', 'kasir'),
('admin', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `harga` int(6) NOT NULL,
  `stok` int(2) NOT NULL,
  `kategori` enum('Makanan Berat','Minuman','Camilan','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`kd_barang`, `nama`, `harga`, `stok`, `kategori`) VALUES
('F0001', 'Ketoprak', 6000, 33, 'Makanan Berat'),
('F0002', 'Donat', 1000, 80, 'Camilan'),
('F0003', 'Baso', 5000, 23, 'Makanan Berat'),
('F0004', 'Mie Ayam', 7000, 23, 'Makanan Berat'),
('F0005', 'Soto Mie', 8000, 20, 'Makanan Berat'),
('F0006', 'Seblak', 5000, 35, 'Makanan Berat'),
('F0007', 'Milkshake', 5000, 94, 'Minuman'),
('F0008', 'Jus', 4500, 50, 'Minuman'),
('F0009', 'Onde-Onde', 1000, 100, 'Camilan'),
('F0010', 'Kue Kering', 2000, 100, 'Camilan'),
('F0011', 'Pangsit Sosis', 2000, 100, 'Camilan'),
('F0012', 'Tahu Jeletot', 2000, 100, 'Camilan'),
('F0013', 'Mie Kremes', 1000, 100, 'Camilan'),
('F0014', 'Es  Kul-kul', 2000, 20, 'Camilan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tmp_transaksi`
--

CREATE TABLE `tmp_transaksi` (
  `no` int(11) NOT NULL,
  `kd_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Trigger `tmp_transaksi`
--
DELIMITER $$
CREATE TRIGGER `batal_beli` AFTER DELETE ON `tmp_transaksi` FOR EACH ROW BEGIN UPDATE tbl_barang SET tbl_barang.stok = tbl_barang.stok + old.jumlah WHERE tbl_barang.kd_barang = old.kd_barang; END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `beli` AFTER INSERT ON `tmp_transaksi` FOR EACH ROW BEGIN
UPDATE tbl_barang SET
tbl_barang.stok = tbl_barang.stok - NEW.jumlah
WHERE tbl_barang.kd_barang = new.kd_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `kd_transaksi` varchar(10) NOT NULL,
  `tgl_pembelian` date NOT NULL,
  `total` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`kd_transaksi`, `tgl_pembelian`, `total`) VALUES
('T0001', '2018-05-31', 50000),
('T0002', '2018-05-31', 25500),
('T0003', '2018-05-31', 4000),
('T0004', '2018-05-31', 10000),
('T0005', '2018-06-01', 46000),
('T0006', '2018-06-01', 4000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indexes for table `tmp_transaksi`
--
ALTER TABLE `tmp_transaksi`
  ADD PRIMARY KEY (`no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tmp_transaksi`
--
ALTER TABLE `tmp_transaksi`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
