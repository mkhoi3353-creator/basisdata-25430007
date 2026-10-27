-- ========================================================
-- Skrip DDL Basis Data: Perpustakaan Cendekia
-- NIM: 25430007 | Modul 5: DDL dan Constraint
-- ========================================================

USE perpustakaan_25430007;

-- --------------------------------------------------------
-- 1. DROP TABLE IF EXISTS (Urutan Terbalik: Anak -> Induk)
-- --------------------------------------------------------
DROP TABLE IF EXISTS DETAIL_PEMINJAMAN;
DROP TABLE IF EXISTS PEMINJAMAN;
DROP TABLE IF EXISTS BUKU;
DROP TABLE IF EXISTS ANGGOTA;

-- --------------------------------------------------------
-- 2. TABEL INDUK / MASTER (Tanpa Foreign Key)
-- --------------------------------------------------------

-- Tabel ANGGOTA
CREATE TABLE ANGGOTA (
    id_anggota CHAR(10) NOT NULL,
    nama_anggota VARCHAR(100) NOT NULL,
    no_telepon_anggota VARCHAR(15) NULL,
    status_anggota ENUM('aktif', 'nonaktif') NOT NULL DEFAULT 'aktif', -- AB-02: Hak keanggotaan
    CONSTRAINT pk_anggota PRIMARY KEY (id_anggota)
) ENGINE=InnoDB;

-- Tabel BUKU
CREATE TABLE BUKU (
    id_buku CHAR(10) NOT NULL,
    judul_buku VARCHAR(150) NOT NULL,
    pengarang VARCHAR(100) NOT NULL,
    stok_buku INT NOT NULL DEFAULT 0,
    stok_min_buku INT NOT NULL DEFAULT 2,
    CONSTRAINT pk_buku PRIMARY KEY (id_buku),
    CONSTRAINT ck_buku_stok CHECK (stok_buku >= 0),         -- AB-03: Stok tidak boleh negatif
    CONSTRAINT ck_buku_stok_min CHECK (stok_min_buku >= 0)  -- AB-06: Batas minimal pemesanan ulang
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- 3. TABEL TRANSAKSI / ANAK (Dengan Foreign Key)
-- --------------------------------------------------------

-- Tabel PEMINJAMAN (Kepala Transaksi)
CREATE TABLE PEMINJAMAN (
    id_peminjaman CHAR(10) NOT NULL,
    tanggal_pinjam DATETIME NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    status_peminjaman ENUM('dipinjam', 'kembali', 'terlambat') NOT NULL DEFAULT 'dipinjam',
    id_anggota CHAR(10) NULL, -- Boleh NULL untuk mendukung ON DELETE SET NULL (UU PDP & AB-02)
    CONSTRAINT pk_peminjaman PRIMARY KEY (id_peminjaman),
    CONSTRAINT fk_peminjaman_anggota FOREIGN KEY (id_anggota) 
        REFERENCES ANGGOTA(id_anggota) 
        ON UPDATE CASCADE 
        ON DELETE SET NULL -- AB-02 & UU PDP
) ENGINE=InnoDB;

-- Tabel DETAIL_PEMINJAMAN (Rincian Transaksi)
CREATE TABLE DETAIL_PEMINJAMAN (
    id_peminjaman CHAR(10) NOT NULL,
    id_buku CHAR(10) NOT NULL,
    jumlah_buku INT NOT NULL,
    CONSTRAINT pk_detail_peminjaman PRIMARY KEY (id_peminjaman, id_buku),
    CONSTRAINT ck_detail_peminjaman_jumlah CHECK (jumlah_buku > 0 AND jumlah_buku <= 3), -- AB-07: Maksimal 3 buku/item
    CONSTRAINT fk_detail_peminjaman_peminjaman FOREIGN KEY (id_peminjaman) 
        REFERENCES PEMINJAMAN(id_peminjaman) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_detail_peminjaman_buku FOREIGN KEY (id_buku) 
        REFERENCES BUKU(id_buku) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
) ENGINE=InnoDB;
