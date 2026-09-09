-- ============================================================
-- KIMIA FARMA BIG DATA ANALYTICS
-- 02 - PEMBUATAN TABEL ANALISIS
-- ============================================================
-- Tujuan:
-- Membuat kf_analysis sebagai tabel utama untuk analisis dan dashboard.
--
-- Sumber:
-- kf_final_transaction, kf_kantor_cabang, kf_product
--
-- Catatan:
-- kf_inventory tidak langsung di-join karena satu kombinasi branch_id + product_id dapat memiliki beberapa record.
-- Join langsung berisiko menggandakan baris transaksi dan membuat agregasi sales/profit menjadi tidak akurat.
-- ============================================================

CREATE OR REPLACE TABLE
`rakamin-kf-analytics-17.kimia_farma.kf_analysis`
AS

WITH transaction_data AS (

  -- Mengambil data transaksi dan mengubah date menjadi DATE.
  SELECT
    transaction_id,
    PARSE_DATE('%m/%d/%Y', date) AS date,
    branch_id,
    customer_name,
    product_id,
    price AS actual_price,
    discount_percentage,
    rating AS rating_transaksi
  FROM `rakamin-kf-analytics-17.kimia_farma.kf_final_transaction`

),

enriched_data AS (

  -- Menambahkan informasi cabang dan produk ke transaksi.
  SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    p.product_category,
    t.actual_price,
    t.discount_percentage,

    -- Menentukan persentase gross laba sesuai business rule.
    -- <= Rp50.000          : 10%
    -- > Rp50.000-100.000   : 15%
    -- > Rp100.000-300.000  : 20%
    -- > Rp300.000-500.000  : 25%
    -- > Rp500.000          : 30%
    CASE
      WHEN t.actual_price <= 50000 THEN 0.10
      WHEN t.actual_price <= 100000 THEN 0.15
      WHEN t.actual_price <= 300000 THEN 0.20
      WHEN t.actual_price <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,

    t.rating_transaksi

  FROM transaction_data t

  -- Mengambil informasi cabang berdasarkan branch_id.
  LEFT JOIN `rakamin-kf-analytics-17.kimia_farma.kf_kantor_cabang` b
    ON t.branch_id = b.branch_id

  -- Mengambil informasi produk berdasarkan product_id.
  LEFT JOIN `rakamin-kf-analytics-17.kimia_farma.kf_product` p
    ON t.product_id = p.product_id
)

SELECT
  transaction_id,
  date,

  -- Tahun dan bulan untuk analisis tren waktu.
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(MONTH FROM date) AS month,

  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang,
  customer_name,
  product_id,
  product_name,
  product_category,
  actual_price,
  discount_percentage,
  persentase_gross_laba,

  -- Nett sales = harga setelah dikurangi diskon.
  actual_price * (1 - discount_percentage) AS nett_sales,

  -- Nett profit = nett sales x persentase gross laba.
  (actual_price * (1 - discount_percentage))
    * persentase_gross_laba AS nett_profit,

  rating_transaksi

FROM enriched_data;

-- 3. Validasi jumlah baris setelah pembuatan tabel.
-- Digunakan untuk memastikan proses join tidak menggandakan jumlah transaksi.
SELECT
  COUNT(*) AS analysis_rows,
  COUNT(DISTINCT transaction_id) AS unique_transactions
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`;

-- 4. Pemeriksaan NULL pada kolom penting.
SELECT
  COUNTIF(branch_name IS NULL) AS null_branch_name,
  COUNTIF(provinsi IS NULL) AS null_provinsi,
  COUNTIF(product_name IS NULL) AS null_product_name,
  COUNTIF(nett_sales IS NULL) AS null_nett_sales,
  COUNTIF(nett_profit IS NULL) AS null_nett_profit
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`;

-- 5. Pemeriksaan contoh data hasil analisis.
SELECT *
FROM `rakamin-kf-analytics-17.kimia_farma.kf_analysis`
LIMIT 20;