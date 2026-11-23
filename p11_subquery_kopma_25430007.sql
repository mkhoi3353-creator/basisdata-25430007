-- ============================================================================
-- Modul 11: Subquery dan Operasi Himpunan (Latihan Kasus Kopma)
-- Nama   : Muhammad Khoirudin
-- NIM    : 25430007
-- Kelas  : A
-- ============================================================================

DROP DATABASE IF EXISTS kopma_007;
CREATE DATABASE kopma_007
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kopma_007;

-- 1. Struktur Tabel Kopma
CREATE TABLE pemasok (
    id_pemasok VARCHAR(10) PRIMARY KEY,
    nama_pemasok VARCHAR(100) NOT NULL,
    kota VARCHAR(50),
    no_telepon VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE petugas (
    id_petugas VARCHAR(10) PRIMARY KEY,
    nama_petugas VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE barang (
    id_barang VARCHAR(10) PRIMARY KEY,
    nama_barang VARCHAR(100) NOT NULL,
    kategori VARCHAR(50),
    harga_beli DECIMAL(12,2) NOT NULL DEFAULT 0,
    harga_jual DECIMAL(12,2) NOT NULL DEFAULT 0,
    stok INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE penjualan (
    no_nota VARCHAR(20) PRIMARY KEY,
    tanggal_nota DATE NOT NULL,
    id_petugas VARCHAR(10),
    total_bayar DECIMAL(12,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_penjualan_petugas
        FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
) ENGINE=InnoDB;

CREATE TABLE detail_penjualan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    no_nota VARCHAR(20) NOT NULL,
    id_barang VARCHAR(10) NOT NULL,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_detail_penjualan_nota
        FOREIGN KEY (no_nota) REFERENCES penjualan(no_nota),
    CONSTRAINT fk_detail_penjualan_barang
        FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
) ENGINE=InnoDB;

CREATE TABLE pembelian (
    no_faktur VARCHAR(20) PRIMARY KEY,
    tanggal_faktur DATE NOT NULL,
    id_pemasok VARCHAR(10),
    id_petugas VARCHAR(10),
    total_faktur DECIMAL(12,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_pembelian_pemasok
        FOREIGN KEY (id_pemasok) REFERENCES pemasok(id_pemasok),
    CONSTRAINT fk_pembelian_petugas
        FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
) ENGINE=InnoDB;

CREATE TABLE detail_pembelian (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    no_faktur VARCHAR(20) NOT NULL,
    id_barang VARCHAR(10) NOT NULL,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_detail_pembelian_faktur
        FOREIGN KEY (no_faktur) REFERENCES pembelian(no_faktur),
    CONSTRAINT fk_detail_pembelian_barang
        FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
) ENGINE=InnoDB;

-- 2. Data Sampel Kopma
INSERT INTO pemasok (id_pemasok, nama_pemasok, kota, no_telepon) VALUES
('PMK01', 'CV Sumber Makmur', 'Bandung', '022-7001122'),
('PMK02', 'PT Mitra Sejahtera', 'Jakarta', '021-8899776'),
('PMK03', 'UD Berkah Jaya', NULL, '081234567890');

INSERT INTO petugas (id_petugas, nama_petugas, jabatan) VALUES
('PTG01', 'Rina Kusuma', 'Kasir'),
('PTG02', 'Budi Santoso', 'Staf Gudang'),
('PTG03', 'Sari Wulandari', 'Kasir');

INSERT INTO barang (id_barang, nama_barang, kategori, harga_beli, harga_jual, stok) VALUES
('BRG01', 'Buku Tulis Sidu 38', 'ATK', 3200.00, 4500.00, 50),
('BRG02', 'Pulpen Snowman V5', 'ATK', 1800.00, 2500.00, 80),
('BRG03', 'Air Mineral Botol 600ml', 'Minuman', 2200.00, 3500.00, 120),
('BRG04', 'Kopi Instan Sachet', 'Minuman', 1200.00, 2000.00, 60),
('BRG05', 'Stabilo Boss Kuning', 'ATK', 7500.00, 10000.00, 25);

INSERT INTO penjualan (no_nota, tanggal_nota, id_petugas, total_bayar) VALUES
('NTA001', '2026-10-01', 'PTG01', 23500.00),
('NTA002', '2026-10-02', 'PTG01', 14000.00),
('NTA003', '2026-10-03', 'PTG03', 10000.00);

INSERT INTO detail_penjualan (no_nota, id_barang, jumlah, harga_satuan) VALUES
('NTA001', 'BRG01', 3, 4500.00),
('NTA001', 'BRG03', 4, 3500.00),
('NTA002', 'BRG02', 4, 2500.00),
('NTA002', 'BRG03', 1, 4000.00),
('NTA003', 'BRG04', 5, 2000.00);

INSERT INTO pembelian (no_faktur, tanggal_faktur, id_pemasok, id_petugas, total_faktur) VALUES
('FKT001', '2026-09-25', 'PMK01', 'PTG02', 250000.00),
('FKT002', '2026-09-28', 'PMK02', 'PTG02', 300000.00);

INSERT INTO detail_pembelian (no_faktur, id_barang, jumlah, harga_satuan) VALUES
('FKT001', 'BRG01', 50, 3200.00),
('FKT001', 'BRG02', 50, 1800.00),
('FKT002', 'BRG03', 100, 2200.00);

-- 3. Subquery Skalar: Barang dengan harga_jual di atas rata-rata
SELECT id_barang, nama_barang, harga_jual
FROM barang
WHERE harga_jual > (SELECT AVG(harga_jual) FROM barang);

-- 4. Subquery Berkorelasi (NOT EXISTS): Barang belum pernah terjual
SELECT b.id_barang, b.nama_barang, b.stok
FROM barang b
WHERE NOT EXISTS (
    SELECT 1
    FROM detail_penjualan dp
    WHERE dp.id_barang = b.id_barang
);

-- 5. Derived Table: Nota penjualan dengan total_bayar di atas rata-rata nota
SELECT p.no_nota, p.tanggal_nota, p.total_bayar, r.rata_nota
FROM penjualan p
CROSS JOIN (
    SELECT AVG(total_bayar) AS rata_nota
    FROM penjualan
) AS r
WHERE p.total_bayar > r.rata_nota;

-- 6. Jebakan NOT IN dengan NULL vs tanpa NULL
SELECT id_pemasok, nama_pemasok, kota
FROM pemasok
WHERE id_pemasok NOT IN ('PMK01', NULL);

SELECT id_pemasok, nama_pemasok, kota
FROM pemasok
WHERE id_pemasok NOT IN ('PMK01', 'PMK02');

-- 7. Operasi Himpunan: UNION, UNION ALL, INTERSECT, EXCEPT
SELECT id_barang FROM detail_pembelian
UNION
SELECT id_barang FROM detail_penjualan;

SELECT id_barang FROM detail_pembelian
UNION ALL
SELECT id_barang FROM detail_penjualan;

SELECT id_barang FROM detail_pembelian
INTERSECT
SELECT id_barang FROM detail_penjualan;

SELECT id_barang FROM detail_pembelian
EXCEPT
SELECT id_barang FROM detail_penjualan;