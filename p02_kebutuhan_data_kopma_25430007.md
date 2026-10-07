# Dokumen Kebutuhan Data - Koperasi Mahasiswa (Kopma)

## 1. Latar belakang dan aktivitas organisasi

Koperasi Mahasiswa (Kopma) adalah organisasi fiktif yang menyediakan berbagai kebutuhan mahasiswa, seperti alat tulis, makanan ringan, minuman, dan kebutuhan perkuliahan lainnya.

Aktivitas utama Kopma meliputi pendaftaran anggota, pengelolaan data barang, transaksi penjualan, pengelolaan stok, pemesanan barang dari pemasok, serta penyusunan laporan penjualan dan persediaan.

Pengelolaan data diperlukan agar informasi anggota, barang, transaksi, pemasok, pemesanan, dan persediaan dapat dicatat secara terstruktur serta digunakan untuk mendukung kegiatan operasional dan pembuatan laporan.

## 2. Aktor dan proses bisnis

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

## 3. Dokumen sumber yang dianalisis

Dokumen sumber yang digunakan untuk mengidentifikasi kebutuhan data Kopma adalah:

| Kode | Dokumen Sumber | Keterangan |
|---|---|---|
| DS-01 | Nota Penjualan | Digunakan untuk mencatat transaksi penjualan barang kepada anggota |
| DS-02 | Formulir Pendaftaran Anggota | Digunakan untuk mencatat data anggota Kopma |
| DS-03 | Formulir Pemesanan Barang | Digunakan untuk mencatat pemesanan barang kepada pemasok |
| DS-04 | Formulir Penerimaan Barang | Digunakan untuk mencatat barang yang diterima dari pemasok |

Dokumen sumber tersebut digunakan sebagai dasar untuk menentukan elemen data yang diperlukan dalam pengelolaan data Kopma.

## 4. Entitas kandidat dan elemen data

### Entitas Kandidat

| Kode | Entitas | Keterangan |
|---|---|---|
| E-01 | Anggota | Menyimpan data anggota Kopma |
| E-02 | Barang | Menyimpan data barang yang dijual |
| E-03 | Transaksi Penjualan | Menyimpan data transaksi penjualan |
| E-04 | Detail Penjualan | Menyimpan rincian barang dalam setiap transaksi |
| E-05 | Pemasok | Menyimpan data pemasok barang |
| E-06 | Pemesanan | Menyimpan data pemesanan barang kepada pemasok |
| E-07 | Penerimaan Barang | Menyimpan data barang yang diterima dari pemasok |
| E-08 | Stok | Menyimpan informasi jumlah persediaan barang |

### Elemen Data Awal

| Elemen Data | Digunakan Pada | Keterangan |
|---|---|---|
| ID Anggota | Anggota | Identitas unik anggota |
| Nama Anggota | Anggota | Nama lengkap anggota |
| Nomor Telepon | Anggota | Nomor kontak anggota |
| Program Studi | Anggota | Program studi anggota |
| ID Barang | Barang | Identitas unik barang |
| Nama Barang | Barang | Nama barang |
| Kategori | Barang | Kategori barang |
| Harga Jual | Barang | Harga jual barang |
| Stok | Stok | Jumlah barang yang tersedia |
| ID Transaksi | Transaksi Penjualan | Identitas unik transaksi |
| Tanggal Transaksi | Transaksi Penjualan | Tanggal transaksi penjualan |
| Total Transaksi | Transaksi Penjualan | Nilai total transaksi |
| ID Pemasok | Pemasok | Identitas unik pemasok |
| Nama Pemasok | Pemasok | Nama pemasok |
| Nomor Telepon Pemasok | Pemasok | Nomor kontak pemasok |

## 5. Aturan bisnis

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap anggota memiliki ID anggota yang unik. |
| AB-02 | Setiap barang memiliki ID barang yang unik. |
| AB-03 | Setiap transaksi penjualan harus memiliki minimal satu barang. |
| AB-04 | Jumlah barang yang dapat dicatat dalam satu transaksi maksimal 10 item. |
| AB-05 | Stok barang tidak boleh bernilai negatif. |
| AB-06 | Setiap pemesanan barang harus ditujukan kepada satu pemasok. |
| AB-07 | Barang yang diterima dari pemasok harus dicatat sebelum menambah jumlah stok. |
| AB-08 | Diskon atau denda yang diterapkan pada transaksi menggunakan persentase maksimal 8% sesuai parameter P. |

## 6. Kebutuhan informasi

| Kode | Kebutuhan Informasi | Pengguna |
|---|---|---|
| KI-01 | Mengetahui daftar dan jumlah stok barang yang tersedia. | Petugas Gudang |
| KI-02 | Mengetahui riwayat transaksi penjualan berdasarkan periode tertentu. | Ketua Kopma |
| KI-03 | Mengetahui total penjualan Kopma berdasarkan periode tertentu. | Ketua Kopma |
| KI-04 | Mengetahui daftar anggota yang terdaftar di Kopma. | Kasir |
| KI-05 | Mengetahui daftar pemesanan dan penerimaan barang dari pemasok. | Petugas Pembelian dan Petugas Gudang |

## 7. Matriks CRUD

