/**
 * Terms of Service Content
 *
 * This file contains all content for the Terms of Service page.
 * Indonesian translations can be added to the `id` property of each content object.
 *
 * NOTE: This file contains a subset of sections as a demonstration.
 * Additional sections can be added following the same pattern.
 */

import type { LegalSectionContent } from "../legal-i18n";
import { getLegalContent } from "../legal-i18n";

export const acceptanceOfTerms = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Acceptance of Terms",
			paragraphs: [
				'Welcome to AkadeMove. These Terms of Service ("Terms") govern your access to and use of our campus mobility and delivery platform, including our mobile application and website (collectively, the "Services").',
				"By creating an account, accessing, or using our Services, you agree to be bound by these Terms and our Privacy Policy. If you do not agree to these Terms, you may not use our Services.",
				"These Terms constitute a legally binding agreement between you and AkadeMove. Please read them carefully.",
			],
		},
		id: {
			title: "Penerimaan Syarat",
			paragraphs: [
				'Selamat datang di AkadeMove. Syarat Layanan ini ("Syarat") mengatur akses dan penggunaan platform mobilitas dan pengiriman kampus kami, termasuk aplikasi seluler dan situs web kami (secara kolektif, "Layanan").',
				"Dengan membuat akun, mengakses, atau menggunakan Layanan kami, Anda setuju untuk terikat oleh Syarat ini dan Kebijakan Privasi kami. Jika Anda tidak setuju dengan Syarat ini, Anda tidak boleh menggunakan Layanan kami.",
				"Syarat ini merupakan perjanjian yang mengikat secara hukum antara Anda dan AkadeMove. Harap baca dengan seksama.",
			],
		},
	});

export const serviceDescription = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Service Description",
			paragraphs: [
				"AkadeMove is a campus-specific platform that connects students, faculty, and authorized campus community members for:",
			],
			lists: [
				{
					items: [
						{
							label: "Ride-Hailing Services",
							content:
								"Transportation services within and around campus areas, connecting passengers with student drivers",
						},
						{
							label: "Package Delivery",
							content:
								"Delivery of documents, parcels, laundry, and other goods within campus boundaries",
						},
						{
							label: "Food Delivery",
							content:
								"Ordering and delivery of food and beverages from campus merchants and tenants (canteens, cafes, restaurants)",
						},
					],
				},
			],
			additionalParagraphs: [
				"AkadeMove acts as a technology platform connecting users with service providers (drivers and merchants). We are not a transportation company or food delivery company. Drivers and merchants are independent contractors, not employees of AkadeMove.",
			],
		},
		id: {
			title: "Deskripsi Layanan",
			paragraphs: [
				"AkadeMove adalah platform khusus kampus yang menghubungkan mahasiswa, dosen, dan anggota komunitas kampus yang berwenang untuk:",
			],
			lists: [
				{
					items: [
						{
							label: "Layanan Ride-Hailing",
							content:
								"Layanan transportasi di dalam dan sekitar area kampus, menghubungkan penumpang dengan pengemudi mahasiswa",
						},
						{
							label: "Pengiriman Paket",
							content:
								"Pengiriman dokumen, paket, laundry, dan barang lainnya dalam batas kampus",
						},
						{
							label: "Pengiriman Makanan",
							content:
								"Pesanan dan pengiriman makanan dan minuman dari pedagang dan penyewa kampus (kantin, kafe, restoran)",
						},
					],
				},
			],
			additionalParagraphs: [
				"AkadeMove bertindak sebagai platform teknologi yang menghubungkan pengguna dengan penyedia layanan (pengemudi dan pedagang). Kami bukan perusahaan transportasi atau perusahaan pengiriman makanan. Pengemudi dan pedagang adalah kontraktor independen, bukan karyawan AkadeMove.",
			],
		},
	});

export const userEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "User Roles and Eligibility",
			paragraphs: [],
		},
		id: {
			title: "Peran Pengguna dan Kelayakan",
			paragraphs: [],
		},
	});

export const passengersEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Passengers/Users",
			paragraphs: ["To use our services as a passenger, you must:"],
			lists: [
				{
					items: [
						{
							label: "Age",
							content: "Be at least 17 years of age",
						},
						{
							label: "Campus Affiliation",
							content:
								"Be a current student, faculty member, or authorized campus community member",
						},
						{
							label: "Contact Information",
							content: "Provide a valid email address and phone number",
						},
						{
							label: "Verification",
							content:
								"Verify your campus affiliation (Student ID/KTM when required)",
						},
						{
							label: "Account Maintenance",
							content: "Maintain accurate and up-to-date account information",
						},
					],
				},
			],
		},
		id: {
			title: "Peran Pengguna dan Kelayakan",
			paragraphs: [],
			lists: [
				{
					items: [
						{
							label: "Usia",
							content: "Berusia minimal 17 tahun",
						},
						{
							label: "Afiliasi Kampus",
							content:
								"Menjadi mahasiswa, dosen, atau anggota komunitas kampus yang berwenang",
						},
						{
							label: "Informasi Kontak",
							content: "Menyediakan alamat email dan nomor telepon yang valid",
						},
						{
							label: "Verifikasi",
							content:
								"Memverifikasi afiliasi kampus Anda (KTM saat diperlukan)",
						},
						{
							label: "Pemeliharaan Akun",
							content: "Memelihara informasi akun yang akurat dan terbaru",
						},
					],
				},
			],
		},
	});

