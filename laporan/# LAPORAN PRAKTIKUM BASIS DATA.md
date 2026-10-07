# LAPORAN PRAKTIKUM BASIS DATA

## Modul 1 – Lingkungan Kerja MariaDB dan Git

### A. Tujuan

Praktikum ini dilakukan untuk memahami penggunaan MariaDB sebagai database serta penggunaan Git dan GitHub untuk menyimpan hasil pekerjaan. Selain itu, praktikum ini juga bertujuan untuk memahami hak akses user pada database dan membuat file SQL yang dapat dijalankan lebih dari satu kali tanpa menimbulkan error.

---

## B. Lingkungan yang Digunakan

Pada praktikum ini saya menggunakan:

* Sistem operasi: Windows
* XAMPP
* MariaDB 10.4.32
* phpMyAdmin
* Git
* GitHub
* Visual Studio Code
* Folder kerja: `D:\BASIS DATA_25430007`
* NIM: `25430007`
* Tiga digit terakhir NIM: `007`

Database yang digunakan adalah:

`kopma_007`

---

# C. Praktikum Git dan GitHub

Pertama saya membuat folder kerja untuk menyimpan file praktikum, yaitu:

`D:\BASIS DATA_25430007`

Kemudian folder tersebut digunakan sebagai repository Git.

Setelah Git berhasil digunakan, saya menghubungkan repository lokal dengan repository GitHub:

`basisdata-25430007`

Repository GitHub yang digunakan:

`mkhoi3353-creator/basisdata-25430007`

Pada awalnya saya sempat menjalankan `git add .`, sehingga folder `Git` yang berisi banyak file ikut terbaca sebagai file yang akan dimasukkan ke repository. Setelah dicek menggunakan `git status`, file-file tersebut kemudian dikeluarkan dari staging.

Setelah itu hanya file yang diperlukan, terutama folder `IMAGE`, yang dimasukkan ke staging.

Perintah yang digunakan antara lain:

```text
git status
git reset
git add IMAGE
git log --oneline --all
git remote -v
git push -u origin master
```

Hasil akhirnya repository berhasil di-push ke GitHub. Folder `IMAGE` yang berisi dua gambar hasil praktikum juga sudah muncul di repository GitHub.

---

# D. Praktikum MariaDB

MariaDB dijalankan melalui XAMPP. Untuk menjalankan perintah MariaDB melalui terminal, saya menggunakan XAMPP Shell karena perintah `mysql` tidak langsung dikenali melalui CMD biasa.

Versi MariaDB yang digunakan adalah:

```text
10.4.32-MariaDB
```

Saya berhasil masuk sebagai user `root` menggunakan perintah:

```text
mysql -u root -p
```

Setelah berhasil masuk, praktikum dilanjutkan dengan membuat database dan user.

Database yang digunakan:

```sql
kopma_007
```

---

# E. Pengaturan Hak Akses User

## E.1 Membuat User Tamu

Saya membuat user khusus untuk pengujian hak akses dengan nama:

```text
tamu_007
```

User tersebut diberikan hak akses hanya untuk melakukan `SELECT` pada database `kopma_007`.

Perintah yang digunakan:

```sql
CREATE USER 'tamu_007'@'localhost' IDENTIFIED BY 'tamu123';

GRANT SELECT ON kopma_007.* TO 'tamu_007'@'localhost';
```

Setelah itu saya mencoba login menggunakan user `tamu_007`.

Pada percobaan pertama sempat muncul:

```text
ERROR 1045 (28000): Access denied for user 'tamu_007'@'localhost'
```

Setelah password user diperbaiki dari akun `root`, user `tamu_007` berhasil digunakan untuk login.

---

## Percobaan Membuat Tabel

Setelah login sebagai `tamu_007`, saya mencoba membuat tabel dengan perintah:

```sql
CREATE TABLE uji (id INT);
```

Pada percobaan pertama muncul:

```text
ERROR 1046 (3D000): No database selected
```

