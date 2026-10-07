# Dokumen Kebutuhan Data - PixelMart

## 1. Latar belakang dan aktivitas organisasi

PixelMart adalah organisasi fiktif berupa toko komputer dan aksesoris yang menjual laptop, komputer, komponen komputer, dan berbagai aksesoris kepada pelanggan umum maupun pelanggan terdaftar.

Aktivitas utama PixelMart meliputi pendaftaran pelanggan, pengelolaan data barang, transaksi penjualan, pengelolaan stok, pemesanan barang kepada pemasok, penerimaan barang dari pemasok, serta penyusunan laporan kegiatan penjualan dan persediaan.

Pengelolaan data diperlukan agar informasi pelanggan, barang, transaksi, pemasok, pemesanan, dan persediaan dapat dicatat secara terstruktur serta dapat digunakan untuk mendukung kegiatan operasional dan pembuatan laporan.

## 2. Aktor dan proses bisnis

### Aktor

| Kode | Aktor | Peran |
|---|---|---|
| A-01 | Pemilik | Mengawasi kegiatan usaha dan melihat laporan |
| A-02 | Kasir | Melayani dan mencatat transaksi penjualan |
| A-03 | Petugas Gudang | Mengelola stok dan menerima barang |
| A-04 | Petugas Pembelian | Melakukan pemesanan barang kepada pemasok |
| A-05 | Pelanggan | Membeli barang dari PixelMart |
| A-06 | Pemasok | Menyediakan barang yang dibutuhkan PixelMart |

### Proses Bisnis

| Kode | Proses Bisnis | Aktor Utama |
|---|---|---|
| PB-01 | Mendaftarkan pelanggan | Kasir |
| PB-02 | Mencatat penjualan | Kasir |
| PB-03 | Mengelola stok barang | Petugas Gudang |
| PB-04 | Memesan barang kepada pemasok | Petugas Pembelian |
| PB-05 | Menerima barang dari pemasok | Petugas Gudang |
| PB-06 | Menyusun laporan penjualan dan persediaan | Pemilik |

## 3. Dokumen sumber yang dianalisis

Dokumen sumber yang digunakan untuk mengidentifikasi kebutuhan data PixelMart adalah:

| Kode | Dokumen Sumber | Keterangan |
|---|---|---|
| DS-01 | Nota Penjualan | Digunakan untuk mencatat transaksi penjualan barang kepada pelanggan |
| DS-02 | Formulir Pendaftaran Pelanggan | Digunakan untuk mencatat data pelanggan yang terdaftar |
| DS-03 | Formulir Pemesanan Barang | Digunakan untuk mencatat pemesanan barang kepada pemasok |
| DS-04 | Formulir Penerimaan Barang | Digunakan untuk mencatat barang yang diterima dari pemasok |

Dokumen sumber tersebut digunakan sebagai dasar untuk menentukan elemen data yang diperlukan dalam pengelolaan data PixelMart.

## 4. Entitas kandidat dan elemen data

### Entitas Kandidat

| Kode | Entitas | Keterangan |
|---|---|---|
| E-01 | Pelanggan | Menyimpan data pelanggan PixelMart |
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
| ID Pelanggan | Pelanggan | Identitas unik pelanggan |
| Nama Pelanggan | Pelanggan | Nama lengkap pelanggan |
| Nomor Telepon | Pelanggan | Nomor kontak pelanggan |
| Alamat | Pelanggan | Alamat pelanggan |
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
| AB-01 | Setiap pelanggan memiliki ID pelanggan yang unik. |
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
| KI-02 | Mengetahui riwayat transaksi penjualan berdasarkan periode tertentu. | Pemilik |
| KI-03 | Mengetahui total penjualan PixelMart berdasarkan periode tertentu. | Pemilik |
| KI-04 | Mengetahui daftar pelanggan yang terdaftar di PixelMart. | Kasir |
| KI-05 | Mengetahui daftar pemesanan dan penerimaan barang dari pemasok. | Petugas Pembelian dan Petugas Gudang |

## 7. Matriks CRUD

| Proses / Entitas | Pelanggan | Barang | Transaksi Penjualan | Detail Penjualan | Pemasok | Pemesanan | Penerimaan Barang | Stok |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan pelanggan | C |  |  |  |  |  |  |  |
| PB-02 Mencatat penjualan | R | R | C | C |  |  |  | U |
| PB-03 Mengelola stok barang |  | R |  |  |  |  |  | C/U |
| PB-04 Memesan barang kepada pemasok |  | R |  |  | R | C |  |  |
| PB-05 Menerima barang dari pemasok |  | R |  |  | R | R | C | U |
| PB-06 Menyusun laporan penjualan dan persediaan | R | R | R | R | R | R | R | R |