export const driversEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Drivers",
			paragraphs: ["To provide services as a driver, you must:"],
			lists: [
				{
					items: [
						{
							label: "Age",
							content: "Be at least 18 years of age",
						},
						{
							label: "Student Status",
							content: "Be a currently enrolled student",
						},
						{
							label: "Driver's License",
							content:
								"Possess a valid Indonesian driver's license (SIM C for motorcycles or SIM A for cars)",
						},
						{
							label: "Vehicle Access",
							content: "Own or have legal access to a registered vehicle",
						},
						{
							label: "Vehicle Registration",
							content: "Provide valid vehicle registration documents (STNK)",
						},
						{
							label: "Student ID",
							content: "Submit a clear photo of your Student ID (KTM)",
						},
						{
							label: "Verification Process",
							content: "Pass our driver verification and onboarding process",
						},
						{
							label: "Safety Training",
							content:
								"Complete any required safety training or knowledge assessment",
						},
						{
							label: "Insurance",
							content:
								"Maintain vehicle insurance as required by Indonesian law",
						},
					],
				},
			],
		},
		id: {
			title: "Pengemudi",
			paragraphs: ["Untuk menyediakan layanan sebagai pengemudi, Anda harus:"],
			lists: [
				{
					items: [
						{
							label: "Usia",
							content: "Berusia minimal 18 tahun",
						},
						{
							label: "Status Mahasiswa",
							content: "Menjadi mahasiswa yang sedang terdaftar",
						},
						{
							label: "Surat Izin Mengemudi",
							content:
								"Memiliki surat izin mengemudi Indonesia yang valid (SIM C untuk sepeda motor atau SIM A untuk mobil)",
						},
						{
							label: "Akses Kendaraan",
							content:
								"Memiliki atau memiliki akses legal ke kendaraan yang terdaftar",
						},
						{
							label: "Registrasi Kendaraan",
							content:
								"Menyediakan dokumen registrasi kendaraan yang valid (STNK)",
						},
						{
							label: "Kartu Tanda Mahasiswa",
							content: "Mengirimkan foto jelas Kartu Tanda Mahasiswa (KTM)",
						},
						{
							label: "Proses Verifikasi",
							content: "Lulus proses verifikasi dan onboarding pengemudi kami",
						},
						{
							label: "Pelatihan Keamanan",
							content:
								"Menyelesaikan pelatihan keamanan atau penilaian pengetahuan yang diperlukan",
						},
						{
							label: "Asuransi",
							content:
								"Memiliki asuransi kendaraan sesuai dengan peraturan Indonesia",
						},
					],
				},
			],
		},
	});

export const merchantsEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Merchants/Tenants",
			paragraphs: ["To operate as a merchant on our platform, you must:"],
			lists: [
				{
					items: [
						{
							label: "Authorization",
							content: "Be an authorized campus food vendor or tenant",
						},
						{
							label: "Documentation",
							content: "Provide valid business documentation and permits",
						},
						{
							label: "Food Safety",
							content: "Maintain food safety and hygiene standards",
						},
						{
							label: "Campus Compliance",
							content:
								"Comply with campus regulations for food service operations",
						},
						{
							label: "Menu Information",
							content:
								"Provide accurate menu information, pricing, and availability",
						},
					],
				},
			],
		},
		id: {
			title: "Pengelola",
			paragraphs: [
				"Pengelola adalah administrator kampus yang berwenang mengelola konfigurasi platform, harga, promosi, dan pemantauan. Akses pengelola diberikan hanya oleh administrator AkadeMove.",
			],
			lists: [
				{
					items: [
						{
							label: "Otorisasi",
							content: "Menjadi pengelola kampus yang berwenang",
						},
						{
							label: "Dokumentasi",
							content: "Menyediakan dokumentasi bisnis dan izin yang valid",
						},
						{
							label: "Keamanan Makanan",
							content: "Mempertahankan standar keamanan dan kebersihan makanan",
						},
						{
							label: "Kepatuhan Kampus",
							content:
								"Mematuhi peraturan kampus untuk operasi layanan makanan",
						},
						{
							label: "Informasi Menu",
							content:
								"Menyediakan informasi menu, harga, dan ketersediaan yang akurat",
						},
					],
				},
			],
		},
	});

export const operatorsEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Operators",
			paragraphs: [
				"Operators are authorized campus administrators who manage platform configuration, pricing, promotions, and monitoring. Operator access is granted by AkadeMove administrators only.",
			],
		},
		id: {
			title: "Pengelola",
			paragraphs: [
				"Pengelola adalah administrator kampus yang berwenang mengelola konfigurasi platform, harga, promosi, dan pemantauan. Akses pengelola diberikan hanya oleh administrator AkadeMove.",
			],
		},
	});

export const accountRegistration = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Account Registration and Verification",
			paragraphs: [
				"To use AkadeMove, you must create an account by providing:",
			],
			lists: [
				{
					items: [
						{ label: "Name", content: "Full legal name" },
						{ label: "Email", content: "Valid email address" },
						{
							label: "Phone",
							content: "Phone number (verified via OTP)",
						},
						{
							label: "Password",
							content: "Password (securely hashed and stored)",
						},
						{
							label: "Personal Details",
							content: "Date of birth and gender",
						},
						{
							label: "Photo (optional for passengers, required for drivers)",
							content:
								"Profile photo (optional for passengers, required for drivers)",
						},
					],
				},
			],
			additionalParagraphs: [
				"You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.",
				"**Driver and Merchant Verification:** Driver and merchant accounts require additional verification. Your account will have limited functionality until verification is complete. Verification typically takes 1-3 business days. We reserve the right to reject verification applications that do not meet our standards.",
				"**Account Accuracy:** You agree to provide accurate, current, and complete information and to update it as necessary to maintain its accuracy.",
			],
		},
		id: {
			title: "Pendaftaran dan Verifikasi Akun",
			paragraphs: [
				"Untuk menggunakan AkadeMove, Anda harus membuat akun dengan menyediakan:",
			],
			lists: [
				{
					items: [
						{ label: "Nama", content: "Nama lengkap sesuai identitas" },
						{ label: "Email", content: "Alamat email yang valid" },
						{
							label: "Telepon",
							content: "Nomor telepon (diverifikasi melalui OTP)",
						},
						{
							label: "Kata Sandi",
							content: "Kata sandi (disimpan dengan aman dan terenkripsi)",
						},
						{
							label: "Detail Pribadi",
							content: "Tanggal lahir dan jenis kelamin",
						},
						{
							label: "Foto (opsional untuk penumpang, wajib untuk pengemudi)",
							content:
								"Foto profil (opsional untuk penumpang, wajib untuk pengemudi)",
						},
					],
				},
			],
		},
	});

