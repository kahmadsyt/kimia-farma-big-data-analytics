-- ============================================================
-- KIMIA FARMA BIG DATA ANALYTICS
-- 01 - PEMERIKSAAN KUALITAS DATA
-- ============================================================
-- Tujuan:
-- Melakukan pemeriksaan awal terhadap dataset sebelum proses pembuatan tabel analisis.
--
-- Pemeriksaan:
-- 1. Jumlah dan keunikan transaksi
-- 2. Rentang tanggal
-- 3. Distribusi transaksi per tahun
-- 4. Kualitas master produk
-- 5. Kualitas master cabang
-- 6. Kesesuaian branch_id
-- 7. Kesesuaian product_id
-- ============================================================

-- 1. Ringkasan data transaksi
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT transaction_id) AS unique_transactions,
  COUNT(DISTINCT branch_id) AS unique_branches,
  COUNT(DISTINCT product_id) AS unique_products
FROM `rakamin-kf-analytics-17.kimia_farma.kf_final_transaction`;

-- 2. Rentang tanggal transaksi
-- Kolom date masih berupa STRING dengan format M/D/YYYY, sehingga perlu dikonversi menggunakan PARSE_DATE().
SELECT
  MIN(PARSE_DATE('%m/%d/%Y', date)) AS min_date,
  MAX(PARSE_DATE('%m/%d/%Y', date)) AS max_date
FROM `rakamin-kf-analytics-17.kimia_farma.kf_final_transaction`;

-- 3. Jumlah transaksi per tahun
SELECT
  EXTRACT(YEAR FROM PARSE_DATE('%m/%d/%Y', date)) AS year,
  COUNT(*) AS total_transactions
FROM `rakamin-kf-analytics-17.kimia_farma.kf_final_transaction`
GROUP BY year
ORDER BY year;

-- 4. Pemeriksaan master produk
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT product_id) AS unique_products,
  COUNTIF(product_name IS NULL) AS null_product_name
FROM `rakamin-kf-analytics-17.kimia_farma.kf_product`;

-- 5. Pemeriksaan master cabang
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT branch_id) AS unique_branches,
  COUNTIF(provinsi IS NULL) AS null_province,
  COUNTIF(rating IS NULL) AS null_rating
FROM `rakamin-kf-analytics-17.kimia_farma.kf_kantor_cabang`;

-- 6. Pemeriksaan kesesuaian branch_id
-- Hasil yang diharapkan: unmatched_branch = 0
SELECT
  COUNT(*) AS unmatched_branch
FROM `rakamin-kf-analytics-17.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-17.kimia_farma.kf_kantor_cabang` b
  ON t.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- 7. Pemeriksaan kesesuaian product_id
-- Hasil yang diharapkan: unmatched_product = 0
SELECT
  COUNT(*) AS unmatched_product
FROM `rakamin-kf-analytics-17.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-17.kimia_farma.kf_product` p
  ON t.product_id = p.product_id
WHERE p.product_id IS NULL;
