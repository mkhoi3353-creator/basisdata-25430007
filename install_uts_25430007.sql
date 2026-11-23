-- =====================================================================
-- Master Skrip Instalasi Bersih UTS Proyek Tahap 1
-- Proyek    : Perpustakaan Cendekia
-- NIM       : 25430007
-- Nama      : Muhammad Khoirudin
-- Kelas     : A
-- =====================================================================

-- 1. Hapus basis data lama jika ada dan buat baru
DROP DATABASE IF EXISTS perpustakaan_cendekia;
CREATE DATABASE perpustakaan_cendekia;
USE perpustakaan_cendekia;

-- 2. Eksekusi skrip DDL (Struktur Tabel & Relasi) dari Modul sebelumnya
-- (Sesuaikan nama file DDL jika menggunakan penamaan tertentu)
SOURCE p05_ddl_25430007.sql;

-- 3. Eksekusi skrip Data Manipulation / DML / Pengisian Data
SOURCE p06_data_25430007.sql;

-- Selesai. Basis data Perpustakaan Cendekia siap digunakan dan diuji.
