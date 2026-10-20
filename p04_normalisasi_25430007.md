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