export const cancellationPolicy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Cancellation and Refund Policy",
			paragraphs: [
				"**User Cancellations:**",
				"- Free cancellation within 2 minutes of booking",
				"- Cancellation fee (configurable by operator) applies after 2 minutes",
				"- If driver has arrived or order is being prepared, full cancellation fee applies",
				"",
				"**Driver Cancellations:**",
				"- Drivers can cancel without penalty if passenger is unresponsive or violates terms",
				"- Excessive cancellations may result in account suspension",
				"",
				"**Refunds:**",
				"- Refunds for service issues are processed within 5-7 business days",
				"- Refunds are issued to the original payment method or wallet",
				"- Disputes must be raised within 24 hours of order completion",
			],
		},
		id: {
			title: "Kebijakan Pembatalan dan Pengembalian Dana",
			paragraphs: [
				"**Pembatalan Pengguna:**",
				"- Pembatalan gratis dalam waktu 2 menit setelah pemesanan",
				"- Biaya pembatalan (dapat dikonfigurasi oleh pengelola) berlaku setelah 2 menit",
				"- Jika pengemudi telah tiba atau pesanan sedang dipersiapkan, biaya pembatalan penuh berlaku",
				"",
			],
		},
	});

export const ratingSystem = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Rating and Review System",
			paragraphs: [
				"Both users and drivers can rate each other on a 5-star scale. Ratings contribute to overall user/driver scores and affect service quality and opportunities.",
			],
			lists: [
				{
					items: [
						{
							label: "Fairness",
							content:
								"Ratings should reflect actual service quality and behavior",
						},
						{
							label: "Prohibition",
							content:
								"Do not manipulate ratings or leave false/malicious reviews",
						},
						{
							label: "Disputes",
							content:
								"Rating disputes can be reported to customer support for review",
						},
						{
							label: "Consequences",
							content:
								"Consistently low ratings may result in account review or suspension",
						},
					],
				},
			],
		},
		id: {
			title: "Sistem Peringkat dan Ulasan",
			paragraphs: [
				"Baik pengguna maupun pengemudi dapat memberikan peringkat satu sama lain pada skala 5 bintang. Peringkat berkontribusi pada skor keseluruhan pengguna/pengemudi dan mempengaruhi kualitas layanan dan peluang.",
			],
			lists: [
				{
					items: [
						{
							label: "Keadilan",
							content:
								"Peringkat harus mencerminkan kualitas layanan dan perilaku yang sebenarnya",
						},
						{
							label: "Larangan",
							content:
								"Jangan memanipulasi peringkat atau meninggalkan ulasan palsu/berniat jahat",
						},
						{
							label: "Sengketa",
							content:
								"Sengketa peringkat dapat dilaporkan ke dukungan pelanggan untuk ditinjau",
						},
						{
							label: "Konsekuensi",
							content:
								"Peringkat yang konsisten rendah dapat mengakibatkan peninjauan atau penangguhan akun",
						},
					],
				},
			],
		},
	});

export const prohibitedConduct = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Prohibited Conduct",
			paragraphs: ["Users of AkadeMove must not:"],
			lists: [
				{
					items: [
						{
							label: "Illegal Activity",
							content:
								"Use services for illegal purposes or transport illegal goods",
						},
						{
							label: "Harassment",
							content:
								"Harass, abuse, threaten, or discriminate against other users",
						},
						{
							label: "Fraud",
							content:
								"Engage in fraudulent activities, fake accounts, or payment fraud",
						},
						{
							label: "System Abuse",
							content:
								"Manipulate the platform, ratings, pricing, or promotions",
						},
						{
							label: "Safety Violations",
							content: "Operate vehicles unsafely or violate traffic laws",
						},
						{
							label: "Unauthorized Access",
							content:
								"Attempt to access accounts or data you are not authorized to access",
						},
						{
							label: "Intellectual Property",
							content:
								"Infringe on AkadeMove's or others' intellectual property",
						},
					],
				},
			],
			additionalParagraphs: [
				"Violation of these terms may result in immediate account suspension or termination, and potential legal action.",
			],
		},
		id: {
			title: "Perilaku Terlarang",
			paragraphs: ["Pengguna AkadeMove tidak boleh:"],
			lists: [
				{
					items: [
						{
							label: "Kegiatan Ilegal",
							content:
								"Gunakan layanan untuk tujuan ilegal atau mengangkut barang ilegal",
						},
						{
							label: "Pelecehan",
							content:
								"Melakukan pelecehan, penyalahgunaan, ancaman, atau diskriminasi terhadap pengguna lain",
						},
						{
							label: "Penipuan",
							content:
								"Terlibat dalam aktivitas penipuan, akun palsu, atau penipuan pembayaran",
						},
						{
							label: "Penyalahgunaan Sistem",
							content: "Memanipulasi platform, peringkat, harga, atau promosi",
						},
						{
							label: "Pelanggaran Keselamatan",
							content:
								"Mengoperasikan kendaraan dengan tidak aman atau melanggar undang-undang lalu lintas",
						},
						{
							label: "Akses Tidak Sah",
							content:
								"Mencoba mengakses akun atau data yang tidak Anda berwenang untuk mengakses",
						},
						{
							label: "Hak Kekayaan Intelektual",
							content:
								"Melanggar hak kekayaan intelektual AkadeMove atau pihak lain",
						},
					],
				},
			],
		},
	});

export const limitationLiability = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Limitation of Liability",
			paragraphs: [
				"**Platform Role:** AkadeMove is a technology platform connecting users with independent service providers. We do not provide transportation or delivery services directly.",
				'**No Warranty:** Services are provided "as is" without warranties of any kind, express or implied.',
				"**Limitation:** To the maximum extent permitted by Indonesian law, AkadeMove shall not be liable for indirect, incidental, special, or consequential damages.",
				"**Maximum Liability:** Our total liability shall not exceed the amount you paid to AkadeMove in the 12 months preceding the claim.",
				"**Third Parties:** We are not responsible for the actions of drivers, merchants, or other users.",
			],
		},
		id: {
			title: "Batasan Tanggung Jawab",
			paragraphs: [
				"**Peran Platform:** AkadeMove adalah platform teknologi yang menghubungkan pengguna dengan penyedia layanan independen. Kami tidak menyediakan layanan transportasi atau pengiriman secara langsung.",
				'**Tanpa Jaminan:** Layanan disediakan "sebagaimana adanya" tanpa jaminan apa pun, baik tersurat maupun tersirat.',
				"**Batasan:** Sejauh diizinkan oleh hukum Indonesia, AkadeMove tidak bertanggung jawab atas kerusakan tidak langsung, insidental, khusus, atau konsekuensial.",
				"**Batas Maksimum:** Total tanggung jawab kami tidak akan melebihi jumlah yang Anda bayarkan kepada AkadeMove dalam 12 bulan sebelum klaim.",
				"**Pihak Ketiga:** Kami tidak bertanggung jawab atas tindakan pengemudi, pedagang, atau pengguna lain.",
			],
		},
	});