Keterangan: C = Create, R = Read, U = Update.

## 8. Kamus data awal

| Elemen Data | Makna | Contoh | Aturan | Pemilik |
|---|---|---|---|---|
| ID Pelanggan | Identitas unik pelanggan | PLG001 | Wajib dan unik | Kasir |
| Nama Pelanggan | Nama pelanggan | Budi Santoso | Wajib diisi | Kasir |
| Nomor Telepon | Nomor kontak pelanggan | 081234567890 | Format nomor telepon | Kasir |
| Alamat | Alamat pelanggan | Jl. Merdeka No. 10 | Boleh kosong | Kasir |
| ID Barang | Identitas unik barang | BRG001 | Wajib dan unik | Petugas Gudang |
| Nama Barang | Nama barang | Keyboard Mechanical | Wajib diisi | Petugas Gudang |
| Kategori | Jenis atau kelompok barang | Aksesoris | Wajib diisi | Petugas Gudang |
| Harga Jual | Harga barang yang dijual | 750000 | Nilai lebih dari 0 | Petugas Gudang |
| Stok | Jumlah barang tersedia | 25 | Tidak boleh negatif | Petugas Gudang |
| ID Transaksi | Identitas unik transaksi | TRX001 | Wajib dan unik | Kasir |
| Tanggal Transaksi | Tanggal terjadinya transaksi | 2026-10-07 | Wajib diisi | Kasir |
| Total Transaksi | Nilai total transaksi | 1500000 | Nilai tidak negatif | Kasir |
| ID Pemasok | Identitas unik pemasok | SUP001 | Wajib dan unik | Petugas Pembelian |
| Nama Pemasok | Nama pemasok barang | Tech Supplier | Wajib diisi | Petugas Pembelian |
| Nomor Telepon Pemasok | Nomor kontak pemasok | 081298765432 | Format nomor telepon | Petugas Pembelian |
| ID Pemesanan | Identitas unik pemesanan | PO001 | Wajib dan unik | Petugas Pembelian |
| Tanggal Pemesanan | Tanggal pemesanan barang | 2026-10-07 | Wajib diisi | Petugas Pembelian |
| ID Penerimaan | Identitas unik penerimaan barang | RC001 | Wajib dan unik | Petugas Gudang |
| Jumlah Barang | Jumlah barang dalam transaksi/penerimaan | 5 | Bilangan bulat lebih dari 0 | Kasir/Petugas Gudang |
| Harga Beli | Harga barang dari pemasok | 600000 | Nilai lebih dari 0 | Petugas Pembelian |

## 9. Kebutuhan non-fungsional data

Parameter P untuk proyek ini adalah 8 berdasarkan NIM 25430007. Dengan demikian, maksimal item dalam satu transaksi adalah 10 item, persentase diskon/denda adalah 8%, dan perkiraan volume transaksi adalah 80 transaksi per hari.

### Volume Data

PixelMart diperkirakan memiliki volume sekitar 80 transaksi per hari. Sistem harus mampu menangani maksimal 10 item dalam satu transaksi.

### Retensi Data

Data transaksi penjualan, pemesanan, penerimaan barang, pelanggan, dan persediaan perlu disimpan untuk mendukung pelacakan transaksi dan pembuatan laporan.

### Privasi dan Akses Data

Data pelanggan seperti nama, nomor telepon, dan alamat termasuk data yang perlu dilindungi. Akses terhadap data pelanggan dibatasi kepada pengguna yang memiliki hak akses sesuai tugasnya.

### Kebutuhan Keamanan

Setiap pengguna sistem harus memiliki hak akses sesuai perannya. Data transaksi dan data persediaan tidak boleh diubah oleh pengguna yang tidak berwenang.

## 10. Isu kualitas data yang diantisipasi

Beberapa isu kualitas data yang dapat terjadi pada PixelMart adalah:

1. Data pelanggan dapat tercatat lebih dari satu kali jika tidak dilakukan pemeriksaan terhadap ID pelanggan.
2. Data barang dapat memiliki nama atau kategori yang tidak konsisten.
3. Harga barang dapat salah input sehingga memengaruhi perhitungan transaksi.
4. Jumlah stok dapat tidak sesuai dengan kondisi barang yang sebenarnya jika transaksi penerimaan atau penjualan tidak dicatat dengan benar.
5. Data transaksi dapat memiliki informasi yang tidak lengkap, seperti tanggal atau detail barang.
6. Data nomor telepon pelanggan atau pemasok dapat memiliki format yang tidak konsisten.
7. Data pemesanan dan penerimaan barang dapat tidak sesuai jika jumlah barang yang diterima berbeda dengan jumlah yang dipesan.
8. Data transaksi perlu dijaga agar tidak diubah oleh pengguna yang tidak memiliki hak akses.
