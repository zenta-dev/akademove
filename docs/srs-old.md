# Software Requirements Specification (SRS)

**Nama Aplikasi:** Aplikasi Mobilitas & Delivery Komunitas Kampus (Web & Mobile)  
**Versi:** 1.0  
**Tanggal:** -  
**Disusun oleh:** -

---

## 1. Gambaran Umum Aplikasi

Aplikasi ini merupakan platform transportasi dan layanan antar yang menghubungkan pengguna (penumpang/mahasiswa) dengan driver (juga mahasiswa) serta merchant/tenant kampus (kantin, toko buku, laundry, fotokopi, dsb.). Sistem berbasis komisi antara aplikator dengan mitra (driver dan merchant), dengan pendekatan fleksibilitas jadwal karena driver dapat menonaktifkan akun saat ada kuliah.

### Tujuan Utama

- Membantu pengguna mencari driver online untuk transportasi, antar barang, dan pesan makanan
- Memberikan pengalaman digital yang aman, nyaman, dan sesuai dengan kebutuhan komunitas kampus
- Menjadi solusi kampus smart mobility yang mendukung digitalisasi SPBE (Sistem Pemerintahan Berbasis Elektronik) dalam lingkup perguruan tinggi

---

## 1.1 Level Pengguna

### 1. Pengguna (User/Passenger)
- Registrasi akun
- Cari driver
- Tentukan titik jemput dan tujuan lewat peta
- Pesan transportasi, makanan, atau paket
- Pilih driver berdasarkan gender (opsional)
- Beri rating & laporan terkait driver
- Topup dan pembayaran cashless
- History penggunaan

### 2. Driver (Mitra Mahasiswa)
- Registrasi & verifikasi sebagai driver
- Aktif/nonaktif sesuai jadwal kuliah
- Terima order otomatis dari radius terdekat
- Lihat riwayat perjalanan, pendapatan harian/mingguan/bulanan
- Beri rating pada penumpang
- Menerima dan melakukan topup dari pengguna

### 3. Merchant / Tenant (Toko/Kantin Kampus)
- Upload menu/produk
- Terima & kelola order
- Pantau laporan penjualan dan komisi

### 4. Operator (Manajemen Kampus / Unit Bisnis)
- Set biaya per km
- Buat promo, diskon, event khusus
- Monitor laporan pendapatan driver & merchant
- Kirim pesan massal/pribadi ke driver/merchant

### 5. Administrator Sistem (Aplikator)
- Kontrol penuh (akses operator)
- Manajemen database pengguna
- Pengaturan komisi sistem
- Audit aktivitas (security & log system)
- History

---

## 1.2 Fitur Utama

- **Transportasi Kampus:** Antar jemput mahasiswa, fleksibel waktu kuliah
- **Delivery Service:** Antar paket (dokumen, barang, laundry)
- **Food Delivery:** Pesan makanan dari kantin/toko kampus
- **Peta Interaktif:** Lokasi driver, penumpang, merchant real-time
- **Biaya Otomatis:** Hitung ongkos berdasarkan jarak (km)
- **Sistem Komisi:** Potongan otomatis antara driver/merchant dan aplikator
- **Rating & Review:**
  - Driver → Penumpang: kesopanan, ketepatan waktu
  - Penumpang → Driver: kebersihan, kenyamanan, keamanan
- **Diskon & Promo:** Regular, event kampus (wisuda, dies natalis, dsb.)
- **Chat In-App:** Driver ↔ Penumpang tanpa menampilkan nomor telepon
- **Filter Gender Driver:** Untuk keamanan penumpang wanita
- **Report & Safety Tools:** Laporkan perilaku buruk driver/penumpang
- **Leaderboard & Badge:** Driver/pengguna terbaik → prioritas order
- **Auto-Match:** Sistem mencari driver terdekat & sesuai preferensi

---

## 1.3 Fitur Tambahan (Kebutuhan Umum)

