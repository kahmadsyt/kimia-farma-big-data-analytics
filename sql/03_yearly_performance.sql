-- ============================================================
-- KIMIA FARMA BIG DATA ANALYTICS
-- 03 - ANALISIS PERFORMA TAHUNAN
-- ============================================================
-- Tujuan:
-- Melihat perkembangan performa bisnis selama 2020-2023.
-- ============================================================

-- 1. Performa bisnis per tahun
SELECT
  year,
  COUNT(DISTINCT transaction_id) AS total_transactions,
  SUM(nett_sales) AS nett_sales,
  SUM(nett_profit) AS nett_profit,
  AVG(rating_transaksi) AS avg_rating_transaksi,
  AVG(discount_percentage) AS avg_discount_percentage
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`
GROUP BY year
ORDER BY year;

-- 2. Performa bisnis per bulan
-- Digunakan untuk melihat pola transaksi, sales, dan profit secara lebih rinci.
SELECT
  year,
  month,
  COUNT(DISTINCT transaction_id) AS total_transactions,
  SUM(nett_sales) AS nett_sales,
  SUM(nett_profit) AS nett_profit
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`
GROUP BY year, month
ORDER BY year, month;