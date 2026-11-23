-- ============================================================================
-- Modul 12: CTE dan Window Function - Tugas D.1-D.3 & Latihan E.1-E.2
-- Basis Data: kopma_007
-- NIM: 25430007
-- ============================================================================

USE kopma_007;

-- ----------------------------------------------------------------------------
-- D.1: CTE dan Peringkat per Kategori (RANK)
-- ----------------------------------------------------------------------------
WITH omzet_barang AS (
    SELECT
        b.kategori,
        b.nama_barang,
        SUM(d.jumlah * d.harga_satuan) AS omzet
    FROM detail_penjualan d
    JOIN barang b ON b.id_barang = d.id_barang
    GROUP BY b.kategori, b.nama_barang
)
SELECT
    kategori,
    nama_barang,
    omzet,
    RANK() OVER (
        PARTITION BY kategori
        ORDER BY omzet DESC
    ) AS peringkat_kategori
FROM omzet_barang
ORDER BY kategori, peringkat_kategori, nama_barang;

-- ----------------------------------------------------------------------------
-- D.2: CTE Rekursif - Hari Tanpa Penjualan
-- ----------------------------------------------------------------------------
WITH RECURSIVE kalender AS (
    SELECT DATE('2026-10-01') AS tgl_kalender
    UNION ALL
    SELECT tgl_kalender + INTERVAL 1 DAY
    FROM kalender
    WHERE tgl_kalender < '2026-10-14'
)
SELECT
    k.tgl_kalender,
    COUNT(p.no_nota) AS nota
FROM kalender k
LEFT JOIN penjualan p ON p.tanggal_nota = k.tgl_kalender
GROUP BY k.tgl_kalender
HAVING nota = 0
ORDER BY k.tgl_kalender;

-- ----------------------------------------------------------------------------
-- D.3: Total Berjalan dan Perubahan Harian (SUM OVER & LAG)
-- ----------------------------------------------------------------------------
WITH omzet_harian AS (
    SELECT
        tanggal_nota AS tanggal,
        SUM(total_bayar) AS omzet
    FROM penjualan
    WHERE tanggal_nota >= '2026-10-01'
      AND tanggal_nota < '2026-10-11'
    GROUP BY tanggal_nota
)
SELECT
    tanggal,
    omzet,
    SUM(omzet) OVER (
        ORDER BY tanggal
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_berjalan,
    omzet - LAG(omzet) OVER (
        ORDER BY tanggal
    ) AS selisih_hari_sebelumnya
FROM omzet_harian
ORDER BY tanggal;

-- ----------------------------------------------------------------------------
-- E.1: Nota dengan Nilai Terbesar per Petugas (ROW_NUMBER)
-- ----------------------------------------------------------------------------
WITH peringkat_nota_petugas AS (
    SELECT
        no_nota,
        id_petugas,
        tanggal_nota,
        total_bayar,
        ROW_NUMBER() OVER (
            PARTITION BY id_petugas
            ORDER BY total_bayar DESC, no_nota ASC
        ) AS urutan_belanja
    FROM penjualan
)
SELECT
    no_nota,
    id_petugas,
    tanggal_nota,
    total_bayar,
    urutan_belanja
FROM peringkat_nota_petugas
WHERE urutan_belanja = 1
ORDER BY id_petugas;

-- ----------------------------------------------------------------------------
-- E.2: Pangsa Omzet Kategori terhadap Total Bulanan (%)
-- ----------------------------------------------------------------------------
WITH omzet_kategori_bulanan AS (
    SELECT
        DATE_FORMAT(p.tanggal_nota, '%Y-%m') AS bulan,
        b.kategori,
        SUM(d.jumlah * d.harga_satuan) AS omzet_kategori
    FROM penjualan p
    JOIN detail_penjualan d ON d.no_nota = p.no_nota
    JOIN barang b ON b.id_barang = d.id_barang
    GROUP BY DATE_FORMAT(p.tanggal_nota, '%Y-%m'), b.kategori
)
SELECT
    bulan,
    kategori,
    omzet_kategori,
    SUM(omzet_kategori) OVER (PARTITION BY bulan) AS total_bulanan,
    ROUND(
        (omzet_kategori / SUM(omzet_kategori) OVER (PARTITION BY bulan)) * 100,
        2
    ) AS pangsa_persen
FROM omzet_kategori_bulanan
ORDER BY bulan, pangsa_persen DESC, kategori;