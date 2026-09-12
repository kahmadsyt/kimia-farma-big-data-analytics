-- ============================================================
-- KIMIA FARMA BIG DATA ANALYTICS
-- 04 - ANALISIS PERFORMA PROVINSI
-- ============================================================
-- Tujuan:
-- Membandingkan kontribusi bisnis antarprovinsi berdasarkan transaksi, nett sales, dan nett profit.
-- ============================================================

-- 1. 10 provinsi dengan jumlah transaksi terbesar
SELECT
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transactions
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`
GROUP BY provinsi
ORDER BY total_transactions DESC
LIMIT 10;

-- 2. 10 provinsi dengan nett sales terbesar
SELECT
  provinsi,
  SUM(nett_sales) AS nett_sales,
  SUM(nett_profit) AS nett_profit,
  COUNT(DISTINCT transaction_id) AS total_transactions
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`
GROUP BY provinsi
ORDER BY nett_sales DESC
LIMIT 10;

-- 3. Nett profit per provinsi
-- Hasilnya digunakan untuk visualisasi peta distribusi profit.
SELECT
  provinsi,
  SUM(nett_profit) AS total_profit
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`
GROUP BY provinsi
ORDER BY total_profit DESC;