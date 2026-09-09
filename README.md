# Kimia Farma Big Data Analytics

## Analisis Performa Bisnis Kimia Farma 2020–2023

Project ini merupakan implementasi analisis data untuk Final Task Big Data Analyst Kimia Farma.

Saya menggunakan Google BigQuery untuk pengolahan dan analisis data dengan SQL, kemudian menggunakan Looker Studio untuk menyajikan hasil analisis dalam bentuk dashboard interaktif.

Fokus analisis adalah memahami performa bisnis berdasarkan transaksi, nett sales, nett profit, wilayah, cabang, dan produk.

## Tujuan Analisis

Pertanyaan yang ingin dijawab:

1. Bagaimana perkembangan performa bisnis selama 2020–2023?
2. Provinsi mana yang memiliki jumlah transaksi tertinggi?
3. Provinsi mana yang memberikan kontribusi nett sales terbesar?
4. Bagaimana distribusi nett profit antarprovinsi?
5. Cabang mana yang perlu mendapat perhatian lebih lanjut berdasarkan perbedaan rating?
6. Produk mana yang memberikan kontribusi nett sales terbesar?

## Alur Analisis

```text
Dataset Sumber
      |
      v
Google BigQuery
      |
      v
kf_analysis
      |
      +---- SQL Analysis
      |
      v
Looker Studio
      |
      v
Insight & Rekomendasi
```

## Tabel Analisis

Tabel utama yang digunakan adalah `kimia_farma.kf_analysis`.

Kolom utama:

- `transaction_id`
- `date`
- `year`
- `month`
- `branch_id`
- `branch_name`
- `kota`
- `provinsi`
- `rating_cabang`
- `customer_name`
- `product_id`
- `product_name`
- `product_category`
- `actual_price`
- `discount_percentage`
- `persentase_gross_laba`
- `nett_sales`
- `nett_profit`
- `rating_transaksi`

## Perhitungan Metrik

### Nett Sales

```text
actual_price × (1 - discount_percentage)
```

### Nett Profit

```text
nett_sales × persentase_gross_laba
```

## SQL Analysis

| File | Keterangan |
|---|---|
| `01_data_quality.sql` | Pemeriksaan kualitas dan konsistensi data |
| `02_create_analysis_table.sql` | Pembuatan tabel `kf_analysis` |
| `03_yearly_performance.sql` | Analisis performa tahunan dan bulanan |
| `04_province_analysis.sql` | Analisis berdasarkan provinsi |
| `05_branch_analysis.sql` | Analisis cabang dan rating |
| `06_product_analysis.sql` | Analisis performa produk |

Setiap script diberi komentar untuk menjelaskan tujuan dan logika query yang digunakan.

## Dashboard

Dashboard Looker Studio mencakup:

- Total Transactions
- Nett Sales
- Nett Profit
- Average Transaction Rating
- Tren Nett Sales dan Nett Profit 2020–2023
- 10 Provinsi dengan transaksi tertinggi
- 10 Provinsi dengan nett sales tertinggi
- Distribusi nett profit berdasarkan provinsi
- Analisis cabang
- 10 Produk dengan nett sales tertinggi

## Insight Utama

### 1. Pertumbuhan Penjualan Relatif Datar

Nett sales selama 2020–2023 relatif stabil dan belum menunjukkan tren pertumbuhan yang konsisten.

### 2. Kontribusi Regional Masih Terkonsentrasi

Jawa Barat menjadi provinsi dengan kontribusi transaksi dan nett sales terbesar pada dataset.

### 3. Transaksi dan Nett Sales Memiliki Pola Regional yang Sejalan

Provinsi dengan volume transaksi tinggi pada umumnya juga memiliki kontribusi nett sales yang tinggi.

### 4. Beberapa Cabang Layak Ditinjau Lebih Lanjut

Terdapat cabang dengan rating cabang relatif tinggi tetapi rata-rata rating transaksi lebih rendah. Kondisi ini digunakan sebagai indikator awal untuk menentukan cabang yang dapat ditinjau lebih lanjut.

### 5. Kontribusi Produk Tersebar

Beberapa produk teratas memiliki kontribusi nett sales yang relatif berdekatan sehingga performa penjualan tidak hanya bergantung pada satu produk.

## Rekomendasi

### Strategi Regional

Mempertahankan performa wilayah dengan kontribusi tinggi sekaligus mencari peluang pertumbuhan di wilayah lain untuk mengurangi konsentrasi kontribusi bisnis.

### Strategi Produk

Memantau produk dengan nett sales tinggi dan mengevaluasi peluang optimasi promosi, harga, serta ketersediaan produk.

### Pengalaman Pelanggan

Melakukan pemeriksaan lebih lanjut terhadap cabang yang menunjukkan perbedaan antara rating cabang dan rating transaksi.

## Tools

- Google BigQuery
- SQL
- Looker Studio
- GitHub
- Microsoft PowerPoint

## Struktur Repository

```text
kimia-farma-big-data-analytics/
├── README.md
├── .gitignore
├── dashboard/
├── docs/
│   └── methodology.md
├── presentation/
└── sql/
    ├── 01_data_quality.sql
    ├── 02_create_analysis_table.sql
    ├── 03_yearly_performance.sql
    ├── 04_province_analysis.sql
    ├── 05_branch_analysis.sql
    └── 06_product_analysis.sql
```

## Tentang Project

Project ini dibuat sebagai bagian dari pembelajaran dan Final Task Big Data Analyst. Prosesnya mencakup pemeriksaan kualitas data, penggabungan data transaksi dengan data master, pembuatan metrik bisnis, analisis SQL, visualisasi, serta penyusunan insight dan rekomendasi.

## Author

**Achmad Kamil**

GitHub: `kahmadsyt`

## Disclaimer

Project ini dibuat untuk keperluan pembelajaran dan portfolio berdasarkan dataset yang disediakan pada Final Task Big Data Analyst Kimia Farma.

Hasil analisis bukan merupakan laporan resmi Kimia Farma dan digunakan untuk tujuan edukasi serta demonstrasi proses analisis data.