- **E-Wallet / Payment Gateway:** Top-up saldo, bayar via e-wallet, bank, QRIS
- **Notifikasi Push:** Status order, promo, informasi operator
- **Customer Support:** Live chat/AI bot untuk bantuan
- **Insurance Micro:** Asuransi perjalanan murah (opsional)
- **Loyalty Program:** Poin & reward untuk pengguna aktif
- **Multi-language Support:** Indonesia & English untuk kampus internasional
- **Dark Mode / Accessibility:** Aksesibilitas bagi difabel (text-to-speech, high contrast)
- **Data Analytics Dashboard:** Insight penggunaan, trafik kampus, perilaku pengguna
- **Integrasi Kalender Kuliah:** Sinkronisasi jadwal agar driver otomatis nonaktif ketika ada kelas
- **Emergency Button:** Tombol darurat yang menghubungkan ke operator/security kampus

---

## 1.4 Keunikan Dibanding Aplikasi Lain

- Spesifik komunitas kampus → hanya mahasiswa, dosen, dan tenant kampus
- Fitur jadwal kuliah untuk fleksibilitas driver
- Gender preference driver demi kenyamanan & keamanan
- Leaderboard reputasi untuk meningkatkan motivasi mitra
- Integrasi dengan sistem kampus (KRS, event, unit usaha kampus)

---

## 2. Tujuan Dokumen

SRS ini mendefinisikan kebutuhan fungsional dan non-fungsional aplikasi mobilitas kampus (mirip Gojek/Grab) dengan karakter unik: driver dan penumpang adalah mahasiswa. Dokumen ini cukup rinci untuk menjadi acuan scope, planning, desain, pengujian, dan komunikasi lintas tim.

### 2.1 Ruang Lingkup

Platform web + mobile yang menghubungkan:

- **Pengguna (penumpang)** untuk pesan antar-jemput, kirim barang/paket, pesan makanan
- **Driver (mahasiswa)** sebagai mitra, bisa nonaktif saat jadwal kuliah
- **Merchant/Tenant** (kantin, fotokopi, toko buku, laundry) untuk food & goods delivery
- **Operator** (pengelola kampus/unit bisnis) dan **Admin Sistem** (aplikator) untuk tarif/km, promo, monitoring, evaluasi & broadcast

### 2.2 Sasaran Pengguna Dokumen

- Developer & QA pemula, UI/UX, DevOps
- Mahasiswa calon Project Manager (belajar scope management, prioritas, risiko, dan acceptance criteria)

### 2.3 Definisi & Istilah

- **Merchant:** mitra toko (umum, bisa pribadi)
- **Tenant:** unit usaha di bawah kampus
- **Aplikator:** pemilik platform
- **Operator:** pengelola harian (kampus)
- **RBAC:** Role-Based Access Control (akses berdasarkan peran)
- **Order:** permintaan layanan (ride/delivery/food)
- **Leaderboard/Badge:** penanda reputasi terbaik

### 2.4 Gambaran Singkat

Aplikasi memadukan transportasi, delivery barang, food delivery, chat privat, rating dua arah, promo/diskon, peta real-time, penetapan tarif per km oleh operator, komisi mitra, serta matching otomatis driver-penumpang dengan preferensi gender dan radius.

---

## 3. Perspektif Produk

### 3.1 Kelas Pengguna & Karakteristik

- **Pengguna/Passenger:** pesan ride/delivery/food, bisa pilih driver berdasar gender
- **Driver (Mahasiswa):** on/off, sinkron jadwal kuliah, auto-match, lihat pendapatan & kinerja
- **Merchant/Tenant:** kelola menu/produk, terima order, pantau penjualan/komisi
- **Operator:** atur tarif/km, promo, broadcast, pantau kinerja & laporan
- **Admin Sistem:** master data, komisi, audit, keamanan, analitik global

### 3.2 Batasan

- **Lokasi:** layanan fokus di area kampus/kota terkait
- **Kepatuhan:** privasi & data pribadi (mis. UU PDP 27/2022), keselamatan pengguna
- **Konektivitas:** mobile network tidak selalu stabil

