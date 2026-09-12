-- ============================================================
-- KIMIA FARMA BIG DATA ANALYTICS
-- 05 - ANALISIS PERFORMA CABANG
-- ============================================================
-- Tujuan:
-- Mengidentifikasi cabang dengan rating cabang relatif tinggi tetapi rata-rata rating transaksi relatif lebih rendah.
--
-- Catatan:
-- Hasil ini merupakan screening awal, bukan bukti sebab-akibat mengenai kualitas pelayanan.
-- ============================================================

SELECT
  branch_id,
  branch_name,
  kota,
  provinsi,

  -- Rating yang terdapat pada master kantor cabang.
  rating_cabang,

  -- Rata-rata rating dari transaksi pelanggan.
  AVG(rating_transaksi) AS avg_rating_transaksi,

  -- Jumlah transaksi pada cabang.
  COUNT(DISTINCT transaction_id) AS total_transactions,

  -- Kontribusi nett sales.
  SUM(nett_sales) AS nett_sales,

  -- Kontribusi nett profit.
  SUM(nett_profit) AS nett_profit

FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`

GROUP BY
  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang

-- Prioritas:
-- 1. Rating cabang paling tinggi
-- 2. Rata-rata rating transaksi paling rendah
ORDER BY
  rating_cabang DESC,
  avg_rating_transaksi ASC

LIMIT 5;