| Proses / Entitas | Anggota | Barang | Transaksi Penjualan | Detail Penjualan | Pemasok | Pemesanan | Penerimaan Barang | Stok |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan anggota | C |  |  |  |  |  |  |  |
| PB-02 Mencatat penjualan | R | R | C | C |  |  |  | U |
| PB-03 Mengelola data dan stok barang |  | C/U |  |  |  |  |  | C/U |
| PB-04 Mengelola pemasok dan memesan barang |  | R |  |  | C/U | C |  |  |
| PB-05 Menerima barang dari pemasok |  | R |  |  | R | R | C | U |
| PB-06 Menyusun laporan penjualan dan persediaan | R | R | R | R | R | R | R | R |

Keterangan: C = Create, R = Read, U = Update.

## 8. Kamus data awal

| Elemen Data | Makna | Contoh | Aturan | Pemilik |
|---|---|---|---|---|
| ID Anggota | Identitas unik anggota | AGT001 | Wajib dan unik | Kasir |
| Nama Anggota | Nama anggota | Andi Saputra | Wajib diisi | Kasir |
| Nomor Telepon | Nomor kontak anggota | 081234567890 | Format nomor telepon | Kasir |
| Program Studi | Program studi anggota | Informatika | Wajib diisi | Kasir |
| ID Barang | Identitas unik barang | BRG001 | Wajib dan unik | Petugas Gudang |
| Nama Barang | Nama barang | Buku Tulis | Wajib diisi | Petugas Gudang |
| Kategori | Jenis atau kelompok barang | Alat Tulis | Wajib diisi | Petugas Gudang |
| Harga Jual | Harga barang yang dijual | 15000 | Nilai lebih dari 0 | Petugas Gudang |
| Stok | Jumlah barang tersedia | 50 | Tidak boleh negatif | Petugas Gudang |
| ID Transaksi | Identitas unik transaksi | TRX001 | Wajib dan unik | Kasir |
| Tanggal Transaksi | Tanggal terjadinya transaksi | 2026-10-07 | Wajib diisi | Kasir |
| Total Transaksi | Nilai total transaksi | 75000 | Nilai tidak negatif | Kasir |
| ID Pemasok | Identitas unik pemasok | SUP001 | Wajib dan unik | Petugas Pembelian |
| Nama Pemasok | Nama pemasok barang | CV Sumber Jaya | Wajib diisi | Petugas Pembelian |
| Nomor Telepon Pemasok | Nomor kontak pemasok | 081298765432 | Format nomor telepon | Petugas Pembelian |
| ID Pemesanan | Identitas unik pemesanan | PO001 | Wajib dan unik | Petugas Pembelian |
| Tanggal Pemesanan | Tanggal pemesanan barang | 2026-10-07 | Wajib diisi | Petugas Pembelian |
| ID Penerimaan | Identitas unik penerimaan barang | RC001 | Wajib dan unik | Petugas Gudang |
| Jumlah Barang | Jumlah barang dalam transaksi/penerimaan | 5 | Bilangan bulat lebih dari 0 | Kasir/Petugas Gudang |
| Harga Beli | Harga barang dari pemasok | 10000 | Nilai lebih dari 0 | Petugas Pembelian |

## 9. Kebutuhan non-fungsional data

Parameter P untuk proyek ini adalah 8 berdasarkan NIM 25430007. Dengan demikian, maksimal item dalam satu transaksi adalah 10 item, persentase diskon/denda adalah 8%, dan perkiraan volume transaksi adalah 80 transaksi per hari.

### Volume Data

Kopma diperkirakan memiliki volume sekitar 80 transaksi per hari. Sistem harus mampu menangani maksimal 10 item dalam satu transaksi.

### Retensi Data

Data transaksi penjualan, pemesanan, penerimaan barang, anggota, dan persediaan perlu disimpan untuk mendukung pelacakan transaksi dan pembuatan laporan.

### Privasi dan Akses Data

Data anggota seperti nama, nomor telepon, dan program studi termasuk data yang perlu dilindungi. Akses terhadap data anggota dibatasi kepada pengguna yang memiliki hak akses sesuai tugasnya.

### Kebutuhan Keamanan

Setiap pengguna sistem harus memiliki hak akses sesuai perannya. Data transaksi dan data persediaan tidak boleh diubah oleh pengguna yang tidak berwenang.

## 10. Isu kualitas data yang diantisipasi

Beberapa isu kualitas data yang dapat terjadi pada Kopma adalah:

1. Data anggota dapat tercatat lebih dari satu kali jika tidak dilakukan pemeriksaan terhadap ID anggota.
2. Data barang dapat memiliki nama atau kategori yang tidak konsisten.
3. Harga barang dapat salah input sehingga memengaruhi perhitungan transaksi.
4. Jumlah stok dapat tidak sesuai dengan kondisi barang yang sebenarnya jika transaksi penerimaan atau penjualan tidak dicatat dengan benar.
5. Data transaksi dapat memiliki informasi yang tidak lengkap, seperti tanggal atau detail barang.
6. Data nomor telepon anggota atau pemasok dapat memiliki format yang tidak konsisten.
7. Data pemesanan dan penerimaan barang dapat tidak sesuai jika jumlah barang yang diterima berbeda dengan jumlah yang dipesan.
8. Data transaksi perlu dijaga agar tidak diubah oleh pengguna yang tidak memiliki hak akses.