### 3.3 Asumsi & Ketergantungan

- Penyedia peta & rute (pluggable)
- Gateway pembayaran (QRIS/transfer/e-wallet)
- Push notification (FCM/APNs)
- Verifikasi mahasiswa (KTM/SSO kampus)

---

## 4. Kebutuhan Fungsional (FR)

Penomoran untuk memudahkan traceability (FR-001, dst).

### 4.1 FR-001 Akun & Otentikasi

- **FR-001.1** Pengguna/driver/merchant mendaftar via email/HP; OTP/2FA opsional
- **FR-001.2** Driver wajib unggah KTM, SIM, STNK, foto diri; status menunggu verifikasi
- **FR-001.3** RBAC: User, Driver, Merchant/Tenant, Operator, Admin
- **FR-001.4** Profil dapat diedit (nama, foto, gender, preferensi)

### 4.2 FR-002 Jadwal Kuliah & Status Driver

- **FR-002.1** Driver bisa atur jadwal kuliah (manual atau impor kalender)
- **FR-002.2** Sistem auto-nonaktifkan driver saat jadwal kuliah aktif
- **FR-002.3** Driver dapat On/Off secara manual kapan saja

### 4.3 FR-003 Peta & Lokasi

- **FR-003.1** Tampilkan peta interaktif; input titik jemput & tujuan
- **FR-003.2** Tampilkan driver terdekat (real-time)
- **FR-003.3** Estimasi jarak & waktu tempuh rute terpendek

### 4.4 FR-004 Ride-Hailing (Antar-Jemput)

- **FR-004.1** Pengguna membuat order: lokasi jemput & tujuan
- **FR-004.2** Tarif dihitung per km (ditetapkan Operator)
- **FR-004.3** User dapat menambahkan tip / menawarkan tarif di atas batas minimum; sistem menolak di bawah floor price
- **FR-004.4** Preferensi driver se-gender (opsional)
- **FR-004.5** Matching otomatis ke driver terdekat dalam radius; jika ditolak/timeout → eskalasi ke driver lain
- **FR-004.6** Status order: `Requested → Matching → Accepted → Arriving → In-Trip → Completed/Cancelled/No-show`
- **FR-004.7** Bukti perjalanan (route, waktu, biaya) tersimpan

### 4.5 FR-005 Delivery Barang/Paket

- **FR-005.1** Form pickup & drop-off (nama, catatan, ukuran)
- **FR-005.2** Estimasi biaya berdasarkan jarak rute terpendek
- **FR-005.3** Bukti penyerahan (foto/OTP penerima)

### 4.6 FR-006 Food Delivery

- **FR-006.1** Merchant/tenant kelola menu, harga, stok
- **FR-006.2** Pengguna pilih item, alamat antar, bayar
- **FR-006.3** Notifikasi status: diterima, disiapkan, diantar, selesai

### 4.7 FR-007 Pembayaran & Komisi

- **FR-007.1** Metode: QRIS/e-wallet/transfer (cash opsional tergantung kebijakan)
- **FR-007.2** Komisi aplikator otomatis dipotong dari pendapatan driver/merchant
- **FR-007.3** Dompet in-app untuk ringkasan saldo, penarikan (withdraw)

### 4.8 FR-008 Promo/Diskon/Voucher

- **FR-008.1** Operator membuat promo reguler/event (dies natalis, wisuda)
- **FR-008.2** Aturan: periode, kuota, minimal jarak/biaya, segmen pengguna

### 4.9 FR-009 Chat In-App & Privasi

- **FR-009.1** Chat driver ↔ penumpang dalam order aktif
- **FR-009.2** Nomor telepon disembunyikan (masking)
- **FR-009.3** Quick messages (preset): "Saya tiba 2 menit lagi", dsb.

### 4.10 FR-010 Rating & Review Dua Arah

