-- ============================================================
-- KIMIA FARMA BIG DATA ANALYTICS
-- 06 - ANALISIS PERFORMA PRODUK
-- ============================================================
-- Tujuan:
-- Mengidentifikasi produk dengan kontribusi terbesar berdasarkan transaksi, nett sales, dan nett profit.
-- ============================================================

SELECT
  product_id,
  product_name,
  product_category,

  -- Jumlah transaksi yang melibatkan produk.
  COUNT(DISTINCT transaction_id) AS total_transactions,

  -- Total penjualan setelah diskon.
  SUM(nett_sales) AS nett_sales,

  -- Total profit berdasarkan business rule.
  SUM(nett_profit) AS nett_profit

FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`

GROUP BY
  product_id,
  product_name,
  product_category

-- Produk diurutkan berdasarkan nett sales terbesar.
ORDER BY nett_sales DESC
LIMIT 10;