Hal ini terjadi karena database belum dipilih.

Kemudian saya memilih database:

```sql
USE kopma_007;
```

Setelah itu perintah membuat tabel dijalankan kembali.

Hasilnya:

```text
ERROR 1142 (42000): CREATE command denied to user 'tamu_007'@'localhost' for table 'kopma_007.uji'
```

Error tersebut memang sesuai dengan tujuan pengujian. User `tamu_007` hanya mempunyai hak `SELECT`, sehingga tidak mempunyai izin untuk menjalankan perintah `CREATE TABLE`.

Dengan kata lain, user tersebut masih dapat membaca data, tetapi tidak dapat membuat tabel baru.

---

# F. Perbaikan File SQL

Pada bagian berikutnya saya melakukan pengecekan terhadap file SQL lingkungan kerja.

Isi awal file memiliki beberapa bagian yang perlu diperbaiki.

Salah satu kesalahan yang ditemukan adalah nama user pada perintah `GRANT`. Terdapat penulisan:

```sql
'mhs_077'
```

yang seharusnya:

```sql
'mhs_007'
```

Selain itu, user `tamu_007` pada awalnya diberikan:

```sql
GRANT ALL PRIVILEGES
```

Sedangkan sesuai dengan kebutuhan praktikum, user tersebut seharusnya hanya mempunyai hak `SELECT`.

Perintah tersebut kemudian diperbaiki menjadi:

```sql
GRANT SELECT ON kopma_007.* TO 'tamu_007'@'localhost';
```

Bagian pembuatan database dan user juga dibuat menggunakan `IF NOT EXISTS`, contohnya:

```sql
CREATE DATABASE IF NOT EXISTS kopma_007
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

dan:

```sql
CREATE USER IF NOT EXISTS 'mhs_007'@'localhost'
IDENTIFIED BY 'Kanade1212';
```

Dengan menggunakan `IF NOT EXISTS`, perintah tidak akan menghasilkan error hanya karena database atau user tersebut sudah pernah dibuat.

---

# G. Kendala Saat Menjalankan File SQL

Saat pertama kali menjalankan file SQL, sempat terjadi error syntax.

Penyebabnya adalah di dalam file masih terdapat tanda Markdown:

````text
```sql
````

dan:

```text
```

````

Tanda tersebut bukan bagian dari sintaks SQL sehingga MariaDB menganggapnya sebagai perintah yang tidak dikenal.

Tanda tersebut kemudian dihapus dari file sehingga isi file hanya berupa perintah SQL.

Selain itu, nama file yang digunakan ternyata berbeda dari nama file yang sebelumnya saya kira. Nama file yang terdapat di folder XAMPP adalah:

