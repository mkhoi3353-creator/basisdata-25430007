# Laporan Modul 4: Normalisasi dan Skema Relasional

## Identitas Mahasiswa
* **Nama**: Muhammad Khoirudin
* **NIM**: 25430007
* **Kelas**: A
* **Proyek**: Perpustakaan Cendekia

---

## F. Tugas Mandiri: Milestone Proyek 4

### Langkah 1: Unnormalized Form (UNF)

Bentuk awal data mentah (spreadsheet/dokumen sumber) peminjaman Perpustakaan Cendekia yang masih memiliki kelompok berulang (*repeating group*):

`PEMINJAMAN_UNF` (`id_peminjaman`, `tanggal_pinjam`, `tanggal_jatuh_tempo`, `status_peminjaman`, `id_anggota`, `nama_anggota`, `no_telepon_anggota`, **`{ id_buku, judul_buku, pengarang, jumlah_buku }`**)

*Keterangan:* Bagian di dalam kurung kurawal `{ ... }` merupakan kelompok berulang karena satu peminjaman bisa mencatat lebih dari satu buku.

### Langkah 2: Dependensi Fungsional (Functional Dependency)

Berdasarkan aturan bisnis (AB) proyek Perpustakaan Cendekia, dirumuskan ketergantungan fungsional sebagai berikut:

* **FD1 (AB-01 Transaksi):** `id_peminjaman` -> `tanggal_pinjam`, `tanggal_jatuh_tempo`, `status_peminjaman`, `id_anggota`
* **FD2 (AB-02 Anggota):** `id_anggota` -> `nama_anggota`, `no_telepon_anggota`
* **FD3 (AB-03 Buku):** `id_buku` -> `judul_buku`, `pengarang`
* **FD4 (AB-04 Detail Peminjaman):** `(id_peminjaman, id_buku)` -> `jumlah_buku`

### Langkah 3: Tahapan Normalisasi (1NF, 2NF, 3NF) & BCNF

#### 1. First Normal Form (1NF)
Menghilangkan kelompok berulang (*repeating group*) sehingga setiap atribut bernilai tunggal (atomik):

`PEMINJAMAN_1NF` (<u>id_peminjaman</u>, <u>id_buku</u>, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman, id_anggota, nama_anggota, no_telepon_anggota, judul_buku, pengarang, jumlah_buku)

#### 2. Second Normal Form (2NF)
Menghilangkan ketergantungan parsial (*partial dependency*). Atribut `judul_buku` dan `pengarang` hanya bergantung pada `id_buku`, bukan pada gabungan kunci:

* `PEMINJAMAN` (<u>id_peminjaman</u>, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman, id_anggota, nama_anggota, no_telepon_anggota)
* `DETAIL_PEMINJAMAN` (<u>id_peminjaman*</u>, <u>id_buku*</u>, jumlah_buku)
* `BUKU` (<u>id_buku</u>, judul_buku, pengarang)

#### 3. Third Normal Form (3NF)
Menghilangkan ketergantungan transitif (*transitive dependency*). Pada relasi `PEMINJAMAN`, atribut `nama_anggota` dan `no_telepon_anggota` bergantung pada `id_anggota` (bukan kunci primer `id_peminjaman` secara langsung):

* `PEMINJAMAN` (<u>id_peminjaman</u>, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman, id_anggota*)
* `DETAIL_PEMINJAMAN` (<u>id_peminjaman*</u>, <u>id_buku*</u>, jumlah_buku)
* `BUKU` (<u>id_buku</u>, judul_buku, pengarang)
* `ANGGOTA` (<u>id_anggota</u>, nama_anggota, no_telepon_anggota)

*(Keterangan: <u>Garis bawah</u> = Primary Key, * = Foreign Key)*

#### 4. Pemeriksaan BCNF (Boyce-Codd Normal Form)
Pemeriksaan dilakukan pada setiap relasi hasil 3NF:
* **Tabel PEMINJAMAN:** Penentu `id_peminjaman` adalah *candidate key*. (Lolos BCNF)
* **Tabel DETAIL_PEMINJAMAN:** Penentu `(id_peminjaman, id_buku)` adalah *candidate key*. (Lolos BCNF)
* **Tabel BUKU:** Penentu `id_buku` adalah *candidate key*. (Lolos BCNF)
* **Tabel ANGGOTA:** Penentu `id_anggota` adalah *candidate key*. (Lolos BCNF)

*Kesimpulan BCNF:* Seluruh relasi telah memenuhi BCNF karena semua penentu (*determinant*) merupakan *candidate key*.

### Langkah 4: Keputusan Nilai Turunan (Derived Value)

Berdasarkan analisis normalisasi dan prinsip integritas data operasional:

1. **Atribut `total_buku_dipinjam`:**
   * **Keputusan:** Tidak disimpan sebagai kolom di tabel `PEMINJAMAN`.
   * **Alasan:** Nilai ini merupakan nilai turunan yang dapat dihitung secara dinamis menggunakan query SQL (`COUNT` / `SUM(jumlah_buku)`) dari tabel `DETAIL_PEMINJAMAN`. Menyimpan nilai ini di tabel operasional berisiko menyebabkan *redundancy* dan ketidakkonsistenan data jika terjadi pembaruan detail transaksi.

2. **Atribut `total_denda`:**
   * **Keputusan:** Tidak disimpan pada tabel operasional transaksi harian.
   * **Alasan:** Denda dihitung berdasarkan selisih `tanggal_kembali` dan `tanggal_jatuh_tempo` dikalikan tarif denda per hari. Pada tabel operasional, nilai dihitung secara *real-time*. (Nilai ini baru akan dibekukan/disimpan tetap apabila data telah masuk ke tabel arsip/historis transaksi).

---

## Kesimpulan

Seluruh tahapan normalisasi dari UNF hingga 3NF serta verifikasi BCNF untuk proyek **Perpustakaan Cendekia** telah selasai disusun. Struktur tabel hasil 3NF siap dijadikan acuan utama dalam pembuatan skrip DDL (*Data Definition Language*) pada Pertemuan 5.
