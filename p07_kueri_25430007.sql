-- =====================================================================
-- Nama      : Muhammad Khoirudin
-- NIM       : 25430007
-- Kelas     : A
-- Modul     : Modul 7 - SELECT dan Fungsi Skalar (Perpustakaan Cendekia)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Kueri 1: KI-01 - Pencarian Buku Berdasarkan Kata Kunci Judul (LIKE)
-- Pertanyaan: Buku apa saja yang memiliki kata 'Data' pada judulnya?
-- Harapan: Menampilkan daftar buku yang judulnya mengandung kata 'Data'.
-- ---------------------------------------------------------------------
SELECT kode_buku, judul_buku, kategori_buku, stok_buku
FROM buku
WHERE judul_buku LIKE '%Data%';


-- ---------------------------------------------------------------------
-- Kueri 2: KI-02 - Penyaringan Rentang Tanggal Peminjaman (BETWEEN)
-- Pertanyaan: Peminjaman apa saja yang terjadi pada rentang tanggal tertentu?
-- Harapan: Menampilkan data peminjaman dalam rentang tanggal Oktober 2026.
-- ---------------------------------------------------------------------
SELECT no_peminjaman, tgl_peminjaman, kode_anggota, kode_petugas
FROM peminjaman
WHERE tgl_peminjaman BETWEEN '2026-10-01 00:00:00' AND '2026-10-31 23:59:59';


-- ---------------------------------------------------------------------
-- Kueri 3: KI-03 - Penyaringan Kategori Buku Tertentu (IN)
-- Pertanyaan: Buku apa saja yang masuk dalam kategori Teknologi atau Sains?
-- Harapan: Menampilkan buku yang kategorinya merupakan salah satu dari pilihan 'Teknologi' atau 'Sains'.
-- ---------------------------------------------------------------------
SELECT kode_buku, judul_buku, kategori_buku, stok_buku
FROM buku
WHERE kategori_buku IN ('Teknologi', 'Sains');


-- ---------------------------------------------------------------------
-- Kueri 4: KI-04 - Pemeriksaan Anggota Tanpa Nomor HP (IS NULL)
-- Pertanyaan: Anggota siapa saja yang belum mencatatkan nomor telepon atau HP?
-- Harapan: Menampilkan daftar anggota yang kolom no_hp_anggota bernilai NULL.
-- ---------------------------------------------------------------------
SELECT kode_anggota, nama_anggota, status_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL;


-- ---------------------------------------------------------------------
-- Kueri 5: KI-05 - Penggunaan Fungsi String (UPPER & CONCAT)
-- Pertanyaan: Bagaimana format nama anggota dan kodenya dalam huruf kapital?
-- Harapan: Menampilkan gabungan kode dan nama anggota dalam format teks kapital.
-- ---------------------------------------------------------------------
SELECT UPPER(CONCAT(nama_anggota, ' (', kode_anggota, ')')) AS info_anggota,
       status_anggota
FROM anggota;


-- ---------------------------------------------------------------------
-- Kueri 6: KI-06 - Penggunaan Fungsi Tanggal (DATE_FORMAT)
-- Pertanyaan: Kapan tanggal pendaftaran anggota jika diformat ke format Indonesia (DD-MM-YYYY)?
-- Harapan: Menampilkan tanggal daftar anggota dengan format tanggal lokal.
-- ---------------------------------------------------------------------
SELECT kode_anggota, nama_anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tanggal_daftar_formatted
FROM anggota;


-- ---------------------------------------------------------------------
-- Kueri 7: KI-07 - Penggunaan Kondisional CASE
-- Pertanyaan: Apa kategori status keanggotaan jika diterjemahkan menjadi label diskon/layanan?
-- Harapan: Menampilkan keterangan khusus berdasarkan status keanggotaan aktif atau nonaktif.
-- ---------------------------------------------------------------------
SELECT kode_anggota, nama_anggota, status_anggota,
       CASE status_anggota
           WHEN 'aktif' THEN 'Layanan Penuh'
           ELSE 'Akses Terbatas'
       END AS keterangan_layanan
FROM anggota;


-- ---------------------------------------------------------------------
-- Kueri 8: KI-08 - Pengurutan Data Stok Buku Terendah (ORDER BY & LIMIT)
-- Pertanyaan: 3 buku apa yang memiliki stok paling sedikit untuk segera dipesan ulang?
-- Harapan: Menampilkan 3 baris buku dengan stok terendah secaraascending.
-- ---------------------------------------------------------------------
SELECT kode_buku, judul_buku, stok_buku
FROM buku
ORDER BY stok_buku ASC
LIMIT 3;


-- ---------------------------------------------------------------------
-- Kueri 9: KI-09 - Perhitungan Subtotal Detail Peminjaman (Numerik)
-- Pertanyaan: Berapa subtotal jumlah barang atau buku yang dipinjam pada detail transaksi?
-- Harapan: Menampilkan hasil perkalian jumlah pinjam dengan bobot tertentu atau manipulasi numerik per baris.
-- ---------------------------------------------------------------------
SELECT no_peminjaman, kode_buku, jumlah_pinjam,
       (jumlah_pinjam * 1) AS bobot_total_baris
FROM detail_peminjaman;


-- ---------------------------------------------------------------------
-- Kueri 10: KI-10 - Pencarian Anggota Berdasarkan Pola Nama Belakang (LIKE)
-- Pertanyaan: Siapa saja anggota yang namanya berakhiran huruf tertentu atau mengandung pola tertentu?
-- Harapan: Menampilkan anggota yang namanya cocok dengan pola pencarian teks tertentu.
-- ---------------------------------------------------------------------
SELECT kode_anggota, nama_anggota, email_anggota
FROM anggota
WHERE nama_anggota LIKE '%a%';