```text
scril file p01_lingkungan 1.sql
````

Karena terdapat spasi pada nama file, saat menjalankannya digunakan tanda kutip:

```text
mysql -u root -p < "scril file p01_lingkungan 1.sql"
```

Setelah file diperbaiki, perintah tersebut berhasil dijalankan tanpa menghasilkan pesan error.

---

# H. Pengujian Menjalankan Script Dua Kali

Untuk memastikan script dapat dijalankan berulang kali, file SQL dijalankan sebanyak dua kali.

Percobaan pertama:

```text
mysql -u root -p < "scril file p01_lingkungan 1.sql"
```

Hasilnya tidak muncul error.

Kemudian perintah yang sama dijalankan kembali untuk kedua kalinya.

Hasilnya juga tidak muncul error.

Hal ini menunjukkan bahwa script sudah dapat dijalankan kembali tanpa mengalami masalah karena database dan user menggunakan `IF NOT EXISTS`.

---

# I. Kendala pada phpMyAdmin

Setelah bagian MariaDB selesai, saya juga mencoba membuka phpMyAdmin.

Pada awalnya muncul pesan:

```text
Access denied for user 'root'@'localhost' (using password: NO)
```

Masalah tersebut terjadi karena konfigurasi phpMyAdmin sebelumnya mencoba melakukan koneksi sebagai `root` tanpa password.

Setelah diperiksa pada file:

```text
D:\xampp\phpMyAdmin\config.inc.php
```

bagian authentication sudah menggunakan:

```php
$cfg['Servers'][$i]['auth_type'] = 'cookie';
```

Setelah konfigurasi disimpan dan halaman phpMyAdmin dibuka kembali, muncul halaman login.

Saya kemudian login menggunakan:

```text
Username : root
Password : password root MariaDB
```

Setelah login berhasil, phpMyAdmin dapat digunakan kembali.

---

# J. Kesimpulan

Dari praktikum ini saya memahami beberapa hal dasar yang berkaitan dengan pengelolaan database dan repository.

Pada bagian Git, saya belajar membuat repository lokal, melihat status file, melakukan staging, membuat commit, menghubungkan repository dengan GitHub, dan melakukan push.

Pada bagian MariaDB, saya belajar membuat database dan user serta memberikan hak akses tertentu kepada user. Dari percobaan `tamu_007`, terlihat bahwa hak akses sangat berpengaruh terhadap perintah yang dapat dijalankan oleh user.

Saya juga memahami bahwa error yang muncul tidak selalu berasal dari database. Beberapa masalah yang terjadi berasal dari pemilihan database, kesalahan penulisan nama user, isi file SQL yang tidak sesuai, nama file yang berbeda, dan konfigurasi phpMyAdmin.

Setelah semua bagian diperbaiki, repository GitHub sudah berhasil digunakan, database dapat diakses, user tamu berhasil diuji, file SQL dapat dijalankan dua kali, dan phpMyAdmin dapat digunakan untuk login ke database.

---

# K. Checklist Sebelum Dikumpulkan

| No | Bagian                                                 | Status |
| -- | ------------------------------------------------------ | ------ |
| 1  | Folder project `BASIS DATA_25430007` sudah dibuat      | ☑      |
| 2  | Git repository sudah dibuat                            | ☑      |
| 3  | Repository sudah terhubung ke GitHub                   | ☑      |
| 4  | File/gambar praktikum sudah masuk ke GitHub            | ☑      |
| 5  | Database `kopma_007` sudah dibuat                      | ☑      |
| 6  | User `tamu_007` sudah dibuat                           | ☑      |
| 7  | Hak akses `SELECT` sudah diberikan ke `tamu_007`       | ☑      |
| 8  | Percobaan `CREATE TABLE` sudah dilakukan               | ☑      |
| 9  | Error `1046` sudah dicatat dan dijelaskan              | ☑      |
| 10 | Error `1142` sudah dicatat dan dijelaskan              | ☑      |
| 11 | Kesalahan `mhs_077` sudah diperbaiki menjadi `mhs_007` | ☑      |
| 12 | Hak akses `tamu_007` sudah diperbaiki menjadi `SELECT` | ☑      |
| 13 | Tanda Markdown di file SQL sudah dihapus               | ☑      |
| 14 | Script SQL berhasil dijalankan pertama kali            | ☑      |
| 15 | Script SQL berhasil dijalankan kedua kali              | ☑      |
| 16 | phpMyAdmin sudah berhasil login                        | ☑      |
| 17 | Screenshot hasil/error penting sudah disiapkan         | ☐      |
| 18 | Laporan sudah dicek kembali sebelum dikumpulkan        | ☐      |

### Screenshot yang sebaiknya dilampirkan

Tidak perlu memasukkan semua screenshot. Yang paling penting adalah:

1. Screenshot saat muncul **ERROR 1142** ketika `tamu_007` mencoba membuat tabel.
2. Screenshot file SQL yang sudah diperbaiki.
3. Screenshot saat script berhasil dijalankan pertama kali.
4. Screenshot saat script berhasil dijalankan kedua kali.
5. Screenshot repository GitHub yang menunjukkan hasil push.
6. Jika diperlukan, screenshot phpMyAdmin setelah berhasil login.

---

# Modul 2 – Analisis Kebutuhan Pengelolaan Data

## A. Tujuan

Modul 2 bertujuan untuk menganalisis kebutuhan pengelolaan data pada organisasi, meliputi aktor, proses bisnis, dokumen sumber, entitas kandidat, aturan bisnis, kebutuhan informasi, matriks CRUD, kamus data, dan kebutuhan non-fungsional.

Pada modul ini digunakan studi kasus Koperasi Mahasiswa (Kopma).

## B. Organisasi dan Aktivitas

Koperasi Mahasiswa (Kopma) adalah organisasi fiktif yang menyediakan berbagai kebutuhan mahasiswa, seperti alat tulis, makanan ringan, minuman, dan kebutuhan perkuliahan lainnya.

Aktivitas utama Kopma meliputi pendaftaran anggota, pengelolaan data barang, transaksi penjualan, pengelolaan stok, pemesanan barang dari pemasok, penerimaan barang, serta penyusunan laporan penjualan dan persediaan.

## C. Aktor dan Proses Bisnis

### Aktor

| Kode | Aktor | Peran |
|---|---|---|
| A-01 | Ketua Kopma | Mengawasi kegiatan koperasi dan melihat laporan |
| A-02 | Kasir | Melayani dan mencatat transaksi penjualan |
| A-03 | Petugas Gudang | Mengelola stok dan menerima barang |
| A-04 | Petugas Pembelian | Melakukan pemesanan barang kepada pemasok |
| A-05 | Anggota | Membeli barang dan menggunakan layanan Kopma |
| A-06 | Pemasok | Menyediakan barang yang dibutuhkan Kopma |

### Proses Bisnis

| Kode | Proses Bisnis | Aktor Utama |
|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir |
| PB-02 | Mencatat penjualan | Kasir |
| PB-03 | Mengelola data dan stok barang | Petugas Gudang |
| PB-04 | Mengelola pemasok dan memesan barang | Petugas Pembelian |
| PB-05 | Menerima barang dari pemasok | Petugas Gudang |
| PB-06 | Menyusun laporan penjualan dan persediaan | Ketua Kopma |

## D. Dokumen Sumber

Dokumen sumber yang dianalisis adalah:

| Kode | Dokumen | Kegunaan |
|---|---|---|
| DS-01 | Nota Penjualan | Mencatat transaksi penjualan |
| DS-02 | Formulir Pendaftaran Anggota | Mencatat data anggota |
| DS-03 | Formulir Pemesanan Barang | Mencatat pemesanan barang kepada pemasok |
| DS-04 | Formulir Penerimaan Barang | Mencatat barang yang diterima |

## E. Entitas Kandidat

| Kode | Entitas | Keterangan |
|---|---|---|
| E-01 | Anggota | Data anggota Kopma |
| E-02 | Barang | Data barang yang dijual |
| E-03 | Transaksi Penjualan | Data transaksi penjualan |
| E-04 | Detail Penjualan | Rincian barang dalam transaksi |
| E-05 | Pemasok | Data pemasok barang |
| E-06 | Pemesanan | Data pemesanan barang |
| E-07 | Penerimaan Barang | Data barang yang diterima |
| E-08 | Stok | Informasi jumlah persediaan barang |

## F. Aturan Bisnis

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap anggota memiliki ID anggota yang unik. |
| AB-02 | Setiap barang memiliki ID barang yang unik. |
| AB-03 | Setiap transaksi penjualan harus memiliki minimal satu barang. |
| AB-04 | Jumlah barang dalam satu transaksi maksimal 10 item. |
| AB-05 | Stok barang tidak boleh bernilai negatif. |
| AB-06 | Setiap pemesanan barang harus ditujukan kepada satu pemasok. |
| AB-07 | Barang yang diterima dari pemasok harus dicatat sebelum menambah jumlah stok. |
| AB-08 | Diskon atau denda yang diterapkan pada transaksi menggunakan persentase maksimal 8% sesuai parameter P. |

## G. Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Pengguna |
|---|---|---|
| KI-01 | Mengetahui daftar dan jumlah stok barang yang tersedia. | Petugas Gudang |
| KI-02 | Mengetahui riwayat transaksi penjualan berdasarkan periode tertentu. | Ketua Kopma |
| KI-03 | Mengetahui total penjualan Kopma berdasarkan periode tertentu. | Ketua Kopma |
| KI-04 | Mengetahui daftar anggota yang terdaftar di Kopma. | Kasir |
| KI-05 | Mengetahui daftar pemesanan dan penerimaan barang dari pemasok. | Petugas Pembelian dan Petugas Gudang |

## H. Matriks CRUD

| Proses / Entitas | Anggota | Barang | Transaksi Penjualan | Detail Penjualan | Pemasok | Pemesanan | Penerimaan Barang | Stok |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan anggota | C |  |  |  |  |  |  |  |
| PB-02 Mencatat penjualan | R | R | C | C |  |  |  | U |
| PB-03 Mengelola data dan stok barang |  | C/U |  |  |  |  |  | C/U |
| PB-04 Mengelola pemasok dan memesan barang |  | R |  |  | C/U | C |  |  |
| PB-05 Menerima barang dari pemasok |  | R |  |  | R | R | C | U |
| PB-06 Menyusun laporan penjualan dan persediaan | R | R | R | R | R | R | R | R |

Keterangan: C = Create, R = Read, U = Update.

## I. Kamus Data

Kamus data awal terdiri dari minimal 20 elemen data, antara lain:

| Elemen Data | Makna | Contoh | Aturan | Pemilik |
|---|---|---|---|---|
| ID Anggota | Identitas unik anggota | AGT001 | Wajib dan unik | Kasir |
| Nama Anggota | Nama anggota | Andi Saputra | Wajib diisi | Kasir |
| Nomor Telepon | Nomor kontak anggota | 081234567890 | Format nomor telepon | Kasir |
| Program Studi | Program studi anggota | Informatika | Wajib diisi | Kasir |
| ID Barang | Identitas unik barang | BRG001 | Wajib dan unik | Petugas Gudang |
| Nama Barang | Nama barang | Buku Tulis | Wajib diisi | Petugas Gudang |
| Kategori | Jenis barang | Alat Tulis | Wajib diisi | Petugas Gudang |
| Harga Jual | Harga barang | 15000 | Lebih dari 0 | Petugas Gudang |
| Stok | Jumlah barang tersedia | 50 | Tidak boleh negatif | Petugas Gudang |
| ID Transaksi | Identitas transaksi | TRX001 | Wajib dan unik | Kasir |
| Tanggal Transaksi | Tanggal transaksi | 2026-10-07 | Wajib diisi | Kasir |
| Total Transaksi | Nilai total transaksi | 75000 | Tidak negatif | Kasir |
| ID Pemasok | Identitas pemasok | SUP001 | Wajib dan unik | Petugas Pembelian |
| Nama Pemasok | Nama pemasok | CV Sumber Jaya | Wajib diisi | Petugas Pembelian |
| Nomor Telepon Pemasok | Nomor kontak pemasok | 081298765432 | Format nomor telepon | Petugas Pembelian |
| ID Pemesanan | Identitas pemesanan | PO001 | Wajib dan unik | Petugas Pembelian |
| Tanggal Pemesanan | Tanggal pemesanan | 2026-10-07 | Wajib diisi | Petugas Pembelian |
| ID Penerimaan | Identitas penerimaan | RC001 | Wajib dan unik | Petugas Gudang |
| Jumlah Barang | Jumlah barang | 5 | Bilangan bulat > 0 | Kasir/Petugas Gudang |
| Harga Beli | Harga barang dari pemasok | 10000 | Lebih dari 0 | Petugas Pembelian |

## J. Kebutuhan Non-Fungsional

Parameter P dihitung dari dua digit terakhir NIM:

```text
P = (07 mod 9) + 1
P = 7 + 1
P = 8
