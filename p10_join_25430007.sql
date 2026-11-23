-- =====================================================================
-- Skrip Kueri Modul 10: Menghubungkan Tabel dengan JOIN (Milestone Proyek 10)
-- Proyek    : Perpustakaan Cendekia
-- NIM       : 25430007
-- Nama      : Muhammad Khoirudin
-- Kelas     : A
-- =====================================================================

-- 0. Aktifkan basis data dan mode ketat
USE perpustakaan_cendekia;
SET SESSION sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- ---------------------------------------------------------------------
-- KI-01: Daftar Buku Terlaris (INNER JOIN 3 Tabel)
-- Jalur ERD: buku -> detail_peminjaman -> peminjaman
-- ---------------------------------------------------------------------
SELECT b.kode_buku, b.judul_buku, SUM(d.qty_peminjaman) AS total_dipinjam
FROM detail_peminjaman d
JOIN buku b ON b.id_buku = d.id_buku
JOIN peminjaman p ON p.id_peminjaman = d.id_peminjaman
GROUP BY b.id_buku, b.kode_buku, b.judul_buku
ORDER BY total_dipinjam DESC
LIMIT 5;

-- ---------------------------------------------------------------------
-- KI-02: Anggota dengan Peminjaman Terbanyak (JOIN 3 Tabel dengan Agregasi)
-- Jalur ERD: anggota -> peminjaman -> detail_peminjaman
-- ---------------------------------------------------------------------
SELECT a.nim, a.nama_anggota,
       COUNT(DISTINCT p.id_peminjaman) AS total_transaksi,
       SUM(p.denda) AS total_denda
FROM anggota a
JOIN peminjaman p ON p.id_anggota = a.id_anggota
JOIN detail_peminjaman d ON d.id_peminjaman = p.id_peminjaman
GROUP BY a.id_anggota, a.nim, a.nama_anggota
ORDER BY total_transaksi DESC
LIMIT 5;

-- ---------------------------------------------------------------------
-- KI-03: Buku yang Belum Pernah Dipinjam Sama Sekali (LEFT JOIN Data Tanpa Pasangan)
-- Jalur ERD: buku -> detail_peminjaman
-- ---------------------------------------------------------------------
SELECT b.kode_buku, b.judul_buku, COUNT(d.id_buku) AS kali_dipinjam
FROM buku b
LEFT JOIN detail_peminjaman d ON d.id_buku = b.id_buku
GROUP BY b.id_buku, b.kode_buku, b.judul_buku
HAVING COUNT(d.id_buku) = 0;

-- ---------------------------------------------------------------------
-- KI-04: Transaksi Peminjaman Lengkap dengan Penanganan Peminjam Umum / Non-Anggota
-- Jalur ERD: peminjaman -> anggota (LEFT JOIN)
-- ---------------------------------------------------------------------
SELECT p.no_peminjaman, p.tgl_peminjaman,
       IFNULL(a.nama_anggota, 'Umum') AS nama_peminjam
FROM peminjaman p
LEFT JOIN anggota a ON a.id_anggota = p.id_anggota;

-- ---------------------------------------------------------------------
-- KI-05: Pasangan Anggota yang Berada di Kelas yang Sama (Self Join)
-- Jalur ERD: anggota a1 -> anggota a2 (Self Join pada kolom kelas)
-- ---------------------------------------------------------------------
SELECT a1.nama_anggota AS anggota_1, 
       a2.nama_anggota AS anggota_2, 
       a1.kelas
FROM anggota a1
JOIN anggota a2 ON a1.kelas = a2.kelas AND a1.id_anggota < a2.id_anggota;