export const disputeResolution = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Dispute Resolution",
			paragraphs: [
				"**Informal Resolution:** We encourage users to contact customer support first to resolve disputes informally.",
				"**Mediation:** If informal resolution fails, parties agree to attempt mediation before litigation.",
				"**Governing Law:** These Terms are governed by the laws of the Republic of Indonesia.",
				"**Jurisdiction:** Any disputes shall be resolved in the courts of Surabaya, Indonesia.",
				"**Arbitration:** Parties may agree to binding arbitration as an alternative to litigation.",
			],
		},
		id: {
			title: "Penyelesaian Sengketa",
			paragraphs: [
				"**Penyelesaian Informal:** Kami mendorong pengguna untuk menghubungi dukungan pelanggan terlebih dahulu untuk menyelesaikan sengketa secara informal.",
				"**Mediasi:** Jika penyelesaian informal gagal, para pihak setuju untuk mencoba mediasi sebelum litigasi.",
				"**Hukum yang Mengatur:** Ketentuan ini diatur oleh hukum Republik Indonesia.",
				"**Yurisdiksi:** Setiap sengketa akan diselesaikan di pengadilan Surabaya, Indonesia.",
				"**Arbitrase:** Para pihak dapat setuju untuk arbitrase yang mengikat sebagai alternatif litigasi.",
			],
		},
	});

export const changesToTerms = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Changes to Terms",
			paragraphs: [
				"We reserve the right to modify these Terms at any time. Material changes will be notified via:",
				"- In-app notification",
				"- Email to your registered address",
				"- Prominent notice on our website",
				"",
				"Continued use of services after changes become effective constitutes acceptance of the updated Terms. If you do not agree to changes, you must stop using our Services.",
			],
		},
		id: {
			title: "Perubahan Ketentuan",
			paragraphs: [
				"Kami berhak untuk mengubah Ketentuan ini kapan saja. Perubahan material akan diberitahukan melalui:",
				"- Notifikasi dalam aplikasi",
				"- Email ke alamat terdaftar Anda",
				"- Pemberitahuan mencolok di situs web kami",
				"",
				"Penggunaan layanan setelah perubahan berlaku merupakan penerimaan terhadap Ketentuan yang diperbarui. Jika Anda tidak setuju dengan perubahan, Anda harus berhenti menggunakan Layanan kami.",
			],
		},
	});

export const accountTermination = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Account Termination",
			paragraphs: [
				"**User Termination:** You may terminate your account at any time through app settings or by contacting customer support.",
				"**Platform Termination:** We reserve the right to suspend or terminate accounts that violate these Terms, engage in fraudulent activity, or pose safety risks.",
				"**Effect of Termination:** Upon termination, your access to Services will cease, and we may delete your account data subject to legal retention requirements.",
				"**Outstanding Obligations:** Termination does not relieve you of payment obligations or liabilities incurred before termination.",
			],
		},
		id: {
			title: "Pengakhiran Akun",
			paragraphs: [
				"**Pengakhiran Pengguna:** Anda dapat mengakhiri akun Anda kapan saja melalui pengaturan aplikasi atau dengan menghubungi dukungan pelanggan.",
				"**Pengakhiran Platform:** Kami berhak untuk menangguhkan atau mengakhiri akun yang melanggar Ketentuan ini, terlibat dalam aktivitas penipuan, atau menimbulkan risiko keselamatan.",
				"**Efek Pengakhiran:** Setelah pengakhiran, akses Anda ke Layanan akan dihentikan, dan kami dapat menghapus data akun Anda sesuai dengan persyaratan retensi hukum.",
				"**Kewajiban Tertunda:** Pengakhiran tidak membebaskan Anda dari kewajiban pembayaran atau tanggung jawab yang timbul sebelum pengakhiran.",
			],
		},
	});

export const contactInformation = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Contact Information",
			paragraphs: ["For questions about these Terms or to report issues:"],
			lists: [
				{
					items: [
						{ label: "Email", content: "support@akademove.com" },
						{ label: "Phone", content: "+62 21 1234 5678" },
						{
							label: "Address",
							content:
								"AkadeMove, Universitas Negeri Surabaya, Surabaya, Jawa Timur",
						},
						{
							label: "Customer Support",
							content: "Available 24/7 through in-app chat",
						},
					],
				},
			],
		},
		id: {
			title: "Informasi Kontak",
			paragraphs: [
				"Untuk pertanyaan tentang Ketentuan ini atau melaporkan masalah:",
			],
			lists: [
				{
					items: [
						{ label: "Email", content: "support@akademove.com" },
						{ label: "Telepon", content: "+62 21 1234 5678" },
						{
							label: "Alamat",
							content:
								"AkadeMove, Universitas Negeri Surabaya, Surabaya, Jawa Timur",
						},
						{
							label: "Dukungan Pelanggan",
							content: "Tersedia 24/7 melalui obrolan dalam aplikasi",
						},
					],
				},
			],
		},
	});

// Driver Requirements Section
export const driverRequirements = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Driver Requirements",
			paragraphs: [],
		},
		id: {
			title: "Persyaratan Pengemudi",
			paragraphs: [],
		},
	});

