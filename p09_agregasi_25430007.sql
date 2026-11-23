-- =====================================================================
-- Skrip Kueri Modul 9: Agregasi dan Ringkasan Data (Milestone Proyek 9)
-- Proyek    : Perpustakaan Cendekia
-- NIM       : 25430007
-- Nama      : Muhammad Khoirudin
-- Kelas     : A
-- =====================================================================

-- 0. Pastikan menggunakan basis data yang benar dan aktifkan mode ketat
USE perpustakaan_cendekia;
SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- ---------------------------------------------------------------------
-- KI-01: Rekapitulasi Total Peminjaman dan Denda per Anggota
-- ---------------------------------------------------------------------
SELECT a.id_anggota, a.nama_anggota, 
       COUNT(p.id_peminjaman) AS total_peminjaman,
       SUM(p.denda) AS total_denda
FROM anggota a
LEFT JOIN peminjaman p ON p.id_anggota = a.id_anggota
GROUP BY a.id_anggota, a.nama_anggota;

-- ---------------------------------------------------------------------
-- KI-02: Ringkasan Jumlah Buku Berdasarkan Kategori
-- ---------------------------------------------------------------------
SELECT k.nama_kategori, 
       COUNT(b.id_buku) AS jumlah_judul_buku,
       SUM(b.stok_buku) AS total_stok_tersedia
FROM kategori k
LEFT JOIN buku b ON b.id_kategori = k.id_kategori
GROUP BY k.id_kategori, k.nama_kategori;

-- ---------------------------------------------------------------------
-- KI-03: Laporan Denda Bulanan Menggunakan WITH ROLLUP (Baris Total)
-- ---------------------------------------------------------------------
SELECT DATE_FORMAT(p.tgl_peminjaman, '%Y-%m') AS bulan,
       COUNT(p.id_peminjaman) AS total_transaksi,
       SUM(p.denda) AS omzet_denda
FROM peminjaman p
GROUP BY DATE_FORMAT(p.tgl_peminjaman, '%Y-%m') WITH ROLLUP;

-- ---------------------------------------------------------------------
-- KI-04: Filter Anggota yang Melakukan Peminjaman Lebih dari 2 Kali (HAVING)
-- ---------------------------------------------------------------------
SELECT a.nama_anggota, 
       COUNT(p.id_peminjaman) AS jumlah_pinjam
FROM anggota a
JOIN peminjaman p ON p.id_anggota = a.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
HAVING COUNT(p.id_peminjaman) > 2;

-- ---------------------------------------------------------------------
-- KI-05: Statistik Rata-rata Denda dan Maksimal Denda per Petugas
-- ---------------------------------------------------------------------
SELECT pt.id_petugas, pt.nama_petugas,
       COUNT(p.id_peminjaman) AS total_melayani,
       AVG(p.denda) AS rata_rata_denda,
       MAX(p.denda) AS denda_maksimal
FROM petugas pt
JOIN peminjaman p ON p.id_petugas = pt.id_petugas
GROUP BY pt.id_petugas, pt.nama_petugas;
