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