export const driverDocuments = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Required Documents",
			paragraphs: ["All drivers must submit and maintain current:"],
			lists: [
				{
					items: [
						{
							label: "Student ID Card (KTM)",
							content: "Valid proof of current enrollment",
						},
						{
							label: "Driver's License (SIM)",
							content:
								"Valid SIM C (motorcycle) or SIM A (car) from Indonesian authorities",
						},
						{
							label: "Vehicle Registration (STNK)",
							content:
								"Current vehicle registration matching the vehicle used for services",
						},
						{
							label: "Vehicle Photos",
							content: "Clear photos of your vehicle from multiple angles",
						},
						{
							label: "Selfie Photo",
							content: "Recent photo for identity verification",
						},
					],
				},
			],
			additionalParagraphs: [
				"Documents must be clearly readable and not expired. You must update documents before expiration to maintain active driver status.",
			],
		},
		id: {
			title: "Dokumen yang Diperlukan",
			paragraphs: [
				"Semua pengemudi harus mengirimkan dan memelihara dokumen yang berlaku:",
			],
			lists: [
				{
					items: [
						{
							label: "Kartu Tanda Mahasiswa (KTM)",
							content: "Bukti valid pendaftaran saat ini",
						},
						{
							label: "Surat Izin Mengemudi (SIM)",
							content:
								"SIM C (sepeda motor) atau SIM A (mobil) yang valid dari otoritas Indonesia",
						},
						{
							label: "Registrasi Kendaraan (STNK)",
							content:
								"Registrasi kendaraan saat ini yang sesuai dengan kendaraan yang digunakan untuk layanan",
						},
						{
							label: "Foto Kendaraan",
							content: "Foto jelas kendaraan Anda dari berbagai sudut",
						},
						{
							label: "Foto Diri",
							content: "Foto terbaru untuk verifikasi identitas",
						},
					],
				},
			],
			additionalParagraphs: [
				"Dokumen harus terbaca dengan jelas dan tidak kedaluwarsa. Anda harus memperbarui dokumen sebelum kedaluwarsa untuk mempertahankan status pengemudi aktif.",
			],
		},
	});

export const driverSchedule = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Class Schedule Management",
			paragraphs: [
				"One of AkadeMove's unique features is class schedule integration:",
			],
			lists: [
				{
					items: [
						{
							content:
								"Drivers can input their class schedules (manual entry or calendar import when available)",
						},
						{
							content:
								'The system automatically sets drivers to "offline" status during scheduled class times',
						},
						{
							content: "Schedules can be one-time or recurring weekly",
						},
						{
							content:
								"Drivers can override automatic offline status if their schedule changes",
						},
					],
				},
			],
			additionalParagraphs: [
				"This feature helps drivers balance their academic responsibilities with earning opportunities. However, you remain responsible for managing your own schedule and ensuring you do not accept orders during times you are unavailable.",
			],
		},
		id: {
			title: "Manajemen Jadwal Kelas",
			paragraphs: [
				"Salah satu fitur unik AkadeMove adalah integrasi jadwal kelas:",
			],
			lists: [
				{
					items: [
						{
							content:
								"Pengemudi dapat memasukkan jadwal kelas mereka (entri manual atau impor kalender saat tersedia)",
						},
						{
							content:
								'The system automatically sets drivers to "offline" status during scheduled class times',
						},
						{
							content: "Schedules can be one-time or recurring weekly",
						},
						{
							content:
								"Drivers can override automatic offline status if their schedule changes",
						},
					],
				},
			],
			additionalParagraphs: [
				"Fitur ini membantu pengemudi menyeimbangkan tanggung jawab akademik dengan peluang penghasilan. Namun, Anda tetap bertanggung jawab mengelola jadwal Anda sendiri dan memastikan Anda tidak menerima pesanan selama waktu Anda tidak tersedia.",
			],
		},
	});

export const driverAvailability = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Availability and Online Status",
			paragraphs: ["As a driver, you control your availability:"],
			lists: [
				{
					items: [
						{
							content:
								'Toggle between "online" (available for orders) and "offline" (not available)',
						},
						{
							content:
								"When online, you will receive order requests based on your location and rider preferences",
						},
						{
							content: "You have the right to accept or reject order requests",
						},
						{
							content:
								"However, excessive rejection rates may affect your priority in the matching algorithm",
						},
						{
							content:
								"Repeated cancellations after accepting orders may result in warnings or suspension",
						},
					],
				},
			],
		},
		id: {
			title: "Ketersediaan dan Status Online",
			paragraphs: ["Sebagai pengemudi, Anda mengontrol ketersediaan Anda:"],
			lists: [
				{
					items: [
						{
							content:
								'Beralih antara "online" (tersedia untuk pesanan) dan "offline" (tidak tersedia)',
						},
						{
							content:
								"Saat online, Anda akan menerima permintaan pesanan berdasarkan lokasi dan preferensi penumpang",
						},
						{
							content:
								"Anda memiliki hak untuk menerima atau menolak permintaan pesanan",
						},
						{
							content:
								"Namun, tingkat penolakan yang berlebihan dapat mempengaruhi prioritas Anda dalam algoritma pencocokan",
						},
						{
							content:
								"Pembatalan berulang setelah menerima pesanan dapat mengakibatkan peringatan atau penangguhan",
						},
					],
				},
			],
		},
	});

// Pricing and Payments Sections
export const pricingPayments = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Pricing and Payments",
			paragraphs: [],
		},
		id: {
			title: "Harga dan Pembayaran",
			paragraphs: [],
		},
	});

