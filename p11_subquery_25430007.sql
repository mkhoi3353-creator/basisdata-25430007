-- ============================================================================
-- Modul 11: Subquery dan Operasi Himpunan (Milestone Proyek Perpustakaan Cendekia)
-- Nama   : Muhammad Khoirudin
-- NIM    : 25430007
-- Kelas  : A
-- Proyek : Perpustakaan Cendekia
-- ============================================================================

DROP DATABASE IF EXISTS perpustakaan_007;
CREATE DATABASE perpustakaan_007
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE perpustakaan_007;

-- 1. Struktur Tabel Perpustakaan Cendekia
CREATE TABLE admin (
    id_admin VARCHAR(10) PRIMARY KEY,
    nama_admin VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE anggota (
    id_anggota VARCHAR(10) PRIMARY KEY,
    nama_anggota VARCHAR(100) NOT NULL,
    no_telepon_anggota VARCHAR(15) NULL,
    status_anggota ENUM('aktif', 'nonaktif') NOT NULL DEFAULT 'aktif'
) ENGINE=InnoDB;

CREATE TABLE buku (
    id_buku VARCHAR(10) PRIMARY KEY,
    judul_buku VARCHAR(150) NOT NULL,
    pengarang VARCHAR(100) NOT NULL,
    stok_buku INT NOT NULL DEFAULT 0,
    stok_min_buku INT NOT NULL DEFAULT 2
) ENGINE=InnoDB;

CREATE TABLE peminjaman (
    id_peminjaman VARCHAR(15) PRIMARY KEY,
    id_anggota VARCHAR(10) NOT NULL,
    id_admin VARCHAR(10) NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE NULL,
    denda INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_pinjam_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
    CONSTRAINT fk_pinjam_admin FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
) ENGINE=InnoDB;

CREATE TABLE detail_peminjaman (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman VARCHAR(15) NOT NULL,
    id_buku VARCHAR(10) NOT NULL,
    jumlah INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_detail_pinjam FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman),
    CONSTRAINT fk_detail_buku FOREIGN KEY (id_buku) REFERENCES buku(id_buku)
) ENGINE=InnoDB;

-- 2. Data Sampel Perpustakaan Cendekia
INSERT INTO admin (id_admin, nama_admin, username) VALUES
('ADM01', 'Nadia Pratama', 'nadia_adm'),
('ADM02', 'Rizky Hidayat', 'rizky_adm');

INSERT INTO anggota (id_anggota, nama_anggota, no_telepon_anggota, status_anggota) VALUES
('AGT01', 'Aulia Rahma', '08127001122', 'aktif'),
('AGT02', 'Dimas Saputra', NULL, 'aktif'),
('AGT03', 'Maya Kartika', '08568009911', 'nonaktif'),
('AGT04', 'Fajar Nugroho', '08219003344', 'aktif');

INSERT INTO buku (id_buku, judul_buku, pengarang, stok_buku, stok_min_buku) VALUES
('BK01', 'Algoritma dan Struktur Data', 'Rinaldi Munir', 12, 3),
('BK02', 'Basis Data Relasional', 'Budi Raharjo', 4, 2),
('BK03', 'Rekayasa Perangkat Lunak', 'Rosa A. S.', 8, 3),
('BK04', 'Jaringan Komputer Modern', 'Andrew S. Tanenbaum', 2, 2);

INSERT INTO peminjaman (id_peminjaman, id_anggota, id_admin, tanggal_pinjam, tanggal_kembali, denda) VALUES
('PJM001', 'AGT01', 'ADM01', '2026-10-05', '2026-10-10', 0),
('PJM002', 'AGT02', 'ADM01', '2026-10-12', NULL, 5000),
('PJM003', 'AGT01', 'ADM02', '2026-10-18', '2026-10-22', 0);

INSERT INTO detail_peminjaman (id_peminjaman, id_buku, jumlah) VALUES
('PJM001', 'BK01', 1),
('PJM001', 'BK02', 1),
('PJM002', 'BK02', 1),
('PJM003', 'BK03', 2);

-- 3. Subquery Skalar: Buku dengan stok_buku di atas rata-rata stok
SELECT id_buku, judul_buku, stok_buku
FROM buku
WHERE stok_buku > (SELECT AVG(stok_buku) FROM buku);

-- 4. Subquery Berkorelasi (NOT EXISTS): Anggota yang belum pernah meminjam
SELECT a.id_anggota, a.nama_anggota, a.status_anggota
FROM anggota a
WHERE NOT EXISTS (
    SELECT 1
    FROM peminjaman p
    WHERE p.id_anggota = a.id_anggota
);

-- 5. Derived Table: Transaksi peminjaman dengan denda di atas rata-rata denda
SELECT p.id_peminjaman, p.id_anggota, p.denda, r.rata_denda
FROM peminjaman p
CROSS JOIN (
    SELECT AVG(denda) AS rata_denda
    FROM peminjaman
) AS r
WHERE p.denda > r.rata_denda;

-- 6. Jebakan NOT IN dengan NULL vs tanpa NULL pada anggota
SELECT id_anggota, nama_anggota
FROM anggota
WHERE id_anggota NOT IN ('AGT01', NULL);

SELECT id_anggota, nama_anggota
FROM anggota
WHERE id_anggota NOT IN ('AGT01', 'AGT02');