- **FR-010.1** Kategori rating (set Operator): kebersihan, kesopanan, kenyamanan, ketepatan waktu, keamanan
- **FR-010.2** Rating wajib setelah order selesai; komentar opsional
- **FR-010.3** Skor reputasi agregat memengaruhi prioritas order

### 4.11 FR-011 Laporan (Report) & Keamanan

- **FR-011.1** Penumpang bisa melaporkan perilaku driver; sebaliknya driver melaporkan penumpang
- **FR-011.2** Operator/Admin menindaklanjuti (warning, suspend, blokir)
- **FR-011.3** Emergency button (opsional) menghubungi keamanan kampus

### 4.12 FR-012 Leaderboard & Badge

- **FR-012.1** Penanda driver/pengguna terbaik (rating tinggi, on-time, volume order)
- **FR-012.2** Badge publik & prioritas matching untuk driver terbaik

### 4.13 FR-013 Notifikasi

- **FR-013.1** Push & in-app untuk status order, promo, broadcast operator
- **FR-013.2** Preferensi notifikasi per user

### 4.14 FR-014 Panel Operator

- **FR-014.1** Atur tarif per km, biaya minimum, batas promo
- **FR-014.2** Buat diskon/promo, broadcast massal/pribadi
- **FR-014.3** Lihat kinerja driver (rating, SLA pickup), laporan harian/mingguan/bulanan

### 4.15 FR-015 Panel Admin Sistem

- **FR-015.1** Master data, konfigurasi komisi, peran & izin (RBAC)
- **FR-015.2** Audit log, fraud detection dasar (duplikasi akun, GPS spoof)
- **FR-015.3** Analitik global (order, pendapatan, retensi)

### 4.16 FR-016 Pendaftaran & Onboarding Driver

- **FR-016.1** Form data, upload dokumen (KTM/SIM/STNK), verifikasi
- **FR-016.2** Uji pengetahuan keselamatan (mini-quiz)
- **FR-016.3** Status: `Pending → Approved/Rejected → Active`

### 4.17 FR-017 Matching & Radius

- **FR-017.1** Radius default ditentukan Operator; adaptif sesuai kepadatan
- **FR-017.2** Auto-assign prioritas: jarak, reputasi, preferensi gender, ketersediaan

### 4.18 FR-018 Laporan Pendapatan Driver

- **FR-018.1** Ringkas pendapatan harian/mingguan/bulanan, rata-rata order, jam aktif
- **FR-018.2** Ekspor CSV/Excel

---

## 5. Kebutuhan Non-Fungsional (NFR)

- **NFR-01 Performa:**
  - Pencarian driver & estimasi < 2 detik di jaringan normal
  - Proses matching pertama < 5 detik

- **NFR-02 Keandalan:** Uptime target 99,5%/bulan

- **NFR-03 Skalabilitas:** Stateless service, auto-scaling, caching

- **NFR-04 Keamanan:** TLS 1.2+, hash password (argon2/bcrypt), enkripsi data sensitif at rest, RBAC, audit log, rate limiting, proteksi OWASP Top-10 (web & mobile)

- **NFR-05 Privasi:** minimasi data, nomor telp masking, kebijakan retensi & penghapusan data, persetujuan (consent)

- **NFR-06 Aksesibilitas:** WCAG 2.1 AA, dark mode

- **NFR-07 Maintainability:** 12-factor app, linting, code review, modular monolith → microservices bila perlu

- **NFR-08 Observability:** structured logging, metrics, tracing, alerting

- **NFR-09 Lokalisasi:** ID & EN

---

## 6. Model Data (Ringkas)

### Entitas Utama (atribut inti):