export const pricingStructure = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Pricing Structure",
			paragraphs: [
				"Pricing for rides and delivery services is calculated using the following formula:",
				"**Total Price = Base Price + (Distance in KM × Price per KM) + Tip - Coupon Discount**",
			],
			lists: [
				{
					items: [
						{
							label: "Base Price",
							content: "Minimum charge for any order, set by campus operators",
						},
						{
							label: "Price per KM",
							content: "Rate per kilometer traveled, configurable by operators",
						},
						{
							label: "Distance Calculation",
							content:
								"Calculated using Google Maps API for the shortest route",
						},
						{
							label: "Tips",
							content: "Optional gratuity added by passengers",
						},
						{
							label: "Coupons",
							content: "Promotional discounts applied at checkout",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Food Orders:** Food prices are set by merchants. A delivery fee based on distance applies separately.",
				"You will see the estimated fare before confirming your order. The final fare is calculated based on the actual route taken.",
			],
		},
		id: {
			title: "Struktur Harga",
			paragraphs: [
				"Harga untuk layanan angkutan dan pengiriman dihitung menggunakan rumus berikut:",
				"**Total Harga = Harga Dasar + (Jarak dalam KM × Harga per KM) + Tip - Diskon Kupon**",
			],
			lists: [
				{
					items: [
						{
							label: "Harga Dasar",
							content:
								"Biaya minimum untuk setiap pesanan, ditetapkan oleh pengelola kampus",
						},
						{
							label: "Harga per KM",
							content:
								"Tarif per kilometer yang ditempuh, dapat dikonfigurasi oleh pengelola",
						},
						{
							label: "Perhitungan Jarak",
							content:
								"Dihitung menggunakan Google Maps API untuk rute terpendek",
						},
						{
							label: "Tip",
							content: "Gratifikasi opsional yang ditambahkan oleh penumpang",
						},
						{
							label: "Kupon",
							content: "Diskon promosi yang diterapkan saat checkout",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Pesanan Makanan:** Harga makanan ditetapkan oleh pedagang. Biaya pengiriman berdasarkan jarak berlaku secara terpisah.",
				"Anda akan melihat perkiraan tarif sebelum mengonfirmasi pesanan Anda. Tarif akhir dihitung berdasarkan rute aktual yang diambil.",
			],
		},
	});

export const commissionStructure = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Commission Structure",
			paragraphs: ["AkadeMove operates on a commission-based model:"],
			lists: [
				{
					items: [
						{
							label: "Rides and Package Delivery",
							content: "15% platform commission deducted from the total fare",
						},
						{
							label: "Food Delivery",
							content:
								"20% total commission (10% from merchant, 10% from driver earnings)",
						},
						{
							label: "Tips",
							content:
								"Tips go directly to drivers without commission deduction (configurable by operators)",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Example Calculation:**\nRide Total: Rp 25,000\nPlatform Commission (15%): Rp 3,750\nDriver Earnings: Rp 21,250",
				"Commission rates are subject to change with advance notice. Drivers and merchants will be notified of any rate changes at least 14 days in advance.",
			],
		},
		id: {
			title: "Struktur Komisi",
			paragraphs: ["AkadeMove beroperasi pada model berbasis komisi:"],
			lists: [
				{
					items: [
						{
							label: "Angkutan dan Pengiriman Paket",
							content: "Komisi platform 15% dikurangi dari total tarif",
						},
						{
							label: "Pengiriman Makanan",
							content:
								"Komisi total 20% (10% dari pedagang, 10% dari penghasilan pengemudi)",
						},
						{
							label: "Tip",
							content:
								"Tip langsung diberikan kepada pengemudi tanpa pemotongan komisi (dapat dikonfigurasi oleh pengelola)",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Contoh Perhitungan:**\nTotal Angkutan: Rp 25.000\nKomisi Platform (15%): Rp 3.750\nPenghasilan Pengemudi: Rp 21.250",
				"Tingkat komisi dapat berubah dengan pemberitahuan sebelumnya. Pengemudi dan pedagang akan diberitahu tentang perubahan tarif setidaknya 14 hari sebelumnya.",
			],
		},
	});

export const walletSystem = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "wallet System",
			paragraphs: ["All users have an in-app wallet for managing funds:"],
			lists: [
				{
					items: [
						{
							label: "Top-Up",
							content:
								"Passengers can add funds via QRIS, bank transfer, or e-wallet through our payment partner Midtrans",
						},
						{
							label: "Payment",
							content:
								"Order payments are automatically deducted from wallet balance",
						},
						{
							label: "Earnings",
							content:
								"Driver and merchant earnings are credited to their wallets after order completion",
						},
						{
							label: "Balance Tracking",
							content: "View real-time wallet balance and transaction history",
						},
						{
							label: "Currency",
							content: "All transactions are in Indonesian Rupiah (IDR)",
						},
					],
				},
			],
			additionalParagraphs: [
				"Insufficient wallet balance will prevent order placement. Minimum top-up amounts and transaction limits may apply.",
			],
		},
		id: {
			title: "Sistem Dompet",
			paragraphs: [
				"Semua pengguna memiliki dompet dalam aplikasi untuk mengelola dana:",
			],
			lists: [
				{
					items: [
						{
							label: "Isi Ulang",
							content:
								"Penumpang dapat menambahkan dana melalui QRIS, transfer bank, atau e-wallet melalui mitra pembayaran kami Midtrans",
						},
						{
							label: "Pembayaran",
							content:
								"Pembayaran pesanan secara otomatis dikurangi dari saldo dompet",
						},
						{
							label: "Penghasilan",
							content:
								"Penghasilan pengemudi dan pedagang dikreditkan ke dompet mereka setelah pesanan selesai",
						},
						{
							label: "Pelacakan Saldo",
							content:
								"Lihat saldo dompet dan riwayat transaksi secara real-time",
						},
						{
							label: "Mata Uang",
							content: "Semua transaksi dalam Rupiah Indonesia (IDR)",
						},
					],
				},
			],
			additionalParagraphs: [
				"Saldo dompet yang tidak mencukupi akan mencegah penempatan pesanan. Jumlah minimum isi ulang dan batas transaksi dapat berlaku.",
			],
		},
	});

export const withdrawals = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Withdrawals",
			paragraphs: [
				"Drivers and merchants can withdraw earnings to their registered bank accounts:",
			],
			lists: [
				{
					items: [
						{ content: "Minimum withdrawal amount: Rp 50,000" },
						{ content: "Processing time: 1-3 business days" },
						{
							content: "Bank account must be in the driver/merchant's name",
						},
						{ content: "Transaction fees may apply depending on the bank" },
						{
							content:
								"Failed withdrawals due to incorrect bank information may incur fees",
						},
					],
				},
			],
		},
		id: {
			title: "Penarikan",
			paragraphs: [
				"Pengemudi dan pedagang dapat menarik penghasilan ke rekening bank terdaftar mereka:",
			],
			lists: [
				{
					items: [
						{ content: "Jumlah penarikan minimum: Rp 50.000" },
						{ content: "Waktu pemrosesan: 1-3 hari kerja" },
						{
							content: "Rekening bank harus atas nama pengemudi/pedagang",
						},
						{ content: "Biaya transaksi dapat berlaku tergantung pada bank" },
						{
							content:
								"Penarikan yang gagal karena informasi bank yang salah dapat dikenakan biaya",
						},
					],
				},
			],
		},
	});

