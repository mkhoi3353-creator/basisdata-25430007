# Dokumen Skenario Uji DML - Perpustakaan Cendekia
**NIM:** 25430007  
**Nama:** Khair  

## Tabel Skenario Uji Positif dan Negatif

| Kode | Masukan (Input / Perintah SQL) | Harapan | Hasil Nyata | Status | Aturan / Constraint |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **UJ-01** | `INSERT INTO peminjaman VALUES ('PJ-202610-006', '2026-10-12 10:00:00', 'AG001', 'P02');` | Diterima | Query OK, 1 row affected | LULUS | AB-02 (Anggota Aktif) |
| **UJ-02** | `INSERT INTO buku VALUES ('BK-006', 'Struktur Data', 'Teknologi', -5);` | Ditolak, ERROR 4025 | ERROR 4025 (23000): CONSTRAINT `ck_stok_buku` failed | LULUS | `ck_stok_buku` |
| **UJ-03** | `INSERT INTO peminjaman VALUES ('PJ-202610-001', '2026-10-12 11:00:00', 'AG002', 'P02');` | Ditolak, ERROR 1062 | ERROR 1062 (23000): Duplicate entry 'PJ-202610-001' for key 'PRIMARY' | LULUS | AB-01 (Primary Key) |
| **UJ-04** | `INSERT INTO detail_peminjaman VALUES ('PJ-202610-001', 'BK-001', 0);` | Ditolak, ERROR 4025 | ERROR 4025 (23000): CONSTRAINT `ck_jumlah_pinjam` failed | LULUS | `ck_jumlah_pinjam` |
| **UJ-05** | `INSERT INTO peminjaman VALUES ('PJ-202610-007', '2026-10-12 12:00:00', 'AG001', 'P99');` | Ditolak, ERROR 1452 | ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails | LULUS | `fk_peminjaman_petugas` |
| **UJ-06** | `UPDATE buku SET stok_buku = 10;` (dalam mode `sql_safe_updates = 1`) | Ditolak, ERROR 1175 | ERROR 1175 (HY000): You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column | LULUS | Kebijakan Lab / Safe Update |
| **UJ-07** | `INSERT INTO peminjaman VALUES ('PJ-202610-008', '2026-10-12 13:00:00', 'AG003', 'P02');` | Ditolak, Anggota Nonaktif | Ditolak oleh sistem / validasi status | LULUS | AB-02 (Status Anggota) |
| **UJ-08** | `DELETE FROM petugas WHERE kode_petugas = 'P02';` | Ditolak, ERROR 1451 | ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails | LULUS | `ON DELETE RESTRICT` |
| **UJ-09** | `UPDATE buku SET stok_buku = stok_buku - 1 WHERE kode_buku = 'BK-001';` | Diterima, stok berkurang | Query OK, 1 row affected | LULUS | Logika Bisnis Stok |
| **UJ-10** | `INSERT INTO detail_peminjaman VALUES ('PJ-202610-001', 'BK-003', 10);` | Ditolak (Kuota max pinjam terlampaui) | Query OK, 1 row affected (Server belum membatasi kuota) | GAGAL | Aturan Kuota Buku (Utang Desain Modul 14) |