// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get transfer => 'Transfer';

  @override
  String get transfer_success => 'Transfer berhasil';

  @override
  String get transfer_failed => 'Transfer gagal';

  @override
  String get recipient_user_id => 'ID Pengguna Penerima';

  @override
  String get enter_recipient_user_id => 'Masukkan ID pengguna penerima';

  @override
  String get enter_amount => 'Masukkan jumlah';

  @override
  String get enter_note => 'Masukkan catatan (opsional)';

  @override
  String get error_recipient_required => 'ID pengguna penerima wajib diisi';

  @override
  String get error_transfer_minimum => 'Jumlah transfer minimal Rp 1.000';

  @override
  String get confirm_transfer => 'Konfirmasi Transfer';

  @override
  String get recipient => 'Penerima';

  @override
  String get recipient_phone => 'Nomor Telepon Penerima';

  @override
  String get enter_recipient_phone => 'Masukkan nomor telepon penerima';

  @override
  String get lookup_recipient => 'Cari';

  @override
  String get recipient_found => 'Penerima ditemukan';

  @override
  String get recipient_not_found => 'Pengguna tidak ditemukan dengan nomor telepon ini';

  @override
  String get use_user_id_instead => 'Gunakan ID Pengguna';

  @override
  String get scan_qr => 'Scan QR';

  @override
  String get my_qr_code => 'QR Code Saya';

  @override
  String get scan_qr_to_transfer => 'Scan QR code untuk transfer';

  @override
  String get share_qr_to_receive => 'Bagikan QR code ini untuk menerima transfer';

  @override
  String get or_enter_manually => 'Atau masukkan manual';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get select_bank => 'Pilih bank';

  @override
  String get edit_detail => 'Ubah Detail';

  @override
  String get total_delivery_distance => 'Total jarak pengiriman';

  @override
  String get choose_item_type => 'Pilih jenis item Anda';

  @override
  String get document => 'Dokumen';

  @override
  String get cloth => 'Pakaian';

  @override
  String get medicine => 'Obat';

  @override
  String get book => 'Buku';

  @override
  String get other => 'Lainnya';

  @override
  String get max => 'Maks';

  @override
  String get choose_your_items_size => 'Pilih ukuran item Anda';

  @override
  String get choose => 'Pilih';

  @override
  String get total_weight => 'Total berat';

  @override
  String get small => 'Small';

  @override
  String get medium => 'Medium';

  @override
  String get large => 'Large';

  @override
  String get add_delivery_detail => 'Tambah detail pengiriman';

  @override
  String get pickup_and_dropoff_must_be_set => 'Lokasi penjemputan dan tujuan harus diatur';

  @override
  String get start_quiz => 'Mulai Kuis';

  @override
  String get previous_attempt_failed => 'Percobaan sebelumnya gagal';

  @override
  String get previous_attempt_failed_description => 'Percobaan kuis Anda sebelumnya tidak lulus. Anda dapat mencoba lagi sekarang.';

  @override
  String get driver_knowledge_quiz_description => 'Selesaikan kuis ini untuk menunjukkan pemahaman Anda tentang pedoman driver, protokol keselamatan, dan aturan platform.';

  @override
  String get driver_knowledge_quiz => 'Kuis Pengetahuan Pengemudi';

  @override
  String get new_order_request => 'Permintaan pesanan baru';

  @override
  String get you_have_a_new_order_request_from_customer_please_check_your_orders_page => 'Anda memiliki permintaan pesanan baru dari pelanggan, silakan periksa halaman Pesanan Anda.';

  @override
  String get dismiss => 'Tutup';

  @override
  String get view_order => 'Lihat Pesanan';

  @override
  String get no_show => 'Tidak Hadir';

  @override
  String get popular_merchants => 'Mitra populer';

  @override
  String get choose_the_service_that_you_want => 'Pilih layanan yang Anda inginkan';

  @override
  String get pending_approval => 'Menunggu Persetujuan';

  @override
  String get approved => 'Disetujui';

  @override
  String get rejected => 'Ditolak';

  @override
  String get suspended => 'Ditangguhkan';

  @override
  String get app_version_information => 'Informasi aplikasi dan versi';

  @override
  String get about => 'Tentang';

  @override
  String get manage_notification_preferences => 'Kelola preferensi notifikasi';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get driver_preferences_and_settings => 'Preferensi dan pengaturan driver';

  @override
  String get settings => 'Pengaturan';

  @override
  String get save => 'Simpan';

  @override
  String get profile_updated_successfully => 'Profil berhasil diperbarui';

  @override
  String get license_plate_cannot_be_empty => 'Plat nomor tidak boleh kosong';

  @override
  String get enter_license_plate => 'Masukkan plat nomor';

  @override
  String get update_your_license_plate => 'Perbarui informasi plat nomor Anda';

  @override
  String get logged_out_successfully => 'Berhasil keluar';

  @override
  String get are_you_sure_you_want_to_logout => 'Apakah Anda yakin ingin keluar?';

  @override
  String get logout => 'Keluar';

  @override
  String get bank_account => 'Rekening Bank';

  @override
  String get uploaded => 'Diunggah';

  @override
  String get missing => 'Hilangan';

  @override
  String get student_card => 'Kartu Mahasiswa (KTM)';

  @override
  String get driver_license => 'SIM';

  @override
  String get vehicle_certificate => 'Sertifikat Kendaraan (STNK)';

  @override
  String get taking_orders => 'Menerima Pesanan';

  @override
  String get not_taking_orders => 'Tidak Menerima Pesanan';

  @override
  String get license_plate => 'Nomor Kendaraan: ';

  @override
  String get failed_to_load_profile => 'Gagal memuat profil';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get close => 'Tutup';

  @override
  String get chat_with_customer => 'Chat dengan Pelanggan';

  @override
  String get tap_the_phone_number_to_copy_it_then_use_your_phone_app_to_call => 'Ketuk nomor telepon untuk menyalinnya, lalu gunakan aplikasi telepon Anda untuk menelepon.';

  @override
  String get customer_phone_number => 'Nomor Telepon Pelanggan';

  @override
  String get mark_as_arrived => 'Tandai sebagai Tiba';

  @override
  String get no => 'Tidak';

  @override
  String get yes_cancel => 'Ya, Batalkan';

  @override
  String get are_you_sure_you_want_to_cancel_this_order => 'Apakah Anda yakin ingin membatalkan pesanan ini? Pelanggan akan diberitahu.';

  @override
  String get cancel_order => 'Batalkan Pesanan';

  @override
  String get start_trip => 'Mulai Perjalanan';

  @override
  String get cancel => 'Batal';

  @override
  String get are_you_sure_you_want_to_reject_this_order => 'Apakah Anda yakin ingin menolak pesanan ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get rate_customer => 'Beri Rating Pelanggan';

  @override
  String get back_to_home => 'Kembali ke Beranda';

  @override
  String get complete_trip => 'Selesaikan Perjalanan';

  @override
  String get reject_order => 'Tolak Pesanan';

  @override
  String get accept_order => 'Terima Pesanan';

  @override
  String get customer_phone_number_not_available => 'Nomor telepon pelanggan tidak tersedia';

  @override
  String get warning => 'Peringatan';

  @override
  String get customer_info => 'Info Pelanggan';

  @override
  String get distance => 'Jarak';

  @override
  String get fare => 'Tarif';

  @override
  String get service => 'Layanan';

  @override
  String get cancelled_by_user => 'Dibatalkan oleh Pengguna';

  @override
  String get cancelled_by_driver => 'Dibatalkan oleh Driver';

  @override
  String get cancelled_by_merchant => 'Dibatalkan oleh Mitra';

  @override
  String get cancelled_by_system => 'Dibatalkan oleh Sistem';

  @override
  String get preparing_order => 'Mempersiapkan Pesanan';

  @override
  String get finding_driver => 'Mencari Driver';

  @override
  String get pickup_location => 'Lokasi Penjemputan';

  @override
  String get dropoff_location => 'Lokasi Tujuan';

  @override
  String get schedule_added_successfully => 'Jadwal berhasil ditambahkan';

  @override
  String get schedule_updated_successfully => 'Jadwal berhasil diperbarui';

  @override
  String get delete_schedule => 'Hapus Jadwal';

  @override
  String are_you_sure_you_want_to_delete_schedule(Object name) {
    return 'Apakah Anda yakin ingin menghapus \"$name\"? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get sunday => 'Minggu';

  @override
  String get monday => 'Senin';

  @override
  String get tuesday => 'Selasa';

  @override
  String get wednesday => 'Rabu';

  @override
  String get thursday => 'Kamis';

  @override
  String get friday => 'Jumat';

  @override
  String get saturday => 'Sabtu';

  @override
  String get failed_to_add_schedule => ' Gagal menambahkan jadwal';

  @override
  String get failed_to_update_schedule => 'Gagal memperbarui jadwal';

  @override
  String get update => 'Perbarui';

  @override
  String get delete => 'Hapus';

  @override
  String get add => 'Tambah';

  @override
  String get please_enter_a_schedule_name => 'Tolong masukkan nama jadwal';

  @override
  String get disable_orders_during_this_time => 'Nonaktifkan pesanan selama waktu ini';

  @override
  String get repeat_every_week => 'Ulangi setiap minggu';

  @override
  String get start_time => 'Waktu Mulai';

  @override
  String get end_time => 'Waktu Selesai';

  @override
  String get day_of_week => 'Hari dalam Seminggu';

  @override
  String get schedule_name => 'Nama Jadwal';

  @override
  String get recurring => 'Berulang';

  @override
  String get add_your_class_schedule_to_automatically_disable_order_acceptance_during_class_time => 'Tambahkan jadwal kuliah Anda untuk menonaktifkan penerimaan pesanan secara otomatis selama jam kuliah';

  @override
  String get my_schedule => 'Jadwal Saya (KRS)';

  @override
  String get no_schedules_found => 'Tidak ada jadwal ditemukan';

  @override
  String get no_schedules_yet => 'Belum ada jadwal';

  @override
  String get schedule_deleted_successfully => 'Jadwal berhasil dihapus';

  @override
  String get failed_to_delete_schedule => 'Gagal menghapus jadwal';

  @override
  String get manage_schedule => 'Kelola Jadwal';

  @override
  String get leadeboard_and_badges => 'Papan Peringkat & Lencana';

  @override
  String get trips => 'Perjalanan';

  @override
  String get ready_to_accept_new_orders => 'Siap menerima pesanan baru';

  @override
  String get toggle_on_to_start_receiving_orders => 'Aktifkan untuk mulai menerima pesanan';

  @override
  String get requested => 'Dalam antrean';

  @override
  String get matching => 'Mencocokkan';

  @override
  String get preparing => 'Mempersiapkan';

  @override
  String get ready_for_pickup => 'Siap diambil';

  @override
  String get accepted => 'Diterima';

  @override
  String get arriving => 'Akan datang';

  @override
  String get in_trip => 'Sedang dalam perjalanan';

  @override
  String get your_completed_and_cancelled_orders_will_appear_here => 'Pesanan yang selesai dan dibatalkan akan muncul di sini';

  @override
  String get no_orders_found => 'Tidak ada pesanan ditemukan';

  @override
  String get all_types => 'Semua Jenis';

  @override
  String get all => 'Semua';

  @override
  String get completed => 'Selesai';

  @override
  String get in_progress => 'Dalam Proses';

  @override
  String get cancelled => 'Dibatalkan';

  @override
  String get failed_to_load_orders => 'Gagal memuat pesanan';

  @override
  String get top_up => 'Isi Ulang';

  @override
  String get withdrawal => 'Penarikan';

  @override
  String get payment => 'Pembayaran';

  @override
  String get refund => 'Pengembalian Dana';

  @override
  String get adjustment => 'Penyesuaian';

  @override
  String get commission => 'Komisi';

  @override
  String get earning => 'Penghasilan';

  @override
  String get failed_to_withdraw => 'Gagal menarik dana';

  @override
  String get withdraw => 'Tarik';

  @override
  String get please_enter_withdrawal_amount => 'Tolong masukkan jumlah penarikan';

  @override
  String get please_enter_bank_account_number => 'Tolong masukkan nomor rekening bank';

  @override
  String get insufficient_balance => 'Saldo tidak mencukupi';

  @override
  String get hint_account_name => 'Masukkan nama pemilik rekening bank';

  @override
  String get optional => 'Opsional';

  @override
  String get account_name => 'Nama Akun';

  @override
  String get hint_bank_account_number => 'Masukkan nomor rekening bank Anda';

  @override
  String get withdraw_earnings => 'Tarik Penghasilan';

  @override
  String get no_transactions_yet => 'Belum ada transaksi';

  @override
  String get view_all => 'Lihat Semua';

  @override
  String get recent_transactions => 'Transaksi Terbaru';

  @override
  String get net_earnings => 'Pendapatan Bersih';

  @override
  String get total_earnings => 'Total Penghasilan';

  @override
  String get total_income => 'Total Pemasukan';

  @override
  String get total_expenses => 'Total Pengeluaran';

  @override
  String get active => 'Aktif';

  @override
  String get inactive => 'Tidak aktif';

  @override
  String get available_balance => 'Saldo Tersedia';

  @override
  String get earnings_wallet => 'Penghasilan & Dompet';

  @override
  String get failed_to_load_earnings => 'Gagal memuat penghasilan';

  @override
  String get amount => 'Jumlah';

  @override
  String get unsupported_role_desc => 'Role tidak didukung di aplikasi ini. Silakan gunakan aplikasi web untuk mengakses akun Anda.';

  @override
  String get invalid_amount => 'Jumlah tidak valid';

  @override
  String get top_up_success => 'Top up berhasil';

  @override
  String get qr_code_expired => 'Kode QR telah kedaluwarsa';

  @override
  String hello(String name) {
    return 'Halo, $name';
  }

  @override
  String get payment_expired => 'Pembayaran telah kedaluwarsa';

  @override
  String get total => 'Total';

  @override
  String get e_wallet => 'Dompet Digital';

  @override
  String get my_balance => 'Saldo Saya';

  @override
  String get success_sign_in => 'Masuk berhasil';

  @override
  String get light_mode => 'Mode Terang';

  @override
  String get dark_mode => 'Mode Gelap';

  @override
  String get system_mode => 'Mode Sistem';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get forget_password => 'Lupa Kata Sandi?';

  @override
  String get sign_in => 'Masuk';

  @override
  String get loading => 'Memuat...';

  @override
  String get just_a_moment => 'Tunggu sebentar...';

  @override
  String get didnt_have_account => 'Belum punya akun?';

  @override
  String get sign_up => 'Daftar';

  @override
  String get lets_sign_in_to_the_akademove => 'Ayo Masuk ke AkadeMove!';

  @override
  String get language => 'Bahasa';

  @override
  String get theme => 'Tema';

  @override
  String get app_settings => 'Pengaturan Aplikasi';

  @override
  String get account_settings => 'Pengaturan Akun';

  @override
  String get terms_of_service => 'Ketentuan Layanan';

  @override
  String get privacy_policy => 'Kebijakan Privasi';

  @override
  String get faq => 'FAQ';

  @override
  String get i_agree_to_the => 'Saya setuju dengan';

  @override
  String get terms_and_conditions => 'Syarat dan Ketentuan';

  @override
  String get change_password => 'Ganti Kata Sandi';

  @override
  String get edit_profile => 'Sunting Profil';

  @override
  String get sign_out => 'Keluar';

  @override
  String get select_your_preferred_language => 'Pilih bahasa yang Anda inginkan';

  @override
  String get select_your_preferred_theme => 'Pilih tema yang Anda inginkan';

  @override
  String get history => 'Riwayat';

  @override
  String get home => 'Beranda';

  @override
  String get profile => 'Profil';

  @override
  String get an_error_occurred => 'Terjadi kesalahan';

  @override
  String get info => 'Informasi';

  @override
  String get success => 'Berhasil';

  @override
  String get error => 'Kesalahan';

  @override
  String get failed => 'Gagal';

  @override
  String get your_driver_is => 'Driver Anda adalah';

  @override
  String get origin => 'Asal';

  @override
  String get destination => 'Tujuan';

  @override
  String get special_instructions => 'Instruksi Khusus (Opsional)';

  @override
  String get special_instructions_hint => 'mis., \'Harap tangani dengan hati-hati\', \'Telepon sebelum mengantarkan\'';

  @override
  String get delivery_service => 'Layanan Pengiriman';

  @override
  String get back => 'Kembali';

  @override
  String get next => 'Lanjut';

  @override
  String get submit => 'Kirim';

  @override
  String get save_changes => 'Simpan Perubahan';

  @override
  String get allow => 'Izinkan';

  @override
  String get open_settings => 'Buka Pengaturan';

  @override
  String get send_reset_link => 'Kirim Kode OTP';

  @override
  String get back_to_sign_in => 'Kembali ke Halaman Masuk';

  @override
  String get reset_password => 'Atur Ulang Kata Sandi';

  @override
  String get otp_code => 'Kode OTP';

  @override
  String get otp_code_sent_to_email => 'Kami telah mengirimkan kode 6 digit ke email Anda.';

  @override
  String get placeholder_otp_code => 'Masukkan kode 6 digit';

  @override
  String get reject => 'Tolak';

  @override
  String get accept => 'Terima';

  @override
  String get grant_permission => 'Berikan Izin';

  @override
  String get send_alert => 'Kirim Peringatan';

  @override
  String get download_qr => 'Unduh QR';

  @override
  String get copy_qr_url => 'Salin URL QR';

  @override
  String get name => 'Nama';

  @override
  String get phone => 'Telepon';

  @override
  String get gender => 'Jenis Kelamin';

  @override
  String get photo => 'Foto';

  @override
  String get address => 'Alamat';

  @override
  String get location => 'Lokasi';

  @override
  String get unknown => 'Tidak Diketahui';

  @override
  String get user_role => 'Pengguna';

  @override
  String get driver_role => 'Driver';

  @override
  String get merchant_role => 'Mitra';

  @override
  String get student_id => 'NIM';

  @override
  String get confirm_password => 'Konfirmasi Kata Sandi';

  @override
  String get vehicle_registration => 'STNK';

  @override
  String get bank_provider => 'Bank';

  @override
  String get owner_name => 'Nama Pemilik';

  @override
  String get outlet_name => 'Nama Outlet';

  @override
  String get outlet_category => 'Kategori Outlet';

  @override
  String get outlet_location => 'Lokasi Outlet';

  @override
  String get government_document => 'Dokumen Identitas';

  @override
  String get bank_account_number => 'Nomor Rekening Bank';

  @override
  String get choose_service => 'Pilih layanan yang Anda inginkan';

  @override
  String get popular_merchant => 'Mitra populer';

  @override
  String get ride => 'Perjalanan';

  @override
  String get delivery => 'Pengiriman';

  @override
  String get mart => 'AMart';

  @override
  String get wallet => 'E-wallet';

  @override
  String get voucher => 'Voucher Saya';

  @override
  String get photo_profile => 'Foto Profil';

  @override
  String get old_password => 'Kata Sandi Lama';

  @override
  String get new_password => 'Kata Sandi Baru';

  @override
  String get confirm_new_password => 'Konfirmasi Kata Sandi Baru';

  @override
  String get this_month => 'Bulan ini';

  @override
  String get expenses => 'Pengeluaran';

  @override
  String get income => 'Pemasukan';

  @override
  String get payment_method_qris => 'QRIS';

  @override
  String get order_id => 'Pesanan #';

  @override
  String get pickup => 'Penjemputan';

  @override
  String get dropoff => 'Tujuan';

  @override
  String get earnings => 'Penghasilan';

  @override
  String get gender_preference => 'Preferensi gender: ';

  @override
  String get note => 'Catatan:';

  @override
  String get order_type_ride => 'Perjalanan';

  @override
  String get order_type_delivery => 'Pengiriman';

  @override
  String get order_type_food => 'Makanan';

  @override
  String get note_pickup => 'Penjemputan: ';

  @override
  String get note_dropoff => 'Tujuan: ';

  @override
  String get note_instructions => 'Instruksi: ';

  @override
  String get benefit_nearby_orders => 'Mencocokkan Anda dengan pesanan terdekat';

  @override
  String get benefit_track_arrival => 'Pelanggan dapat melacak kedatangan Anda';

  @override
  String get benefit_safety => 'Memastikan keamanan dan akuntabilitas';

  @override
  String get review_category => 'Kategori Ulasan';

  @override
  String get cleanliness => 'Kebersihan';

  @override
  String get courtesy => 'Kesopanan';

  @override
  String get comment_optional => 'Komentar (Opsional)';

  @override
  String get select_type => 'Pilih jenis darurat:';

  @override
  String get accident => 'Kecelakaan';

  @override
  String get harassment => 'Pelecehan';

  @override
  String get theft => 'Pencurian';

  @override
  String get medical => 'Darurat Medis';

  @override
  String get description => 'Deskripsi:';

  @override
  String get akademove_pay => 'Akademove Pay';

  @override
  String get valid_until => 'Berlaku sampai ';

  @override
  String get remaining_time => 'Waktu Tersisa :';

  @override
  String get atk => 'ATK (Alat Tulis Kantor)';

  @override
  String get printing => 'Percetakan';

  @override
  String get food => 'Makanan & Minuman';

  @override
  String get drag_marker => 'Geser untuk mengatur posisi';

  @override
  String get step_1 => 'Langkah 1';

  @override
  String get step_2 => 'Langkah 2';

  @override
  String get step_3 => 'Langkah 3';

  @override
  String get step_4 => 'Langkah 4';

  @override
  String get hint_bank_provider => 'Pilih bank';

  @override
  String get hint_outlet_category => 'Pilih kategori outlet';

  @override
  String get hint_search_location => 'Cari lokasi (mis., Monas Jakarta)';

  @override
  String get hint_share_experience => 'Bagikan pengalaman Anda...';

  @override
  String get hint_description => 'Jelaskan situasi darurat...';

  @override
  String get sign_up_choice => 'Mulai Perjalanan Anda Bersama Kami!';

  @override
  String get driver_sign_up_step1 => 'Ceritakan sedikit tentang diri Anda untuk memulai!';

  @override
  String get driver_sign_up_step2 => 'Unggah foto dan dokumen Anda untuk verifikasi akun!';

  @override
  String get driver_sign_up_step3 => 'Masukkan detail kendaraan Anda agar siap di jalan!';

  @override
  String get driver_sign_up_step4 => 'Tambahkan rekening bank untuk menerima penghasilan Anda dengan aman!';

  @override
  String get user_sign_up => 'Daftar sekarang — perjalanan atau makanan Anda hanya seketuk saja 🚴‍♂️🍔';

  @override
  String get merchant_sign_up_step1 => 'Ceritakan tentang diri Anda untuk memulai perjalanan mitra!';

  @override
  String get merchant_sign_up_step2 => 'Bagikan detail dan lokasi outlet agar pelanggan mudah menemukan Anda!';

  @override
  String get merchant_sign_up_step3 => 'Tambahkan rekening bank untuk menerima pembayaran dengan aman!';

  @override
  String get forgot_password => 'Lupa Kata Sandi';

  @override
  String get driver_dashboard => 'Beranda Driver';

  @override
  String get order_history => 'Riwayat Pesanan';

  @override
  String get merchant_edit_profile => 'Sunting Profil';

  @override
  String get setup_outlet => 'Atur Outlet';

  @override
  String get order_detail => 'Detail Pesanan';

  @override
  String get menu_detail => 'Detail Menu';

  @override
  String get sales_report => 'Laporan Penjualan';

  @override
  String get commission_report => 'Laporan Komisi';

  @override
  String get merchant_change_password => 'Ganti Kata Sandi';

  @override
  String get where_you_at => 'Posisi Anda di mana?';

  @override
  String get where_going => 'Mau ke mana?';

  @override
  String get on_trip => 'Sedang Perjalanan';

  @override
  String get trip_details => 'Detail Perjalanan';

  @override
  String get create_menu => 'Buat Menu';

  @override
  String get edit_menu => 'Sunting Menu';

  @override
  String get sign_up_success => 'Pendaftaran Berhasil';

  @override
  String get sign_up_failed => 'Pendaftaran Gagal';

  @override
  String get location_permission => 'Izin Lokasi';

  @override
  String get permission_denied => 'Izin Ditolak';

  @override
  String get location_disabled => 'Layanan Lokasi Dinonaktifkan';

  @override
  String get location_permission_required => 'Izin Lokasi Diperlukan';

  @override
  String get search_error => 'Kesalahan Pencarian';

  @override
  String get location_found => 'Lokasi Ditemukan';

  @override
  String get not_found => 'Tidak Ditemukan';

  @override
  String get validation_error => 'Kesalahan Validasi';

  @override
  String get oops => 'Ups...';

  @override
  String new_order(String type) {
    return 'Pesanan $type Baru';
  }

  @override
  String get order_unavailable => 'Pesanan Tidak Tersedia';

  @override
  String get order_rejected => 'Pesanan Ditolak';

  @override
  String get alert => 'Peringatan Darurat';

  @override
  String get report_emergency => 'Laporkan Darurat';

  @override
  String get confirm_logout => 'Keluar';

  @override
  String get delete_menu => 'Hapus Menu';

  @override
  String get description_user_role => 'Nikmati perjalanan yang nyaman dan aman ke tujuan Anda.';

  @override
  String get description_driver_role => 'Dapatkan penghasilan tambahan dengan mengemudi bersama kami.';

  @override
  String get description_merchant_role => 'Perluas jangkauan bisnis Anda dengan platform kami.';

  @override
  String get description_forgot_password => 'Masukkan email Anda untuk menerima instruksi reset kata sandi';

  @override
  String get description_reset_password => 'Masukkan kata sandi baru Anda';

  @override
  String get helper_outlet_category => 'Pilih kategori utama untuk outlet Anda';

  @override
  String get helper_outlet_location => 'Cari lokasi, ketuk peta, atau geser penanda';

  @override
  String get error_password_mismatch => 'Kata sandi tidak cocok';

  @override
  String get error_file_required => 'File tidak boleh kosong';

  @override
  String get error_photo_pick_failed => 'Gagal memilih foto';

  @override
  String get error_unknown => 'Kesalahan tidak diketahui';

  @override
  String get error_unexpected => 'Terjadi kesalahan yang tidak terduga';

  @override
  String get error_complete_required_fields => 'Mohon lengkapi semua kolom yang wajib diisi';

  @override
  String get error_fill_required_fields => 'Mohon isi semua kolom yang wajib diisi';

  @override
  String get error_location_search_empty => 'Mohon masukkan lokasi untuk dicari';

  @override
  String get error_location_not_found => 'Lokasi tidak ditemukan. Silakan coba pencarian lain.';

  @override
  String get error_location_search_failed => 'Tidak dapat mencari lokasi. Mohon periksa koneksi internet Anda.';

  @override
  String get error_address_unavailable => 'Tidak dapat mendapatkan alamat';

  @override
  String get error_invalid_reset_token => 'Token reset tidak valid atau tidak ada';

  @override
  String get error_description_required => 'Mohon berikan deskripsi';

  @override
  String get error_access_denied => 'Akses ditolak. Mohon berikan izin di pengaturan.';

  @override
  String get error_storage_full => 'Ruang penyimpanan tidak cukup.';

  @override
  String get error_format_unsupported => 'Format gambar tidak didukung.';

  @override
  String get error_unexpected_prefix => 'Kesalahan tak terduga: ';

  @override
  String get error_qr_save_failed => 'Gagal menyimpan kode QR: ';

  @override
  String get error_qr_copy_failed => 'Gagal menyalin URL QR: ';

  @override
  String get error_review_submit_failed => 'Gagal mengirim ulasan';

  @override
  String get error_invalid_amount => 'Jumlah tidak valid';

  @override
  String get error_top_up_minimum => 'Jumlah isi ulang minimal Rp 10.000';

  @override
  String get error_failed_to_estimate => 'Gagal memperkirakan pesanan';

  @override
  String get error_get_estimate_first => 'Mohon dapatkan perkiraan terlebih dahulu';

  @override
  String get error_fill_all_fields => 'Mohon isi semua kolom dengan benar';

  @override
  String get error_enter_bank_account => 'Mohon masukkan nomor rekening bank';

  @override
  String get error_select_bank_first => 'Mohon pilih bank terlebih dahulu';

  @override
  String get success_sign_up => 'Pendaftaran berhasil';

  @override
  String get success_location_found => 'Penanda dipindahkan ke lokasi yang dicari';

  @override
  String get success_review_submitted => 'Ulasan berhasil dikirim';

  @override
  String get success_qr_saved => 'Kode QR berhasil disimpan';

  @override
  String get success_qr_url_copied => 'URL QR disalin ke clipboard';

  @override
  String get success_menu_updated => 'Menu berhasil diperbarui';

  @override
  String get success_bank_verified => 'Rekening bank berhasil diverifikasi';

  @override
  String get message_remember_password => 'Ingat kata sandi Anda?';

  @override
  String get message_location_default => 'Menggunakan lokasi default. Anda dapat menggeser penanda untuk mengatur lokasi outlet Anda.';

  @override
  String get message_leocation_permission_required => 'Izin lokasi diperlukan untuk mengatur lokasi outlet Anda secara otomatis.';

  @override
  String get message_location_permission_explanation => 'Kami memerlukan akses ke lokasi Anda untuk mengatur lokasi outlet Anda di peta secara otomatis. Ini membantu pelanggan menemukan bisnis Anda dengan mudah.\n\nAnda juga dapat mengatur lokasi secara manual dengan menggeser penanda.';

  @override
  String get message_location_services_disabled => 'Layanan lokasi saat ini dinonaktifkan di perangkat Anda. Mohon aktifkan untuk mendeteksi lokasi outlet Anda secara otomatis.';

  @override
  String get message_location_permission_denied_forever => 'Izin lokasi telah ditolak secara permanen. Untuk menggunakan deteksi lokasi otomatis, mohon aktifkan di pengaturan aplikasi.\n\nAnda masih dapat mengatur lokasi outlet Anda secara manual dengan menggeser penanda di peta.';

  @override
  String get message_order_unavailable => 'Pesanan ini dibatalkan atau diterima oleh driver lain';

  @override
  String get message_order_rejected => 'Anda menolak pesanan';

  @override
  String get message_location_permission_denied_permanent => 'Izin lokasi sebelumnya ditolak. Untuk online dan menerima pesanan, Anda perlu mengaktifkan akses lokasi di pengaturan perangkat.';

  @override
  String get message_location_permission_explanation_driver => 'Untuk menerima pesanan perjalanan dan pengiriman, driver harus membagikan lokasi mereka secara real-time. Ini membantu:';

  @override
  String get message_redirect_settings => 'Anda akan diarahkan ke pengaturan aplikasi untuk mengaktifkan akses lokasi.';

  @override
  String message_rate_experience(String name) {
    return 'Bagaimana pengalaman Anda dengan $name?';
  }

  @override
  String get message_confirmation => 'Ini akan mengirim peringatan darurat ke otoritas kampus dan memberi tahu kontak darurat. Apakah Anda yakin ingin melanjutkan?';

  @override
  String get message_settings_coming_soon => 'Fitur pengaturan akan segera hadir';

  @override
  String get message_failed_load_profile => 'Gagal memuat profil: ';

  @override
  String get message_failed_update_menu => 'Gagal memperbarui menu';

  @override
  String get message_failed_verify_bank => 'Gagal memverifikasi rekening bank';

  @override
  String get message_confirm_reject_order => 'Apakah Anda yakin ingin menolak pesanan ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get message_confirm_cancel_order => 'Apakah Anda yakin ingin membatalkan pesanan ini? Pelanggan akan diberitahu.';

  @override
  String message_confirm_delete_schedule(String name) {
    return 'Apakah Anda yakin ingin menghapus \"$name\"? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get message_confirm_logout => 'Apakah Anda yakin ingin keluar?';

  @override
  String get message_confirm_accept_order => 'Apakah Anda yakin ingin menerima pesanan ini?';

  @override
  String get message_confirm_delete_menu => 'Apakah Anda yakin ingin menghapus menu ini?';

  @override
  String get message_select_reject_reason => 'Mohon pilih alasan untuk menolak pesanan ini:';

  @override
  String get dragging_marker => 'Menggeser...';

  @override
  String get welcome_back => 'Selamat datang kembali!';

  @override
  String rating(String rating) {
    return 'Rating $rating';
  }

  @override
  String get driver_status => 'Status Driver';

  @override
  String get accepting_orders => 'Anda menerima pesanan';

  @override
  String get offline => 'Anda offline';

  @override
  String get ready_accept => 'Siap menerima pesanan baru';

  @override
  String get toggle_receive => 'Aktifkan untuk mulai menerima pesanan';

  @override
  String get today_performance => 'Performa Hari Ini';

  @override
  String get quick_actions => 'Aksi Cepat';

  @override
  String get open_today => 'Buka Hari Ini';

  @override
  String get operating_hours => '10.00 - 22.00 WIB';

  @override
  String get sales_recap => 'Rekap Penjualan';

  @override
  String get today_transaction => 'Transaksi hari ini';

  @override
  String get today_gross_sales => 'Penjualan kotor hari ini';

  @override
  String get see_detail => 'Lihat detail';

  @override
  String get send_packages => 'Kirim paket di dalam kampus';

  @override
  String get max_weight => 'Maks berat: 20kg';

  @override
  String get fast_delivery => 'Pengiriman cepat';

  @override
  String get secure_handling => 'Penanganan aman';

  @override
  String get start_delivery => 'Mulai Pengiriman';

  @override
  String get choose_pickup_destination => 'Pilih titik penjemputan dan tujuan Anda!';

  @override
  String rating_score(String score) {
    return 'Rating: $score / 5.0';
  }

  @override
  String get action_take_photo => 'Ambil foto';

  @override
  String get action_choose_gallery => 'Pilih dari galeri';

  @override
  String get action_remove_image => 'Hapus gambar';

  @override
  String get enter_withdrawal_amount => 'Masukkan jumlah penarikan';

  @override
  String get withdraw_wallet_save_bank => 'Simpan data bank untuk penarikan selanjutnya';

  @override
  String get cart_shopping_cart => 'Keranjang Belanja';

  @override
  String get cart_your_cart_is_empty => 'Keranjang Anda kosong';

  @override
  String get cart_add_items_to_see_here => 'Tambahkan item dari AMart untuk melihatnya di sini';

  @override
  String get cart_browse_amart => 'Jelajahi AMart';

  @override
  String cart_total_items(int count) {
    return 'Total ($count item)';
  }

  @override
  String get cart_checkout => 'Checkout';

  @override
  String get cart_coming_soon => 'Segera Hadir';

  @override
  String get cart_order_confirmation_coming_soon => 'Layar konfirmasi pesanan segera hadir';

  @override
  String get cart_clear_cart => 'Kosongkan Keranjang?';

  @override
  String get cart_clear_cart_confirmation => 'Apakah Anda yakin ingin menghapus semua item dari keranjang Anda?';

  @override
  String get cart_clear => 'Kosongkan';

  @override
  String get cart_failed_to_load => 'Gagal memuat keranjang';

  @override
  String get cart_note_prefix => 'Catatan: ';

  @override
  String get cart_replace_cart_items => 'Ganti Item Keranjang?';

  @override
  String cart_contains_items_from(String merchantName) {
    return 'Keranjang Anda berisi item dari $merchantName.';
  }

  @override
  String cart_discard_and_add_from(String merchantName) {
    return 'Apakah Anda ingin membuang item tersebut dan menambahkan item dari $merchantName?';
  }

  @override
  String get cart_current_cart_will_be_cleared => 'Keranjang Anda saat ini akan dikosongkan';

  @override
  String get cart_replace_cart => 'Ganti Keranjang';

  @override
  String get menu_details => 'Detail Menu';

  @override
  String menu_in_stock(int count) {
    return 'Tersedia ($count stok)';
  }

  @override
  String get menu_out_of_stock => 'Stok Habis';

  @override
  String get menu_quantity => 'Jumlah';

  @override
  String get menu_special_notes_optional => 'Catatan Khusus (Opsional)';

  @override
  String get menu_total_price => 'Total Harga';

  @override
  String get menu_add_to_cart => 'Tambah ke Keranjang';

  @override
  String get menu_added_to_cart => 'Ditambahkan ke Keranjang';

  @override
  String get menu_item_added_to_cart => 'Item telah ditambahkan ke keranjang Anda';

  @override
  String get order_confirm_title => 'Konfirmasi Pesanan';

  @override
  String get order_confirm_order_summary => 'Ringkasan Pesanan';

  @override
  String get order_confirm_merchant => 'Merchant';

  @override
  String order_confirm_items_count(int count) {
    return '$count item';
  }

  @override
  String get order_confirm_subtotal => 'Subtotal';

  @override
  String get order_confirm_payment_method => 'Metode Pembayaran';

  @override
  String get order_confirm_select_payment => 'Pilih metode pembayaran';

  @override
  String get order_confirm_payment_wallet => 'Dompet';

  @override
  String get order_confirm_payment_description => 'Bayar menggunakan saldo dompet Akademove Anda';

  @override
  String get order_confirm_place_order => 'Buat Pesanan';

  @override
  String get order_confirm_success => 'Pesanan Berhasil Dibuat';

  @override
  String get order_confirm_success_message => 'Pesanan Anda telah dibuat dan sedang diproses';

  @override
  String get order_confirm_failed => 'Gagal Membuat Pesanan';

  @override
  String get order_confirm_processing => 'Memproses Pesanan...';

  @override
  String get order_confirm_insufficient_balance => 'Saldo dompet tidak mencukupi';

  @override
  String get rate_your_experience => 'Beri Rating Pengalaman Anda';

  @override
  String get overall_rating => 'Rating Keseluruhan';

  @override
  String get cleanliness_rating => 'Kebersihan';

  @override
  String get courtesy_rating => 'Kesopanan';

  @override
  String get other_rating => 'Lainnya';

  @override
  String get add_comment_optional => 'Tambahkan Komentar (Opsional)';

  @override
  String get submit_review => 'Kirim Ulasan';

  @override
  String get review_submitted_successfully => 'Ulasan berhasil dikirim';

  @override
  String get review_submission_failed => 'Gagal mengirim ulasan';

  @override
  String get you_already_reviewed_order => 'Anda sudah memberi ulasan untuk pesanan ini';

  @override
  String get order_must_be_completed_first => 'Pesanan harus diselesaikan terlebih dahulu';

  @override
  String get rating_required => 'Mohon berikan rating';

  @override
  String get coupon_no_coupons_available => 'Tidak ada kupon tersedia';

  @override
  String get coupon_select_coupon => 'Pilih Kupon';

  @override
  String get coupon_remove_coupon => 'Hapus Kupon';

  @override
  String get payment_method_wallet => 'Dompet';

  @override
  String get payment_method_bank_transfer => 'Transfer Bank';

  @override
  String get emergency_alert_sent_successfully => 'Peringatan darurat berhasil dikirim';

  @override
  String get emergency_alert_title => 'Peringatan Darurat';

  @override
  String get emergency_report_title => 'Laporkan Darurat';

  @override
  String get emergency_select_type => 'Pilih jenis darurat:';

  @override
  String get emergency_describe_situation => 'Jelaskan situasi darurat...';

  @override
  String get emergency_send_alert => 'Kirim Peringatan';

  @override
  String get button_continue => 'Lanjutkan';

  @override
  String get leaderboard_title => 'Papan Peringkat';

  @override
  String get leaderboard_no_rankings => 'Belum ada peringkat';

  @override
  String get leaderboard_no_badges => 'Tidak ada lencana tersedia';

  @override
  String get leaderboard_pts => 'poin';

  @override
  String get chat_no_messages => 'Belum ada pesan';

  @override
  String get merchant_order_accept => 'Terima';

  @override
  String get merchant_order_time_remaining => '01:00';

  @override
  String get gender_label => 'Jenis Kelamin:';

  @override
  String get top_up_qris => 'Isi Ulang QRIS';

  @override
  String get rate_your_driver => 'Beri Rating Driver Anda';

  @override
  String get placeholder_name => 'John Doe';

  @override
  String get placeholder_email => 'john@gmail.com';

  @override
  String get placeholder_password => '********';

  @override
  String get dialog_location_permission => 'Izin Lokasi';

  @override
  String get dialog_location_services_disabled => 'Layanan Lokasi Dinonaktifkan';

  @override
  String get dialog_location_permission_required => 'Izin Lokasi Diperlukan';

  @override
  String get drag_to_adjust => 'Geser untuk mengatur posisi';

  @override
  String get error_enter_location_to_search => 'Mohon masukkan lokasi untuk dicari';

  @override
  String get success_signed_up => 'Pendaftaran berhasil';

  @override
  String get error_fill_all_required_fields => 'Mohon isi semua kolom yang diperlukan dengan benar';

  @override
  String get error_complete_all_required_fields => 'Mohon lengkapi semua kolom yang wajib diisi';

  @override
  String get error_passwords_not_match => 'Kata sandi tidak cocok';

  @override
  String get merchant_step_1_description => 'Ceritakan tentang diri Anda untuk memulai perjalanan mitra!';

  @override
  String get merchant_step_2_description => 'Bagikan detail dan lokasi outlet agar pelanggan mudah menemukan Anda!';

  @override
  String get merchant_step_3_description => 'Tambahkan rekening bank untuk menerima pembayaran dengan aman!';

  @override
  String get placeholder_outlet_name => 'Masukkan nama outlet';

  @override
  String get label_outlet_location => 'Lokasi Outlet';

  @override
  String get label_bank_provider => 'Bank';

  @override
  String get label_outlet_category => 'Kategori Outlet';

  @override
  String get helper_outlet_category_select => 'Pilih kategori utama untuk outlet Anda';

  @override
  String get placeholder_select_outlet_category => 'Pilih kategori outlet';

  @override
  String get label_phone => 'Telepon';

  @override
  String get dialog_accept_order => 'Terima Pesanan';

  @override
  String get dialog_accept_order_confirm => 'Apakah Anda yakin ingin menerima pesanan ini?';

  @override
  String get toast_validation_error => 'Kesalahan Validasi';

  @override
  String get error_menu_name_required => 'Nama menu wajib diisi';

  @override
  String get error_menu_price_required => 'Harga menu wajib diisi';

  @override
  String get error_valid_price_required => 'Mohon masukkan harga yang valid';

  @override
  String get error_merchant_info_not_found => 'Informasi merchant tidak ditemukan';

  @override
  String get success_menu_created => 'Menu berhasil dibuat';

  @override
  String get error_failed_create_menu => 'Gagal membuat menu';

  @override
  String get title_create_menu => 'Buat Menu';

  @override
  String get placeholder_zero => '0';

  @override
  String get error_menu_info_not_found => 'Informasi menu tidak ditemukan';

  @override
  String get title_edit_menu => 'Edit Menu';

  @override
  String get error_menu_not_found => 'Menu tidak ditemukan';

  @override
  String get placeholder_search_menu => 'Cari menu...';

  @override
  String get title_menu_detail => 'Detail Menu';

  @override
  String get dialog_delete_menu => 'Hapus Menu';

  @override
  String dialog_delete_menu_confirm(String name) {
    return 'Apakah Anda yakin ingin menghapus \"$name\"?';
  }

  @override
  String get success_menu_deleted => 'Menu berhasil dihapus';

  @override
  String get error_failed_delete_menu => 'Gagal menghapus menu';

  @override
  String get label_old_password => 'Kata Sandi Lama';

  @override
  String get placeholder_enter_old_password => 'Masukkan kata sandi lama Anda';

  @override
  String get label_new_password => 'Kata Sandi Baru';

  @override
  String get placeholder_enter_new_password => 'Masukkan kata sandi baru Anda';

  @override
  String get label_confirm_password => 'Konfirmasi Kata Sandi';

  @override
  String get placeholder_confirm_new_password => 'Konfirmasi kata sandi baru Anda';

  @override
  String get error_failed_verify_bank => 'Gagal memverifikasi rekening bank';

  @override
  String get loading_map => 'Memuat peta...';

  @override
  String get success_set_up_merchant => 'Berhasil menyiapkan merchant';

  @override
  String get title_set_up_outlet => 'Atur Outlet';

  @override
  String get placeholder_time_start => '10:00';

  @override
  String get placeholder_time_end => '22:00';

  @override
  String get title_sales_report => 'Laporan Penjualan';

  @override
  String get tab_weekly_sales => 'Penjualan Mingguan';

  @override
  String get tab_monthly_sales => 'Penjualan Bulanan';

  @override
  String get title_commission_report => 'Laporan Komisi';

  @override
  String get title_order_detail => 'Detail Pesanan';

  @override
  String get button_add_schedule => 'Tambah Jadwal';

  @override
  String get button_edit => 'Edit';

  @override
  String get placeholder_class_name => 'mis., Pemrograman Mobile';

  @override
  String get dialog_call_customer => 'Telepon Pelanggan';

  @override
  String get section_today_performance => 'Performa Hari Ini';

  @override
  String get section_quick_actions => 'Aksi Cepat';

  @override
  String get label_rating_suffix => 'rating';

  @override
  String get dialog_rate_customer => 'Beri Rating Pelanggan';

  @override
  String get label_review_category => 'Kategori Ulasan';

  @override
  String get label_comment_optional => 'Komentar (Opsional)';

  @override
  String get placeholder_share_experience => 'Bagikan pengalaman Anda...';

  @override
  String get button_submit => 'Kirim';

  @override
  String dialog_new_order(String type) {
    return 'Pesanan $type Baru';
  }

  @override
  String get label_order_id_prefix => 'Pesanan #';

  @override
  String get label_pickup => 'Penjemputan';

  @override
  String get label_dropoff => 'Tujuan';

  @override
  String get label_distance => 'Jarak';

  @override
  String get label_earnings => 'Penghasilan';

  @override
  String label_gender_preference(String gender) {
    return 'Preferensi gender: $gender';
  }

  @override
  String get label_note => 'Catatan:';

  @override
  String label_pickup_prefix(String location) {
    return 'Penjemputan: $location';
  }

  @override
  String label_dropoff_prefix(String location) {
    return 'Tujuan: $location';
  }

  @override
  String label_instructions_prefix(String instructions) {
    return 'Instruksi: $instructions';
  }

  @override
  String get order_type_ride_label => 'Perjalanan';

  @override
  String get order_type_delivery_label => 'Pengiriman';

  @override
  String get order_type_food_label => 'Makanan';

  @override
  String get toast_order_unavailable => 'Pesanan Tidak Tersedia';

  @override
  String get toast_order_unavailable_message => 'Pesanan ini dibatalkan atau diterima oleh driver lain';

  @override
  String get toast_order_rejected => 'Pesanan Ditolak';

  @override
  String get toast_order_rejected_message => 'Anda menolak pesanan';

  @override
  String get label_total_fare => 'Total Biaya';

  @override
  String get dialog_unsupported_payment => 'Metode pembayaran tidak didukung';

  @override
  String get dialog_unsupported_payment_message => 'Metode pembayaran yang dipilih tidak didukung. Silakan pilih metode lain.';

  @override
  String get label_provider => 'Penyedia :';

  @override
  String get label_va_number => 'Nomor VA :';

  @override
  String label_valid_until(String date) {
    return 'Berlaku sampai $date';
  }

  @override
  String get label_remaining_time => 'Waktu Tersisa :';

  @override
  String get button_copy_va_number => 'Salin Nomor VA';

  @override
  String get label_no_rating_yet => 'Belum ada rating';

  @override
  String get message_wait_for_driver => 'Mohon tunggu sementara kami mencocokkan Anda dengan driver';

  @override
  String get label_license_plate => 'Plat nomor';

  @override
  String get status_finding_driver => 'Mencari driver';

  @override
  String get status_your_driver => 'Driver Anda';

  @override
  String get instruction_choose_pickup_destination => 'Pilih titik penjemputan dan tujuan Anda!';

  @override
  String get button_proceed => 'Lanjutkan';

  @override
  String get placeholder_what_sending => 'Apa yang Anda kirim?';

  @override
  String get placeholder_enter_weight => 'Masukkan berat dalam kg (maks 20kg)';

  @override
  String get helper_special_instructions => 'Tambahkan instruksi penanganan atau pengiriman khusus';

  @override
  String get helper_add_photos => 'Tambahkan hingga 3 foto item';

  @override
  String get error_provide_item_description => 'Mohon berikan deskripsi item';

  @override
  String get error_no_estimate_available => 'Tidak ada perkiraan tersedia';

  @override
  String get button_choose_payment_method => 'Pilih Metode Pembayaran';

  @override
  String get button_place_order => 'Buat Pesanan';

  @override
  String get label_photo_profile => 'Foto Profil';

  @override
  String get label_name => 'Nama';

  @override
  String get label_email => 'Email';

  @override
  String get section_achievements => 'Pencapaian';

  @override
  String get button_rate_this_order => 'Beri rating pesanan ini';

  @override
  String get empty_no_order_history => 'Tidak ada riwayat pesanan';

  @override
  String get label_your_current_location => 'Lokasi Anda saat ini';

  @override
  String label_drivers_around(int count) {
    return 'Ada $count driver di sekitar Anda';
  }

  @override
  String get error_failed_load_mart => 'Gagal memuat data mart';

  @override
  String get error_failed_load_merchants => 'Gagal memuat merchant';

  @override
  String get empty_no_merchants_found => 'Tidak ada merchant ditemukan';

  @override
  String get button_select_via_map => 'Pilih melalui peta';

  @override
  String get error_no_place_found => 'Tidak ada tempat ditemukan';

  @override
  String get title_select_bank_provider => 'Pilih Bank';

  @override
  String get payment_akademove_pay => 'Akademove Pay';

  @override
  String get button_download_qr => 'Unduh QR';

  @override
  String get button_copy_qr_url => 'Salin URL QR';

  @override
  String get separator_colon => ':';

  @override
  String get placeholder_type_message => 'Ketik pesan...';

  @override
  String get tab_on_process => 'Dalam proses';

  @override
  String get tab_completed => 'Selesai';

  @override
  String get tab_canceled => 'Dibatalkan';

  @override
  String get start_preparing => 'Mulai Siapkan';

  @override
  String get order_ready => 'Pesanan Siap';

  @override
  String get waiting_for_driver_pickup => 'Menunggu driver untuk mengambil...';

  @override
  String get no_menu_items_yet => 'Belum ada menu. Ketuk + untuk menambahkan menu pertama Anda.';

  @override
  String no_menu_items_found(String query) {
    return 'Tidak ada menu ditemukan untuk \"$query\"';
  }

  @override
  String get placeholder_search_menu_hint => 'Cari menu...';

  @override
  String get label_menu_name => 'Nama Menu';

  @override
  String get label_menu_price => 'Harga Menu';

  @override
  String get label_menu_stock => 'Stok Menu';

  @override
  String get label_menu_category => 'Kategori Menu';

  @override
  String get label_menu_photo => 'Foto Menu';

  @override
  String get placeholder_menu_name => 'Masukkan nama menu';

  @override
  String get placeholder_menu_price => 'Masukkan harga';

  @override
  String get label_category => 'Kategori';

  @override
  String get label_price => 'Harga';

  @override
  String get label_stock => 'Stok';

  @override
  String get label_created => 'Dibuat';

  @override
  String get label_updated => 'Diperbarui';

  @override
  String get placeholder_select_category => 'Pilih kategori';

  @override
  String get error_validation => 'Kesalahan Validasi';

  @override
  String get title_privacy_policies => 'Kebijakan Privasi';

  @override
  String get ordered_by => 'Dipesan oleh';

  @override
  String get driver_assigned => 'Driver ditugaskan';

  @override
  String get order_items => 'Item Pesanan';

  @override
  String get base_price => 'Harga Dasar';

  @override
  String get order_time => 'Waktu Pesanan';

  @override
  String get order_chat => 'Chat Pesanan';

  @override
  String get toast_order_accepted => 'Pesanan berhasil diterima';

  @override
  String get toast_order_rejected_success => 'Pesanan berhasil ditolak';

  @override
  String get toast_order_marked_preparing => 'Pesanan ditandai sedang disiapkan';

  @override
  String get toast_order_marked_ready => 'Pesanan ditandai siap diambil';

  @override
  String get toast_failed_accept_order => 'Gagal menerima pesanan';

  @override
  String get toast_failed_reject_order => 'Gagal menolak pesanan';

  @override
  String get toast_failed_update_order => 'Gagal memperbarui pesanan';

  @override
  String get toast_merchant_id_not_found => 'ID Merchant tidak ditemukan';

  @override
  String get unknown_item => 'Item Tidak Diketahui';

  @override
  String get label_status => 'Status';

  @override
  String get label_wib => 'WIB';

  @override
  String get error_valid_price => 'Mohon masukkan harga yang valid';

  @override
  String get toast_menu_created_success => 'Menu berhasil dibuat';

  @override
  String get toast_failed_create_menu => 'Gagal membuat menu';

  @override
  String get toast_menu_updated_success => 'Menu berhasil diperbarui';

  @override
  String get toast_failed_update_menu => 'Gagal memperbarui menu';

  @override
  String get button_create_menu => 'Buat Menu';

  @override
  String get button_create => 'Buat';

  @override
  String get label_menu_description => 'Deskripsi Menu';

  @override
  String get placeholder_menu_description => 'Kopi dengan gula merah';

  @override
  String get placeholder_menu_category => 'Minuman';

  @override
  String get label_menu_photo_optional => 'Foto Menu (Opsional)';

  @override
  String get title_edit_profile => 'Edit Profil';

  @override
  String get label_owner_name => 'Nama Pemilik';

  @override
  String get placeholder_owner_name => 'Masukkan nama pemilik';

  @override
  String get label_owner_email => 'Email Pemilik';

  @override
  String get placeholder_owner_email => 'Masukkan email pemilik';

  @override
  String get label_owner_phone => 'Nomor Telepon Pemilik';

  @override
  String get label_outlet_name => 'Nama Outlet';

  @override
  String get label_outlet_phone => 'Nomor Telepon Outlet';

  @override
  String get label_outlet_email => 'Email Outlet';

  @override
  String get placeholder_outlet_email => 'Masukkan email outlet';

  @override
  String get label_outlet_document => 'Dokumen Outlet (Opsional)';

  @override
  String get label_choose_bank => 'Pilih bank';

  @override
  String get placeholder_select_bank_provider => 'Pilih provider bank';

  @override
  String get label_bank_account => 'Rekening Bank';

  @override
  String get placeholder_bank_account => '********1234';

  @override
  String get toast_location_permission => 'Izin Lokasi';

  @override
  String get toast_using_default_location => 'Menggunakan lokasi default. Anda dapat menyeret penanda untuk mengatur lokasi outlet Anda.';

  @override
  String get dialog_location_permission_title => 'Izin Lokasi';

  @override
  String get dialog_location_permission_message => 'Kami memerlukan akses ke lokasi Anda untuk mengatur lokasi outlet Anda secara otomatis di peta. Ini membantu pelanggan menemukan bisnis Anda dengan mudah. Anda juga dapat mengatur lokasi secara manual dengan menyeret penanda.';

  @override
  String get dialog_location_services_disabled_title => 'Layanan Lokasi Dinonaktifkan';

  @override
  String get dialog_location_services_disabled_message => 'Layanan lokasi saat ini dinonaktifkan di perangkat Anda. Mohon aktifkan untuk mendeteksi lokasi outlet Anda secara otomatis.';

  @override
  String get dialog_location_permission_required_title => 'Izin Lokasi Diperlukan';

  @override
  String get dialog_location_permission_required_message => 'Izin lokasi telah ditolak secara permanen. Untuk menggunakan deteksi lokasi otomatis, mohon aktifkan di pengaturan aplikasi Anda.\n\nAnda masih dapat mengatur lokasi outlet Anda secara manual dengan menyeret penanda di peta.';

  @override
  String get label_outlet_location_description => 'Pastikan titik lokasi di peta sudah benar untuk memenuhi persyaratan pendaftaran.';

  @override
  String get placeholder_search_location => 'Cari lokasi';

  @override
  String get label_dragging => 'Menyeret...';

  @override
  String get toast_location_found => 'Lokasi Ditemukan';

  @override
  String get toast_marker_moved => 'Penanda dipindahkan ke lokasi yang dicari';

  @override
  String get toast_not_found => 'Tidak Ditemukan';

  @override
  String get toast_location_not_found => 'Lokasi tidak ditemukan. Silakan coba pencarian lain.';

  @override
  String get toast_search_error => 'Kesalahan Pencarian';

  @override
  String get toast_search_error_message => 'Tidak dapat mencari lokasi. Mohon periksa koneksi internet Anda.';

  @override
  String get toast_enter_location => 'Mohon masukkan lokasi untuk dicari';

  @override
  String get label_benchmark_optional => 'Patokan (Opsional)';

  @override
  String get placeholder_benchmark => 'Samping toko Uniqlo.';

  @override
  String get toast_bank_account_verified => 'Rekening bank berhasil diverifikasi';

  @override
  String get toast_failed_verify_bank => 'Gagal memverifikasi rekening bank';

  @override
  String get toast_enter_bank_account => 'Mohon masukkan nomor rekening bank';

  @override
  String get toast_bank_account_min_digits => 'Nomor rekening bank minimal 5 digit';

  @override
  String get toast_select_bank_first => 'Mohon pilih provider bank terlebih dahulu';

  @override
  String get label_bank_account_number => 'Nomor Rekening Bank';

  @override
  String get label_account_holder_name => 'Nama Pemegang Rekening';

  @override
  String get label_owner_bank_name => 'Nama Pemilik';

  @override
  String get label_unable_get_address => 'Tidak dapat mendapatkan alamat';

  @override
  String get label_step_1 => 'Langkah 1';

  @override
  String get label_step_2 => 'Langkah 2';

  @override
  String get label_step_3 => 'Langkah 3';

  @override
  String get label_outlet_photo_profile => 'Foto Profil Outlet';

  @override
  String get placeholder_outlet_category => 'Pilih kategori outlet Anda';

  @override
  String get label_outlet_operating_hours => 'Jam Operasional Outlet';

  @override
  String get label_24_hours => '24 Jam';

  @override
  String get toast_success_set_up => 'Berhasil mengatur merchant';

  @override
  String get toast_complete_required_fields => 'Mohon lengkapi semua field yang wajib diisi';

  @override
  String get error_outlet_photo_required => 'Foto outlet wajib diisi';

  @override
  String get error_menu_photo_required => 'Foto menu wajib diisi';

  @override
  String get label_weekly_sales => 'Penjualan Mingguan';

  @override
  String get label_monthly_sales => 'Penjualan Bulanan';

  @override
  String get label_earns => 'Penghasilan';

  @override
  String get label_top_ordered_categories => 'Kategori Terlaris';

  @override
  String get label_top_ordered_products => 'Produk Terlaris';

  @override
  String get button_export_pdf => 'Ekspor ke PDF';

  @override
  String get category_junk_food => 'Junk Food';

  @override
  String get category_drinks => 'Minuman';

  @override
  String get category_snack => 'Camilan';

  @override
  String get product_fried_chicken => 'Ayam Goreng';

  @override
  String get product_coffee_latte => 'Kopi Latte';

  @override
  String get product_laundry_express => 'Laundry Express';

  @override
  String get label_incoming_balance => 'Saldo Masuk';

  @override
  String get label_outgoing_balance => 'Saldo Keluar';

  @override
  String get label_balance_detail => 'Detail Saldo';

  @override
  String get label_gross_sales => 'Penjualan Kotor';

  @override
  String get label_platform_commission => 'Komisi Platform (20%)';

  @override
  String get label_net_income => 'Pendapatan Bersih';

  @override
  String get label_nett_income => 'Pendapatan Nett';

  @override
  String get title_change_password => 'Ubah Kata Sandi';

  @override
  String get placeholder_old_password => 'Masukkan kata sandi lama Anda';

  @override
  String get placeholder_new_password => 'Masukkan kata sandi baru Anda';

  @override
  String get placeholder_confirm_password => '********';

  @override
  String get button_next => 'Lanjut';

  @override
  String get button_back => 'Kembali';

  @override
  String get button_save => 'Simpan';

  @override
  String get label_start => 'Mulai';

  @override
  String get label_end => 'Selesai';

  @override
  String get placeholder_start_time => '10:00';

  @override
  String get placeholder_end_time => '22:00';

  @override
  String get day_monday => 'Senin';

  @override
  String get day_tuesday => 'Selasa';

  @override
  String get day_wednesday => 'Rabu';

  @override
  String get day_thursday => 'Kamis';

  @override
  String get day_friday => 'Jumat';

  @override
  String get day_saturday => 'Sabtu';

  @override
  String get day_sunday => 'Minggu';

  @override
  String get toast_success => 'Berhasil';

  @override
  String get toast_success_set_up_merchant => 'Berhasil mengatur merchant';

  @override
  String get outlet_category_restaurant => 'Restoran';

  @override
  String get outlet_category_cafe => 'Kafe';

  @override
  String get outlet_category_fast_food => 'Makanan Cepat Saji';

  @override
  String get outlet_category_bakery => 'Toko Roti';

  @override
  String get outlet_category_street_food => 'Makanan Jalanan';

  @override
  String get outlet_category_food_truck => 'Food Truck';

  @override
  String get outlet_category_bar => 'Bar';

  @override
  String get outlet_category_coffeeshop => 'Kedai Kopi';

  @override
  String get outlet_category_dessert_shop => 'Toko Dessert';

  @override
  String get outlet_category_juice_bar => 'Kedai Jus';

  @override
  String get menu_category_appetizer => 'Pembuka';

  @override
  String get menu_category_main_course => 'Hidangan Utama';

  @override
  String get menu_category_dessert => 'Penutup';

  @override
  String get menu_category_beverage => 'Minuman';

  @override
  String get menu_category_snack => 'Camilan';

  @override
  String get menu_category_breakfast => 'Sarapan';

  @override
  String get menu_category_lunch => 'Makan Siang';

  @override
  String get menu_category_dinner => 'Makan Malam';

  @override
  String get menu_category_salad => 'Salad';

  @override
  String get menu_category_soup => 'Sup';

  @override
  String get menu_category_seafood => 'Makanan Laut';

  @override
  String get menu_category_vegetarian => 'Vegetarian';

  @override
  String get menu_category_vegan => 'Vegan';

  @override
  String get menu_category_pasta => 'Pasta';

  @override
  String get menu_category_pizza => 'Pizza';

  @override
  String get menu_category_burger => 'Burger';

  @override
  String get menu_category_sandwich => 'Sandwich';

  @override
  String get menu_category_rice => 'Nasi';

  @override
  String get menu_category_noodle => 'Mi';

  @override
  String get menu_category_grill => 'Panggang';

  @override
  String get title_delivery => 'Pengiriman';

  @override
  String get title_where_you_at => 'Di mana Anda?';

  @override
  String get title_where_are_you_going => 'Mau ke mana?';

  @override
  String get text_choose_pickup_destination => 'Pilih titik jemput dan tujuan Anda!';

  @override
  String get toast_failed_estimate_order => 'Gagal menghitung estimasi pesanan';

  @override
  String get marker_pickup => 'Jemput';

  @override
  String get marker_dropoff => 'Tujuan';

  @override
  String get title_order_summary => 'Ringkasan Pesanan';

  @override
  String get text_no_estimate_available => 'Estimasi tidak tersedia';

  @override
  String get label_delivery_details => 'Detail Pengiriman';

  @override
  String get label_from => 'Dari';

  @override
  String get label_to => 'Ke';

  @override
  String get label_item => 'Barang';

  @override
  String get label_weight => 'Berat';

  @override
  String get label_instructions => 'Instruksi';

  @override
  String get button_apply_coupon => 'Gunakan Kupon';

  @override
  String get text_coupon => 'Kupon';

  @override
  String get label_price_breakdown => 'Rincian Harga';

  @override
  String get label_base_fare => 'Tarif Dasar';

  @override
  String get label_distance_fare => 'Tarif Jarak';

  @override
  String get label_subtotal => 'Subtotal';

  @override
  String get label_discount => 'Diskon';

  @override
  String get label_total => 'Total';

  @override
  String get title_payment_method => 'Metode Pembayaran';

  @override
  String get toast_failed_place_order => 'Gagal membuat pesanan';

  @override
  String get toast_delivery_order_placed => 'Pesanan pengiriman berhasil dibuat';

  @override
  String get title_ride => 'Tumpangan';

  @override
  String get title_trip_details => 'Detail Perjalanan';

  @override
  String get toast_wallet_payment_failed => 'Pembayaran wallet gagal';

  @override
  String get title_ride_payment => 'Pembayaran Tumpangan';

  @override
  String get text_unsupported_payment_method => 'Metode pembayaran tidak didukung';

  @override
  String get text_valid_until => 'Berlaku hingga';

  @override
  String get label_confirm_new_password => 'Konfirmasi Password Baru';

  @override
  String get text_rate_this_order => 'Beri rating pesanan ini';

  @override
  String get text_driver => 'Driver';

  @override
  String get button_save_changes => 'Simpan Perubahan';

  @override
  String get text_thank_you_rating => 'Terima kasih atas penilaian Anda!';

  @override
  String get label_achievements => 'Pencapaian';

  @override
  String get text_earned_at => 'Diperoleh pada';

  @override
  String get text_all => 'Semua';

  @override
  String get toast_failed_load_merchants => 'Gagal memuat merchant';

  @override
  String get text_no_merchants_found => 'Merchant tidak ditemukan';

  @override
  String get text_try_different_category => 'Coba pilih kategori lain';

  @override
  String get text_open => 'Buka';

  @override
  String get text_closed => 'Tutup';

  @override
  String get toast_failed_load_mart_data => 'Gagal memuat data mart';

  @override
  String get label_categories => 'Kategori';

  @override
  String get label_recent_orders => 'Pesanan Terbaru';

  @override
  String get button_view_all => 'Lihat Semua';

  @override
  String get label_best_sellers => 'Terlaris';

  @override
  String get text_rating => 'Rating';

  @override
  String get text_no_rating_yet => 'Belum ada rating';

  @override
  String get label_nearby_drivers => 'Driver terdekat';

  @override
  String get text_your_current_location => 'Lokasi Anda saat ini';

  @override
  String item_count(Object count) {
    return '$count item';
  }

  @override
  String get button_accept => 'Terima';

  @override
  String get how_was_your_experience => 'Bagaimana pengalaman Anda?';

  @override
  String get mixed => 'Campuran';

  @override
  String get male => 'Laki-laki';

  @override
  String get female => 'Perempuan';

  @override
  String get toast_app_state_corrupted => 'State aplikasi rusak, silakan restart';

  @override
  String get toast_payment_info_not_available => 'Informasi pembayaran tidak tersedia';

  @override
  String get text_apply_coupon => 'Gunakan Kupon';

  @override
  String text_coupon_applied(String code) {
    return 'Kupon: $code';
  }

  @override
  String get label_payment_method => 'Metode Pembayaran';

  @override
  String get label_payment_summary => 'Ringkasan Pembayaran';

  @override
  String get text_payment_successful => 'Pembayaran berhasil';

  @override
  String get text_payment_failed => 'Pembayaran gagal';

  @override
  String get text_unsupported_payment_method_description => 'Metode pembayaran yang dipilih tidak didukung. Silakan pilih metode lain.';

  @override
  String get toast_va_number_not_available => 'Nomor VA tidak tersedia';

  @override
  String get toast_va_number_copied => 'Nomor VA disalin ke clipboard';

  @override
  String get text_provider_label => 'Penyedia :';

  @override
  String get text_va_number_label => 'Nomor VA :';

  @override
  String text_valid_until_with_date(String date) {
    return 'Berlaku hingga $date';
  }

  @override
  String get text_on_trip => 'Dalam Perjalanan';

  @override
  String get text_license_plate => 'Plat nomor';

  @override
  String get text_finding_driver => 'Mencari driver Anda...';

  @override
  String get text_finding_driver_message => 'Mohon tunggu sementara kami mencarikan driver untuk Anda';

  @override
  String get status_searching => 'Mencari';

  @override
  String get status_driver_found => 'Driver ditemukan';

  @override
  String get status_on_the_way => 'Dalam perjalanan';

  @override
  String get text_pickup_location => 'Lokasi penjemputan';

  @override
  String get text_dropoff_location => 'Lokasi tujuan';

  @override
  String get label_payment_method_lower => 'Metode Pembayaran';

  @override
  String get label_total_price => 'Total Harga';

  @override
  String get text_order_details => 'Detail Pesanan';

  @override
  String get text_finding_driver_title => 'Mencari driver';

  @override
  String get text_your_driver_title => 'Driver Anda';

  @override
  String get text_trip_completed => 'Perjalanan selesai!';

  @override
  String get text_trip_canceled => 'Perjalanan dibatalkan';

  @override
  String get title_delivery_details => 'Detail Pengiriman';

  @override
  String get label_item_description => 'Deskripsi Barang';

  @override
  String get placeholder_item_description => 'Apa yang akan Anda kirim?';

  @override
  String get label_weight_kg => 'Berat (kg)';

  @override
  String get placeholder_weight_kg => 'Masukkan berat dalam kg (maks 20kg)';

  @override
  String get text_maximum_weight => 'Berat maksimum: 20kg';

  @override
  String get text_special_handling_instructions => 'Tambahkan instruksi penanganan atau pengiriman khusus';

  @override
  String get label_item_photos_optional => 'Foto Barang (Opsional)';

  @override
  String get text_add_up_to_3_photos => 'Tambahkan hingga 3 foto barang';

  @override
  String get toast_provide_item_description => 'Harap berikan deskripsi barang';

  @override
  String get toast_weight_must_be_valid => 'Berat harus antara 0,1kg dan 20kg';

  @override
  String get text_thank_you_for_review => 'Terima kasih atas ulasan Anda!';

  @override
  String get toast_failed_submit_review => 'Gagal mengirim ulasan';

  @override
  String get text_rate_by_category => 'Beri nilai berdasarkan kategori';

  @override
  String get category_cleanliness => 'Kebersihan';

  @override
  String get category_courtesy => 'Kesopanan';

  @override
  String get category_punctuality => 'Ketepatan Waktu';

  @override
  String get category_safety => 'Keamanan';

  @override
  String get category_communication => 'Komunikasi';

  @override
  String get category_overall => 'Keseluruhan';

  @override
  String get category_desc_cleanliness => 'Seberapa bersih kendaraan dan penampilan driver?';

  @override
  String get category_desc_courtesy => 'Seberapa sopan dan hormat driver?';

  @override
  String get category_desc_punctuality => 'Apakah driver tepat waktu untuk penjemputan?';

  @override
  String get category_desc_safety => 'Apakah Anda merasa aman selama perjalanan?';

  @override
  String get category_desc_communication => 'Seberapa baik driver berkomunikasi?';

  @override
  String get category_desc_overall => 'Beri nilai pengalaman Anda secara keseluruhan dengan driver ini';

  @override
  String get rating_poor => 'Buruk';

  @override
  String get rating_below_average => 'Di Bawah Rata-rata';

  @override
  String get rating_average => 'Rata-rata';

  @override
  String get rating_good => 'Baik';

  @override
  String get rating_excellent => 'Sangat Baik';

  @override
  String get label_additional_comments => 'Komentar tambahan (opsional)';

  @override
  String get placeholder_additional_comments => 'Ceritakan lebih banyak tentang pengalaman Anda...';

  @override
  String get button_submit_review => 'Kirim Ulasan';

  @override
  String toast_please_rate_category(String category) {
    return 'Harap beri nilai $category';
  }

  @override
  String text_drivers_around_you(int count) {
    return 'Ada $count driver di sekitar Anda';
  }

  @override
  String get text_no_order_history => 'Tidak ada riwayat pesanan';

  @override
  String text_order_id_short(String id) {
    return 'Pesanan #$id';
  }

  @override
  String get label_notes => 'Catatan';

  @override
  String get text_unknown_user => 'Pengguna Tidak Dikenal';

  @override
  String get text_customer => 'Pelanggan';

  @override
  String get button_call_customer => 'Hubungi Pelanggan';

  @override
  String get button_delete => 'Hapus';

  @override
  String get title_edit_schedule => 'Edit Jadwal';

  @override
  String get title_add_schedule => 'Tambah Jadwal';

  @override
  String get placeholder_course_name => 'contoh: Pemrograman Mobile';

  @override
  String get button_cancel => 'Batal';

  @override
  String get placeholder_full_name => 'John Doe';

  @override
  String get placeholder_stock => '0';

  @override
  String text_failed_to_load_profile(String error) {
    return 'Gagal memuat profil: $error';
  }

  @override
  String get text_no_rankings_yet => 'Belum ada peringkat';

  @override
  String get title_where_going => 'Mau ke mana?';

  @override
  String get tab_rankings => 'Peringkat';

  @override
  String get tab_badges => 'Lencana';

  @override
  String text_user_id(String id) {
    return 'Pengguna $id';
  }

  @override
  String text_category_value(String category) {
    return 'Kategori: $category';
  }

  @override
  String text_period_value(String period) {
    return 'Periode: $period';
  }

  @override
  String get text_earned => 'Diperoleh';

  @override
  String text_balance_with_amount(String amount) {
    return 'Saldo: $amount';
  }

  @override
  String get button_top_up => 'Isi Saldo';

  @override
  String get text_select_via_map => 'Pilih via peta';

  @override
  String get text_no_place_found => 'Tidak ada tempat ditemukan';

  @override
  String get title_location_permission_required => 'Izin Lokasi Diperlukan';

  @override
  String get text_location_permission_denied => 'Izin lokasi sebelumnya ditolak. Untuk online dan menerima pesanan, Anda perlu mengaktifkan akses lokasi di pengaturan perangkat.';

  @override
  String get text_location_permission_request => 'Untuk menerima pesanan ride dan delivery, driver harus membagikan lokasi mereka secara real-time. Ini membantu:';

  @override
  String get text_location_benefit_match_orders => 'Mencocokkan Anda dengan pesanan terdekat';

  @override
  String get text_location_benefit_track_arrival => 'Biarkan pelanggan melacak kedatangan Anda';

  @override
  String get text_location_benefit_safety => 'Memastikan keamanan dan akuntabilitas';

  @override
  String get text_location_redirect_settings => 'Anda akan diarahkan ke pengaturan aplikasi untuk mengaktifkan akses lokasi.';

  @override
  String get button_open_settings => 'Buka Pengaturan';

  @override
  String get button_grant_permission => 'Berikan Izin';

  @override
  String get title_rate_customer => 'Beri Rating Pelanggan';

  @override
  String text_experience_with_user(String name) {
    return 'Bagaimana pengalaman Anda dengan $name?';
  }

  @override
  String get category_other => 'Lainnya';

  @override
  String label_rating_score(String score) {
    return 'Rating: $score / 5.0';
  }

  @override
  String get toast_review_submitted => 'Ulasan berhasil dikirim';

  @override
  String get toast_review_failed => 'Gagal mengirim ulasan';

  @override
  String get title_reject_order => 'Tolak Pesanan';

  @override
  String get text_select_rejection_reason => 'Silakan pilih alasan penolakan pesanan ini:';

  @override
  String get rejection_reason_out_of_stock => 'Stok Habis';

  @override
  String get rejection_reason_too_busy => 'Terlalu Sibuk / Volume Pesanan Tinggi';

  @override
  String get rejection_reason_ingredient_unavailable => 'Bahan Tidak Tersedia';

  @override
  String get rejection_reason_closed => 'Toko Tutup / Akan Tutup';

  @override
  String get rejection_reason_other => 'Lainnya';

  @override
  String get label_additional_note_optional => 'Catatan Tambahan (Opsional)';

  @override
  String get placeholder_rejection_note => 'contoh: \"Ayam habis, akan restok besok\"';

  @override
  String get button_reject_order => 'Tolak Pesanan';

  @override
  String get my_reviews => 'Ulasan Saya';

  @override
  String get failed_to_load => 'Gagal memuat';

  @override
  String get no_reviews_yet => 'Belum ada ulasan';

  @override
  String get punctuality => 'Ketepatan Waktu';

  @override
  String get safety => 'Keamanan';

  @override
  String get communication => 'Komunikasi';

  @override
  String get delete_account => 'Hapus Akun';

  @override
  String get delete_account_title => 'Hapus Akun?';

  @override
  String get delete_account_warning => 'Tindakan ini permanen dan tidak dapat dibatalkan.';

  @override
  String get delete_account_you_will_lose => 'Anda akan kehilangan:';

  @override
  String get delete_account_lose_wallet => 'Semua saldo dompet';

  @override
  String get delete_account_lose_history => 'Riwayat pesanan';

  @override
  String get delete_account_lose_ratings => 'Rating dan ulasan';

  @override
  String get delete_account_lose_addresses => 'Alamat tersimpan';

  @override
  String get delete_account_lose_data => 'Semua data akun';

  @override
  String get delete_account_proceed_methods => 'Untuk melanjutkan, silakan gunakan salah satu metode berikut:';

  @override
  String get continue_text => 'Lanjutkan';

  @override
  String get delete_account_choose_method => 'Pilih Metode Penghapusan';

  @override
  String get delete_account_select_method => 'Pilih cara Anda ingin meminta penghapusan akun:';

  @override
  String get delete_account_method_web => 'Formulir Online (Rekomendasi)';

  @override
  String get delete_account_method_web_desc => 'Lengkapi formulir di website kami';

  @override
  String get delete_account_method_email => 'Permintaan Email';

  @override
  String get delete_account_method_email_desc => 'Kirim permintaan melalui email';

  @override
  String get delete_account_method_whatsapp => 'Dukungan WhatsApp';

  @override
  String get delete_account_method_whatsapp_desc => 'Chat dengan tim dukungan';

  @override
  String get delete_account_error_open_web => 'Tidak dapat membuka halaman web. Silakan coba lagi.';

  @override
  String get delete_account_error_open_email => 'Tidak dapat membuka aplikasi email. Silakan coba lagi.';

  @override
  String get delete_account_error_open_whatsapp => 'Tidak dapat membuka WhatsApp. Silakan coba lagi.';

  @override
  String get email_verification_title => 'Verifikasi Email Anda';

  @override
  String get email_verification_description => 'Kami telah mengirim link verifikasi ke alamat email Anda.';

  @override
  String get email_verification_sent => 'Email verifikasi berhasil dikirim!';

  @override
  String get email_verification_instruction => 'Klik link di email untuk memverifikasi akun Anda. Jika tidak melihat emailnya, periksa folder spam.';

  @override
  String get email_verification_resend => 'Kirim Ulang Email Verifikasi';

  @override
  String email_verification_resend_countdown(String seconds) {
    return 'Kirim ulang dalam $seconds detik';
  }

  @override
  String get email_verification_spam_hint => 'Jangan lupa periksa folder spam Anda!';

  @override
  String get email_verification_success_title => 'Email Terverifikasi!';

  @override
  String get email_verification_success_description => 'Email Anda telah berhasil diverifikasi. Anda sekarang dapat masuk ke akun Anda.';

  @override
  String get email_verification_failed => 'Verifikasi email gagal';

  @override
  String get email_verification_invalid_token => 'Link verifikasi tidak valid atau sudah kadaluarsa. Silakan minta yang baru.';

  @override
  String get no_vouchers_available => 'Tidak Ada Voucher';

  @override
  String get check_back_later_for_promotions => 'Cek kembali nanti untuk promo dan diskon';

  @override
  String get toast_report_submitted => 'Laporan berhasil dikirim';

  @override
  String get toast_failed_submit_report => 'Gagal mengirim laporan';

  @override
  String get report_user => 'Laporkan Pengguna';

  @override
  String get report_user_description => 'Laporkan masalah dengan pengguna ini';

  @override
  String get select_report_category => 'Pilih Kategori Masalah';

  @override
  String get report_description => 'Deskripsi';

  @override
  String get report_description_hint => 'Harap jelaskan masalahnya secara detail...';

  @override
  String get report_description_helper => 'Minimal 10 karakter';

  @override
  String get report_guidelines_title => 'Panduan Pelaporan';

  @override
  String get report_guidelines_content => 'Laporan Anda akan dijaga kerahasiaannya. Pengguna yang dilaporkan tidak akan diberitahu tentang identitas Anda. Tim keamanan kami akan meninjau semua laporan dalam 24-48 jam.';

  @override
  String get button_submit_report => 'Kirim Laporan';

  @override
  String get report_category_behavior => 'Perilaku Tidak Pantas';

  @override
  String get report_category_safety => 'Kekhawatiran Keamanan';

  @override
  String get report_category_fraud => 'Penipuan atau Scam';

  @override
  String get report_category_other => 'Masalah Lainnya';

  @override
  String get report_category_behavior_desc => 'Perilaku kasar, menyinggung, atau tidak pantas selama perjalanan';

  @override
  String get report_category_safety_desc => 'Mengemudi berbahaya, pelecehan, atau perilaku mengancam';

  @override
  String get report_category_fraud_desc => 'Manipulasi pembayaran, profil palsu, atau percobaan penipuan';

  @override
  String get report_category_other_desc => 'Masalah lain yang tidak tercakup oleh kategori di atas';

  @override
  String get no_notifications => 'Belum ada notifikasi';

  @override
  String get mark_all_as_read => 'Tandai semua sudah dibaca';

  @override
  String notification_time_ago(String time) {
    return '$time yang lalu';
  }

  @override
  String get scheduled_orders => 'Pesanan Terjadwal';

  @override
  String get scheduled_order => 'Pesanan Terjadwal';

  @override
  String get schedule_a_ride => 'Jadwalkan Perjalanan';

  @override
  String get schedule_a_delivery => 'Jadwalkan Pengiriman';

  @override
  String get schedule_order => 'Jadwalkan Pesanan';

  @override
  String get no_scheduled_orders => 'Tidak ada pesanan terjadwal';

  @override
  String get no_scheduled_orders_desc => 'Anda belum memiliki pesanan terjadwal. Jadwalkan perjalanan atau pengiriman untuk waktu mendatang.';

  @override
  String scheduled_for(String datetime) {
    return 'Dijadwalkan untuk: $datetime';
  }

  @override
  String get schedule_date => 'Tanggal Jadwal';

  @override
  String get schedule_time => 'Waktu Jadwal';

  @override
  String get select_date => 'Pilih Tanggal';

  @override
  String get select_time => 'Pilih Waktu';

  @override
  String get scheduled => 'Terjadwal';

  @override
  String get schedule_order_title => 'Jadwalkan Pesanan Anda';

  @override
  String get schedule_order_desc => 'Pilih kapan Anda ingin pesanan Anda dipenuhi';

  @override
  String get min_schedule_time => 'Minimal 30 menit dari sekarang';

  @override
  String get max_schedule_time => 'Maksimal 7 hari ke depan';

  @override
  String schedule_confirmation(String datetime) {
    return 'Pesanan Anda akan dijadwalkan untuk $datetime. Driver akan dicocokkan sekitar 15 menit sebelum waktu yang dijadwalkan.';
  }

  @override
  String get confirm_schedule => 'Konfirmasi Jadwal';

  @override
  String get edit_schedule => 'Ubah Jadwal';

  @override
  String get cancel_scheduled_order => 'Batalkan Pesanan Terjadwal';

  @override
  String get cancel_scheduled_order_confirm => 'Apakah Anda yakin ingin membatalkan pesanan terjadwal ini?';

  @override
  String get scheduled_order_cancelled => 'Pesanan terjadwal berhasil dibatalkan';

  @override
  String get scheduled_order_updated => 'Pesanan terjadwal berhasil diperbarui';

  @override
  String get scheduled_order_placed => 'Pesanan berhasil dijadwalkan';

  @override
  String get failed_to_schedule_order => 'Gagal menjadwalkan pesanan';

  @override
  String get failed_to_cancel_scheduled_order => 'Gagal membatalkan pesanan terjadwal';

  @override
  String get failed_to_update_scheduled_order => 'Gagal memperbarui pesanan terjadwal';

  @override
  String get failed_to_load_scheduled_orders => 'Gagal memuat pesanan terjadwal';

  @override
  String get schedule_time_too_soon => 'Waktu jadwal harus minimal 30 menit dari sekarang';

  @override
  String get schedule_time_too_far => 'Waktu jadwal tidak boleh lebih dari 7 hari ke depan';

  @override
  String matching_starts_at(String time) {
    return 'Pencarian driver dimulai pada $time';
  }

  @override
  String get view_scheduled_orders => 'Lihat Pesanan Terjadwal';

  @override
  String get upcoming_scheduled_orders => 'Pesanan Terjadwal Mendatang';

  @override
  String get past_scheduled_orders => 'Pesanan Terjadwal Sebelumnya';

  @override
  String get scheduled_order_details => 'Detail Pesanan Terjadwal';

  @override
  String order_will_be_matched(String time) {
    return 'Pesanan akan dicocokkan $time';
  }

  @override
  String get schedule_now => 'Jadwalkan Sekarang';

  @override
  String get order_now => 'Pesan Sekarang';

  @override
  String get or_schedule_for_later => 'Atau jadwalkan untuk nanti';

  @override
  String get please_select_schedule_time => 'Silakan pilih waktu jadwal';

  @override
  String get scheduled_order_created => 'Pesanan Anda telah berhasil dijadwalkan';

  @override
  String get schedule_for_later => 'Jadwalkan untuk Nanti';

  @override
  String get tap_to_change_schedule => 'Ketuk untuk mengubah';

  @override
  String get error_occurred => 'Terjadi kesalahan';

  @override
  String get scan_to_send_money => 'Scan QR code ini untuk mengirim uang ke saya';

  @override
  String get share_qr_instruction => 'Bagikan QR code ini kepada orang lain agar mereka dapat dengan mudah mentransfer uang kepada Anda';
}