// Order Management Sections
export const orderManagement = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Order Management",
			paragraphs: [],
		},
		id: {
			title: "Manajemen Pesanan",
			paragraphs: [],
		},
	});

export const rideHailing = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Ride-Hailing Services",
			paragraphs: [
				"**Passenger Responsibilities:**",
				"- Specify accurate pickup and dropoff locations\n- Be ready at the pickup location when the driver arrives\n- Treat drivers with respect and courtesy\n- Follow all safety guidelines\n- Ensure you have sufficient wallet balance",
				"",
				"**Driver Responsibilities:**",
				"- Accept orders you can fulfill\n- Navigate to pickup location promptly\n- Follow the designated route or a reasonable alternative\n- Maintain vehicle cleanliness and safety\n- Treat passengers with respect and ensure a comfortable journey\n- Complete orders as requested",
				"",
				"**Order Status Flow:**",
				"Requested → Matching → Accepted → Arriving → In-Trip → Completed",
			],
		},
		id: {
			title: "Layanan Hailing Angkutan",
			paragraphs: [
				"**Tanggung Jawab Penumpang:**",
				"- Tentukan lokasi penjemputan dan pengantaran yang akurat\n- Siap di lokasi penjemputan saat pengemudi tiba\n- Perlakukan pengemudi dengan hormat dan sopan\n- Ikuti semua pedoman keselamatan\n- Pastikan Anda memiliki saldo dompet yang cukup",
				"",
				"**Tanggung Jawab Pengemudi:**",
				"- Terima pesanan yang dapat Anda penuhi\n- Arahkan ke lokasi penjemputan dengan cepat\n- Ikuti rute yang ditentukan atau alternatif yang wajar\n- Pertahankan kebersihan dan keselamatan kendaraan\n- Perlakukan penumpang dengan hormat dan pastikan perjalanan yang nyaman\n- Selesaikan pesanan sesuai permintaan",
				"",
				"**Alur Status Pesanan:**",
				"Diminta → Pencocokan → Diterima → Sedang Menuju → Dalam Perjalanan → Selesai",
			],
		},
	});

export const packageDelivery = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Package Delivery",
			paragraphs: ["For package delivery services:"],
			lists: [
				{
					items: [
						{
							label: "Sender Responsibilities",
							content:
								"Accurately describe package size, provide clear pickup/dropoff addresses, ensure package is ready for pickup",
						},
						{
							label: "Driver Responsibilities",
							content:
								"Handle packages with care, obtain proof of delivery (photo or OTP from recipient), do not open or inspect package contents",
						},
						{
							label: "Prohibited Items",
							content:
								"Illegal substances, weapons, hazardous materials, cash, perishable food without proper packaging, or items exceeding size/weight limits",
						},
					],
				},
			],
			additionalParagraphs: [
				"AkadeMove is not responsible for package contents. Users agree not to ship prohibited or illegal items through our platform.",
			],
		},
		id: {
			title: "Pengiriman Paket",
			paragraphs: ["Untuk layanan pengiriman paket:"],
			lists: [
				{
					items: [
						{
							label: "Tanggung Jawab Pengirim",
							content:
								"Deskripsikan ukuran paket dengan akurat, berikan alamat penjemputan/pengantaran yang jelas, pastikan paket siap untuk dijemput",
						},
						{
							label: "Tanggung Jawab Pengemudi",
							content:
								"Menangani paket dengan hati-hati, memperoleh bukti pengiriman (foto atau OTP dari penerima), tidak membuka atau memeriksa isi paket",
						},
						{
							label: "Barang Terlarang",
							content:
								"Zat ilegal, senjata, bahan berbahaya, uang tunai, makanan mudah rusak tanpa kemasan yang tepat, atau barang yang melebihi batas ukuran/berat",
						},
					],
				},
			],
			additionalParagraphs: [
				"AkadeMove tidak bertanggung jawab atas isi paket. Pengguna setuju untuk tidak mengirim barang terlarang atau ilegal melalui platform kami.",
			],
		},
	});

export const foodDelivery = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Food Delivery",
			paragraphs: [
				"**Order Workflow:**",
				"- Customer places order from merchant menu\n- Merchant accepts and prepares order\n- Driver is assigned to pick up from merchant\n- Driver delivers to customer location",
				"",
				"**Merchant Responsibilities:**",
				"- Maintain accurate menu, pricing, and availability\n- Prepare orders within reasonable timeframes\n- Package food securely for delivery\n- Ensure food safety and quality standards\n- Mark items as out of stock promptly",
				"",
				"**Food Quality:** AkadeMove is not responsible for food quality, preparation, or safety. Merchants are solely responsible for the food they provide.",
			],
		},
		id: {
			title: "Pengiriman Makanan",
			paragraphs: [
				"**Alur Kerja Pesanan:**",
				"- Pelanggan melakukan pemesanan dari menu pedagang\n- Pedagang menerima dan menyiapkan pesanan\n- Pengemudi ditugaskan untuk mengambil dari pedagang\n- Pengemudi mengantarkan ke lokasi pelanggan",
				"",
				"**Tanggung Jawab Pedagang:**",
				"- Mempertahankan menu, harga, dan ketersedian yang akurat\n- Menyiapkan pesanan dalam waktu yang wajar\n- Mengemas makanan dengan aman untuk pengiriman\n- Memastikan standar keamanan dan kualitas makanan\n- Menandai item sebagai habis stok dengan cepat",
				"",
				"**Kualitas Makanan:** AkadeMove tidak bertanggung jawab atas kualitas, persiapan, atau keamanan makanan. Pedagang sepenuhnya bertanggung jawab atas makanan yang mereka sediakan.",
			],
		},
	});

