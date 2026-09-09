# Metodologi Analisis

## 1. Sumber Data

Project ini menggunakan empat dataset yang disediakan untuk Final Task Big Data Analyst Kimia Farma:

- `kf_final_transaction`
- `kf_inventory`
- `kf_kantor_cabang`
- `kf_product`

Data dimuat ke Google BigQuery pada project `rakamin-kf-analytics-17`, dataset `kimia_farma`.

## 2. Alur Pengolahan Data

```text
Dataset Sumber
      |
      v
Google BigQuery
      |
      v
kf_analysis
      |
      +---- Query SQL
      |
      v
Google Data Studio
      |
      v
Insight Bisnis
```

## 3. Persiapan Data

Kolom `date` pada data transaksi masih berbentuk STRING sehingga dikonversi menjadi DATE menggunakan `PARSE_DATE('%m/%d/%Y', date)`.

Data transaksi kemudian diperkaya dengan informasi kantor cabang melalui `branch_id` dan informasi produk melalui `product_id`.

## 4. Perhitungan Metrik

### Nett Sales

`actual_price × (1 - discount_percentage)`

### Persentase Gross Laba

| Harga Aktual | Gross Laba |
|---|---:|
| <= Rp50.000 | 10% |
| > Rp50.000 – Rp100.000 | 15% |
| > Rp100.000 – Rp300.000 | 20% |
| > Rp300.000 – Rp500.000 | 25% |
| > Rp500.000 | 30% |

### Nett Profit

`nett_sales × persentase_gross_laba`

## 5. Analisis

Analisis mencakup performa tahunan dan bulanan, kontribusi provinsi, distribusi profit, analisis cabang berdasarkan rating, dan performa produk.

## 6. Visualisasi

Hasil analisis digunakan untuk membuat dashboard interaktif di Google Data Studio yang mencakup KPI, tren sales/profit, analisis provinsi, peta profit, analisis cabang, dan produk teratas.

## 7. Pertimbangan Penggunaan Inventory

`kf_inventory` tidak langsung digabungkan dengan data transaksi karena satu kombinasi `branch_id` dan `product_id` dapat memiliki beberapa record. Join langsung dapat menggandakan baris transaksi dan menyebabkan agregasi sales/profit menjadi tidak akurat.

## 8. Keterbatasan

Project ini dibuat berdasarkan dataset yang disediakan untuk Final Task dan tidak dimaksudkan sebagai laporan resmi Kimia Farma.

Analisis rating cabang dan rating transaksi digunakan sebagai indikator awal untuk ditinjau lebih lanjut, bukan sebagai kesimpulan sebab-akibat mengenai kualitas pelayanan.