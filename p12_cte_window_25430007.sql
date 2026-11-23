-- ============================================================================
-- Modul 12: Milestone Proyek 12 - CTE Deskriptif & Window Function
-- Basis Data: kopma_007 (pembelian, detail_pembelian, barang, peminjaman)
-- NIM: 25430007
-- ============================================================================

USE kopma_007;

-- ----------------------------------------------------------------------------
-- Laporan 1: Peringkat Nilai Pembelian Barang per Kategori (RANK per Kelompok)
-- ----------------------------------------------------------------------------
WITH rekap_pembelian_barang AS (
    SELECT
        b.kategori,
        b.nama_barang,
        SUM(dp.jumlah * dp.harga_satuan) AS total_nilai_beli
    FROM detail_pembelian dp
    JOIN barang b ON b.id_barang = dp.id_barang
    GROUP BY b.kategori, b.nama_barang
)
SELECT
    kategori,
    nama_barang,
    total_nilai_beli,
    RANK() OVER (
        PARTITION BY kategori
        ORDER BY total_nilai_beli DESC
    ) AS peringkat_kategori
FROM rekap_pembelian_barang
ORDER BY kategori, peringkat_kategori, nama_barang;

-- ----------------------------------------------------------------------------
-- Laporan 2: Total Berjalan Pengeluaran Pembelian Harian (Running Total)
-- ----------------------------------------------------------------------------
WITH pengeluaran_harian_pembelian AS (
    SELECT
        pb.tanggal_faktur AS tanggal,
        SUM(dp.jumlah * dp.harga_satuan) AS total_harian
    FROM pembelian pb
    JOIN detail_pembelian dp ON dp.no_faktur = pb.no_faktur
    GROUP BY pb.tanggal_faktur
)
SELECT
    tanggal,
    total_harian,
    SUM(total_harian) OVER (
        ORDER BY tanggal
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_berjalan
FROM pengeluaran_harian_pembelian
ORDER BY tanggal;

-- ----------------------------------------------------------------------------
-- Laporan 3: Perubahan Pengeluaran Pembelian Antar-Faktur (LAG / LEAD)
-- ----------------------------------------------------------------------------
WITH rekap_faktur_pembelian AS (
    SELECT
        no_faktur,
        tanggal_faktur,
        id_pemasok,
        total_faktur
    FROM pembelian
)
SELECT
    no_faktur,
    tanggal_faktur,
    id_pemasok,
    total_faktur,
    LAG(total_faktur) OVER (
        ORDER BY tanggal_faktur, no_faktur
    ) AS faktur_sebelumnya,
    total_faktur - LAG(total_faktur) OVER (
        ORDER BY tanggal_faktur, no_faktur
    ) AS selisih_dari_sebelumnya,
    LEAD(total_faktur) OVER (
        ORDER BY tanggal_faktur, no_faktur
    ) AS faktur_berikutnya
FROM rekap_faktur_pembelian
ORDER BY tanggal_faktur, no_faktur;

-- ----------------------------------------------------------------------------
-- Laporan 4: CTE Rekursif - Kalender Aktivitas Peminjaman Buku per Hari
-- ----------------------------------------------------------------------------
WITH RECURSIVE deret_tanggal_peminjaman AS (
    SELECT DATE('2026-10-01') AS tanggal_cek
    UNION ALL
    SELECT tanggal_cek + INTERVAL 1 DAY
    FROM deret_tanggal_peminjaman
    WHERE tanggal_cek < '2026-10-14'
)
SELECT
    dt.tanggal_cek,
    COUNT(pj.id_peminjaman) AS jumlah_transaksi_pinjam,
    COALESCE(SUM(pj.denda), 0) AS total_denda_hari_itu
FROM deret_tanggal_peminjaman dt
LEFT JOIN peminjaman pj ON pj.tanggal_pinjam = dt.tanggal_cek
GROUP BY dt.tanggal_cek
ORDER BY dt.tanggal_cek;