// Safety and Additional Sections
export const safetyReporting = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Safety and Reporting",
			paragraphs: [
				"Your safety is our priority. AkadeMove provides several safety features:",
			],
			lists: [
				{
					items: [
						{
							label: "In-App Chat",
							content:
								"Communicate without sharing phone numbers (phone masking enabled)",
						},
						{
							label: "Driver Verification",
							content:
								"All drivers undergo document verification before activation",
						},
						{
							label: "Real-Time Tracking",
							content: "Share your trip with trusted contacts",
						},
						{
							label: "Emergency Button",
							content: "Quick access to campus security or emergency services",
						},
						{
							label: "Report System",
							content:
								"Report misconduct, harassment, fraud, or safety concerns",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Reporting Process:**\n- Submit report through the app with description and evidence\n- Reports are reviewed by our safety team within 24-48 hours\n- Investigation may include reviewing chat logs, order details, and GPS data\n- Actions taken may include warnings, temporary suspension, or permanent ban\n- Serious incidents may be reported to campus security or police",
				"**User Responsibilities:**\n- Report any safety concerns immediately\n- Do not share personal information unnecessarily\n- Use only the in-app communication features\n- Follow campus safety guidelines\n- Do not engage in prohibited conduct",
			],
		},
		id: {
			title: "Keamanan dan Pelaporan",
			paragraphs: [
				"Keamanan Anda adalah prioritas kami. AkadeMove menyediakan beberapa fitur keamanan:",
			],
			lists: [
				{
					items: [
						{
							label: "Obrolan Dalam Aplikasi",
							content:
								"Berkomunikasi tanpa membagikan nomor telepon (masking telepon diaktifkan)",
						},
						{
							label: "Verifikasi Pengemudi",
							content:
								"Semua pengemudi menjalani verifikasi dokumen sebelum aktivasi",
						},
						{
							label: "Pelacakan Waktu Nyata",
							content: "Bagikan perjalanan Anda dengan kontak tepercaya",
						},
						{
							label: "Tombol Darurat",
							content: "Akses cepat ke keamanan kampus atau layanan darurat",
						},
						{
							label: "Sistem Pelaporan",
							content:
								"Laporkan pelanggaran, pelecehan, penipuan, atau masalah keamanan",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Proses Pelaporan:**\n- Kirim laporan melalui aplikasi dengan deskripsi dan bukti\n- Laporan ditinjau oleh tim keamanan kami dalam waktu 24-48 jam\n- Investigasi dapat mencakup peninjauan log obrolan, detail pesanan, dan data GPS\n- Tindakan yang diambil dapat mencakup peringatan, penangguhan sementara, atau larangan permanen\n- Insiden serius dapat dilaporkan ke keamanan kampus atau polisi",
				"**Tanggung Jawab Pengguna:**\n- Laporkan masalah keamanan segera\n- Jangan bagikan informasi pribadi secara tidak perlu\n- Gunakan hanya fitur komunikasi dalam aplikasi\n- Ikuti pedoman keamanan kampus\n- Jangan terlibat dalam perilaku terlarang",
			],
		},
	});

export const genderPreference = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Gender Preference Feature",
			paragraphs: [
				"AkadeMove offers an optional gender preference feature for enhanced comfort and safety:",
			],
			lists: [
				{
					items: [
						{
							content:
								"Passengers can specify preference for same-gender drivers",
						},
						{
							content:
								"This preference is considered in the matching algorithm",
						},
						{
							content:
								"Availability depends on driver availability in your area",
						},
						{
							content:
								"Using this feature may increase wait times if same-gender drivers are not nearby",
						},
						{
							content:
								"Gender preference is optional and can be enabled/disabled",
						},
					],
				},
			],
			additionalParagraphs: [
				"This feature is designed to promote inclusivity and comfort, particularly for users who may feel more comfortable with same-gender service providers.",
			],
		},
		id: {
			title: "Fitur Preferensi Gender",
			paragraphs: [
				"AkadeMove menawarkan fitur preferensi gender opsional untuk kenyamanan dan keamanan yang lebih baik:",
			],
			lists: [
				{
					items: [
						{
							content:
								"Penumpang dapat menentukan preferensi untuk pengemudi sejenis",
						},
						{
							content:
								"Preferensi ini dipertimbangkan dalam algoritma pencocokan",
						},
						{
							content:
								"Ketersediaan tergantung pada ketersediaan pengemudi di area Anda",
						},
						{
							content:
								"Menggunakan fitur ini dapat meningkatkan waktu tunggu jika pengemudi sejenis tidak tersedia di dekat Anda",
						},
						{
							content:
								"Preferensi gender bersifat opsional dan dapat diaktifkan/nonaktifkan",
						},
					],
				},
			],
			additionalParagraphs: [
				"Fitur ini dirancang untuk mempromosikan inklusivitas dan kenyamanan, terutama bagi pengguna yang mungkin merasa lebih nyaman dengan penyedia layanan sejenis.",
			],
		},
	});

export const intellectualProperty = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Intellectual Property",
			paragraphs: [
				"The AkadeMove platform, including its software, design, content, trademarks, and logos, is owned by AkadeMove and protected by Indonesian and international intellectual property laws.",
				"You are granted a limited, non-exclusive, non-transferable license to access and use the Services for personal, non-commercial purposes.",
				"**User Content:** You retain ownership of content you submit (photos, reviews, messages). By submitting content, you grant AkadeMove a worldwide, royalty-free license to use, display, and distribute your content for platform operations and marketing purposes.",
				"You represent that you have all necessary rights to submit content and that your content does not violate any third-party rights or laws.",
			],
		},
		id: {
			title: "Kekayaan Intelektual",
			paragraphs: [
				"Platform AkadeMove, termasuk perangkat lunak, desain, konten, merek dagang, dan logo, dimiliki oleh AkadeMove dan dilindungi oleh hukum kekayaan intelektual Indonesia dan internasional.",
				"Kami memberikan lisensi terbatas, non-eksklusif, dan tidak dapat dipindahtangankan untuk mengakses dan menggunakan Layanan untuk tujuan pribadi dan non-komersial.",
				"**Konten Pengguna:** Anda mempertahankan kepemilikan atas konten yang Anda kirimkan (foto, ulasan, pesan). Dengan mengirimkan konten, Anda memberikan AkadeMove lisensi di seluruh dunia, bebas royalti untuk menggunakan, menampilkan, dan mendistribusikan konten Anda untuk operasi platform dan tujuan pemasaran.",
				"Anda menyatakan bahwa Anda memiliki semua hak yang diperlukan untuk mengirimkan konten dan bahwa konten Anda tidak melanggar hak pihak ketiga atau hukum apa pun.",
			],
		},
	});
