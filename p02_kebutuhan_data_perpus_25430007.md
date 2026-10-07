# Laporan Modul 2: Analisis Kebutuhan Data Proyek Basis Data

## 1. Informasi Proyek
* **Nama**: Muhammad Khoirudin
* **NIM**: 25430007
* **Kelas**: A
* **Tema Proyek**: Perpustakaan
* **Nama Organisasi Fiktif**: Perpustakaan Cendekia
* **Lingkup Layanan**: Menyediakan layanan perpustakaan yang meliputi pendaftaran anggota, pengelolaan koleksi buku, pencarian buku, peminjaman dan pengembalian buku, serta pengelolaan denda keterlambatan.

---

## 2. Analisis Kebutuhan Data (Entitas & Atribut)

### A. Entitas `anggota`
Menyimpan data anggota perpustakaan yang terdaftar.
* `id_anggota` (Primary Key)
* `nama`
* `alamat`
* `no_telepon`
* `email`
* `tanggal_daftar`

### B. Entitas `kategori`
Menyimpan data kategori/genre buku.
* `id_kategori` (Primary Key)
* `nama_kategori`

### C. Entitas `buku`
Menyimpan koleksi buku yang tersedia di perpustakaan.
* `id_buku` (Primary Key)
* `judul`
* `pengarang`
* `penerbit`
* `tahun_terbit`
* `isbn`
* `stok`
* `id_kategori` (Foreign Key)

### D. Entitas `peminjaman`
Menyimpan transaksi peminjaman buku oleh anggota.
* `id_peminjaman` (Primary Key)
* `id_anggota` (Foreign Key)
* `tanggal_pinjam`
* `tanggal_jatuh_tempo`
* `status` (dipinjam / selesai)

### E. Entitas `detail_peminjaman`
Menyimpan rincian buku yang dipinjam dalam satu transaksi peminjaman.
* `id_detail` (Primary Key)
* `id_peminjaman` (Foreign Key)
* `id_buku` (Foreign Key)
* `jumlah`

### F. Entitas `pengembalian`
Menyimpan data transaksi pengembalian buku beserta denda keterlambatan (jika ada).
* `id_pengembalian` (Primary Key)
* `id_peminjaman` (Foreign Key)
* `tanggal_kembali`
* `denda`