- **User** `(id, role, name, phoneMasked, email, gender, rating, createdAt)`
- **Driver** `(id -> User, studentId, licenseNo, vehicleType, status, scheduleJSON, reputationScore)`
- **Merchant** `(id -> User, type{merchant|tenant}, name, address, menuJSON)`
- **Order** `(id, type{ride|delivery|food}, userId, driverId, merchantId?, pickup, dropoff, routeGeoJSON, distanceKm, price, tip, status, createdAt)`
- **Payment** `(id, orderId, amount, method, status, commission, driverNet)`
- **Promo** `(id, name, rulesJSON, periodStart, periodEnd)`
- **Rating** `(id, orderId, fromUserId, toUserId, categoriesJSON, score, comment)`
- **Report** `(id, orderId, reporterId, targetUserId, category, description, evidenceURL, status)`
- **Broadcast** `(id, targetSegment, message, createdBy, sentAt)`

**Catatan:** gunakan PostgreSQL + PostGIS untuk jarak/rute.

---

## 7. Arsitektur & Teknologi (Rekomendasi)

- **Mobile:** Flutter (1 codebase iOS/Android)
- **Web:** React + TypeScript
- **Backend:** Node.js (NestJS) / Go; REST API + WebSocket untuk real-time
- **DB:** PostgreSQL (+ PostGIS), Redis (queue/cache)
- **Rute/Peta:** penyedia pluggable (OpenStreetMap/Mapbox/Google)
- **Notif:** FCM/APNs
- **Payment:** QRIS/e-wallet aggregator
- **Infra:** Docker, CI/CD, blue-green deploy, object storage untuk media

---

## 8. Contoh Alur Proses (State Machine)

### Order (Ride/Delivery)

```
Requested → Matching → Accepted → Arriving → In-Trip → Completed
```

**Percabangan:** `CancelledByUser | CancelledByDriver | No-show`

### Onboarding Driver

```
Submitted → UnderReview → Approved/Rejected → Active/Suspended
```

---

## 9. Antarmuka Pengguna (Ringkasan Layar)

### User App
Login, Beranda (peta), Form order (ride/delivery/food), Estimasi biaya, Preferensi gender, Tracking driver, Chat, Rating, Riwayat, Dompet

### Driver App
Toggle Online/Offline, Jadwal kuliah, Order masuk, Navigasi, Chat, Riwayat, Pendapatan & laporan

### Merchant Web
Menu/produk, Order masuk, Laporan penjualan

### Operator/Admin Web
Tarif/km, promo, broadcast, evaluasi driver, laporan agregat, manajemen pengguna & komisi

---

## 10. Aturan Bisnis (Contoh)

- Tarif = `baseFee + (distanceKm × pricePerKm)`; floor price wajib
- Komisi driver = `totalFare – platformCommission`
- Promo dihitung setelah tarif dasar; tip tidak dikomisi (opsional kebijakan)
- Matching mempertimbangkan: radius, preferensi gender, reputasi, jarak ke pickup, status jadwal kuliah

---

## 11. Contoh API (Kerangka Ringkas – REST)

- `POST /auth/register`, `POST /auth/login`
- `GET /me`, `PATCH /me`
- `POST /driver/onboarding`, `PATCH /driver/status`, `GET /driver/earnings`
- `POST /orders`, `GET /orders/:id`, `PATCH /orders/:id/cancel`, `WS /orders/:id/stream`
- `POST /chat/:orderId/message`
- `POST /ratings`, `GET /ratings/user/:id`
- `POST /reports`
- `GET /operator/pricing`, `PATCH /operator/pricing`
- `POST /operator/promo`, `GET /operator/promo`
- `POST /operator/broadcast`
- `GET /analytics/overview`

---

## 12. Kriteria Penerimaan (Contoh)

### FR-004 Ride

**Given** user mengisi pickup & dropoff valid  
**When** menekan "Pesan"  
**Then** sistem memberi estimasi biaya dan status Matching ≤ 5 detik

### FR-002 Jadwal Kuliah

**Given** driver menambahkan jadwal  
**When** jam kuliah dimulai  
**Then** status driver otomatis Offline

### FR-010 Rating

**Given** order selesai  
**When** salah satu pihak memberi rating  
**Then** skor reputasi penerima ter-update real-time & tampil di profil