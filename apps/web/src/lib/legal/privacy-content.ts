/**
 * Privacy Policy Content
 *
 * This file contains all content for the Privacy Policy page.
 * Indonesian translations can be added to the `id` property of each content object.
 */

import type { LegalSectionContent } from "../legal-i18n";
import { getLegalContent } from "../legal-i18n";

export const privacyIntro = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Introduction",
			paragraphs: [
				"At AkadeMove, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your data when you use our platform and services.",
				"This policy complies with Indonesian data protection regulations, including Undang-Undang Nomor 27 Tahun 2022 tentang Pelindungan Data Pribadi (UU PDP 27/2022) and related regulations. By using our services, you consent to the data practices described in this policy.",
			],
		},
		id: {
			title: "Pendahuluan",
			paragraphs: [
				"Di AkadeMove, kami berkomitmen untuk melindungi privasi Anda dan memastikan keamanan informasi pribadi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, mengungkapkan, dan melindungi data Anda saat Anda menggunakan platform dan layanan kami.",
				"Kebijakan ini mematuhi peraturan perlindungan data Indonesia, termasuk Undang-Undang Nomor 27 Tahun 2022 tentang Pelindungan Data Pribadi (UU PDP 27/2022) dan peraturan terkait. Dengan menggunakan layanan kami, Anda menyetujui praktik data yang dijelaskan dalam kebijakan ini.",
			],
		},
	});

export const informationWeCollect = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Information We Collect",
			paragraphs: [
				"We collect various types of information to provide and improve our services:",
			],
			lists: [
				{
					title: "Personal Information",
					items: [
						{
							label: "Account Information",
							content:
								"Name, email address, phone number, date of birth, and profile picture",
						},
						{
							label: "Identity Verification",
							content:
								"For drivers: ID card (KTP), driver's license (SIM), vehicle registration (STNK)",
						},
						{
							label: "Payment Information",
							content:
								"Bank account details, payment card information, transaction history",
						},
						{
							label: "Location Data",
							content:
								"Real-time GPS location, pickup and drop-off addresses, route information",
						},
					],
				},
				{
					title: "Usage Information",
					items: [
						{
							label: "Device Information",
							content:
								"Device type, operating system, unique device identifiers, mobile network information",
						},
						{
							label: "Log Data",
							content:
								"IP address, access times, app features used, pages viewed, crashes and system activity",
						},
						{
							label: "Communication Data",
							content:
								"Messages between users and drivers, customer support interactions, feedback and ratings",
						},
					],
				},
				{
					title: "Information from Third Parties",
					items: [
						{
							label: "Social Media",
							content:
								"Profile information if you choose to connect via social media accounts",
						},
						{
							label: "Payment Processors",
							content: "Transaction verification and payment processing data",
						},
						{
							label: "Background Checks",
							content:
								"For driver verification, we may receive information from screening services",
						},
					],
				},
			],
		},
		id: {
			title: "Informasi yang Kami Kumpulkan",
			paragraphs: [
				"Kami mengumpulkan berbagai jenis informasi untuk menyediakan dan meningkatkan layanan kami:",
			],
			lists: [
				{
					title: "Informasi Pribadi",
					items: [
						{
							label: "Informasi Akun",
							content:
								"Nama, alamat email, nomor telepon, tanggal lahir, dan foto profil",
						},
						{
							label: "Verifikasi Identitas",
							content: "Untuk pengemudi: KTP, SIM, STNK",
						},
						{
							label: "Informasi Pembayaran",
							content:
								"Detail rekening bank, informasi kartu pembayaran, riwayat transaksi",
						},
						{
							label: "Data Lokasi",
							content:
								"Lokasi GPS real-time, alamat penjemputan dan pengantaran, informasi rute",
						},
					],
				},
				{
					title: "Informasi Penggunaan",
					items: [
						{
							label: "Informasi Perangkat",
							content:
								"Tipe perangkat, sistem operasi, pengenal unik perangkat, informasi jaringan seluler",
						},
						{
							label: "Data Log",
							content:
								"Alamat IP, waktu akses, fitur aplikasi yang digunakan, halaman yang dilihat, aktivitas sistem dan kerusakan",
						},
						{
							label: "Data Komunikasi",
							content:
								"Pesan antara pengguna dan pengemudi, interaksi dukungan pelanggan, umpan balik dan penilaian",
						},
					],
				},
				{
					title: "Informasi dari Pihak Ketiga",
					items: [
						{
							label: "Media Sosial",
							content:
								"Informasi profil jika Anda memilih untuk terhubung melalui akun media sosial",
						},
						{
							label: "Prosesor Pembayaran",
							content: "Verifikasi transaksi dan data pemrosesan pembayaran",
						},
						{
							label: "Pemeriksaan Latar Belakang",
							content:
								"Untuk verifikasi pengemudi, kami mungkin menerima informasi dari layanan penyaringan",
						},
					],
				},
			],
		},
	});

export const howWeUseInformation = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "How We Use Your Information",
			paragraphs: [
				"We use the collected information for the following purposes:",
			],
			lists: [
				{
					items: [
						{
							label: "Service Delivery",
							content:
								"Facilitate ride-hailing and delivery services, connect users with drivers, process payments, and manage bookings",
						},
						{
							label: "Safety and Security",
							content:
								"Verify driver identity, monitor suspicious activity, prevent fraud, ensure passenger safety",
						},
						{
							label: "Communication",
							content:
								"Send booking confirmations, service updates, promotional offers, and customer support responses",
						},
						{
							label: "Improvement and Analytics",
							content:
								"Analyze usage patterns, improve app functionality, optimize routes, develop new features",
						},
						{
							label: "Legal Compliance",
							content:
								"Comply with Indonesian laws, respond to legal requests, resolve disputes, enforce our terms of service",
						},
						{
							label: "Personalization",
							content:
								"Customize user experience, provide relevant recommendations, display targeted content",
						},
					],
				},
			],
		},
		id: {
			title: "Bagaimana Kami Menggunakan Informasi Anda",
			paragraphs: [
				"Kami menggunakan informasi yang dikumpulkan untuk tujuan berikut:",
			],
			lists: [
				{
					items: [
						{
							label: "Penyampaian Layanan",
							content:
								"Memfasilitasi layanan pemesanan kendaraan dan pengantaran, menghubungkan pengguna dengan pengemudi, memproses pembayaran, dan mengelola pemesanan",
						},
						{
							label: "Keamanan dan Perlindungan",
							content:
								"Memverifikasi identitas pengemudi, memantau aktivitas mencurigakan, mencegah penipuan, memastikan keselamatan penumpang",
						},
						{
							label: "Komunikasi",
							content:
								"Mengirim konfirmasi pemesanan, pembaruan layanan, penawaran promosi, dan respons dukungan pelanggan",
						},
						{
							label: "Peningkatan dan Analitik",
							content:
								"Menganalisis pola penggunaan, meningkatkan fungsionalitas aplikasi, mengoptimalkan rute, mengembangkan fitur baru",
						},
						{
							label: "Kepatuhan Hukum",
							content:
								"Mematuhi hukum Indonesia, menanggapi permintaan hukum, menyelesaikan sengketa, menegakkan syarat layanan kami",
						},
						{
							label: "Personalisasi",
							content:
								"Mengustomisasi pengalaman pengguna, memberikan rekomendasi yang relevan, menampilkan konten yang ditargetkan",
						},
					],
				},
			],
		},
	});

export const informationSharing = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Information Sharing and Disclosure",
			paragraphs: [
				"We may share your information in the following circumstances:",
			],
			lists: [
				{
					items: [
						{
							label: "Between Users and Drivers",
							content:
								"Name, profile picture, location, and contact information necessary for service completion",
						},
						{
							label: "With Merchants",
							content:
								"Delivery address and contact information for food and package delivery services",
						},
						{
							label: "Service Providers",
							content:
								"Third-party vendors who assist with payment processing, cloud storage, customer support, and analytics",
						},
						{
							label: "Business Transfers",
							content:
								"In connection with mergers, acquisitions, or asset sales, subject to confidentiality agreements",
						},
						{
							label: "Legal Requirements",
							content:
								"When required by Indonesian law, court orders, or government authorities",
						},
						{
							label: "Safety and Protection",
							content:
								"To protect the rights, property, or safety of AkadeMove, our users, or others",
						},
						{
							label: "With Your Consent",
							content: "In any other circumstances with your explicit consent",
						},
					],
				},
			],
		},
		id: {
			title: "Berbagi dan Pengungkapan Informasi",
			paragraphs: [
				"Kami dapat membagikan informasi Anda dalam keadaan berikut:",
			],
			lists: [
				{
					items: [
						{
							label: "Antara Pengguna dan Pengemudi",
							content:
								"Nama, foto profil, lokasi, dan informasi kontak yang diperlukan untuk menyelesaikan layanan",
						},
						{
							label: "Dengan Pedagang",
							content:
								"Alamat pengiriman dan informasi kontak untuk layanan pengantaran makanan dan paket",
						},
						{
							label: "Penyedia Layanan",
							content:
								"Vendor pihak ketiga yang membantu dengan pemrosesan pembayaran, penyimpanan cloud, dukungan pelanggan, dan analitik",
						},
						{
							label: "Transfer Bisnis",
							content:
								"Dalam kaitannya dengan merger, akuisisi, atau penjualan aset, tunduk pada perjanjian kerahasiaan",
						},
						{
							label: "Kewajiban Hukum",
							content:
								"Saat diwajibkan oleh hukum Indonesia, perintah pengadilan, atau otoritas pemerintah",
						},
						{
							label: "Keamanan dan Perlindungan",
							content:
								"Untuk melindungi hak, properti, atau keselamatan AkadeMove, pengguna kami, atau pihak lain",
						},
						{
							label: "Dengan Persetujuan Anda",
							content: "Dalam keadaan lain dengan persetujuan eksplisit Anda",
						},
					],
				},
			],
		},
	});

export const dataRetention = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Data Retention",
			paragraphs: [
				"We retain your personal information for as long as necessary to provide our services and comply with legal obligations:",
			],
			lists: [
				{
					items: [
						{
							label: "Active Accounts",
							content:
								"Information is retained while your account is active and for a reasonable period afterward",
						},
						{
							label: "Transaction Records",
							content:
								"Financial records are retained for 10 years as required by Indonesian tax laws",
						},
						{
							label: "Legal Requirements",
							content:
								"Data required for legal compliance or dispute resolution is retained as necessary",
						},
						{
							label: "Deleted Accounts",
							content:
								"Most data is deleted within 90 days of account deletion, except where retention is legally required",
						},
					],
				},
			],
		},
		id: {
			title: "Penyimpanan Data",
			paragraphs: [
				"Kami menyimpan informasi pribadi Anda selama diperlukan untuk menyediakan layanan kami dan mematuhi kewajiban hukum:",
			],
			lists: [
				{
					items: [
						{
							label: "Akun Aktif",
							content:
								"Informasi disimpan selama akun Anda aktif dan untuk periode wajar setelahnya",
						},
						{
							label: "Rekam Transaksi",
							content:
								"Catatan keuangan disimpan selama 10 tahun sesuai dengan hukum perpajakan Indonesia",
						},
						{
							label: "Kewajiban Hukum",
							content:
								"Data yang diperlukan untuk kepatuhan hukum atau penyelesaian sengketa disimpan sesuai kebutuhan",
						},
						{
							label: "Akun Dihapus",
							content:
								"Kebanyakan data dihapus dalam waktu 90 hari setelah penghapusan akun, kecuali jika penyimpanan diwajibkan secara hukum",
						},
					],
				},
			],
		},
	});

export const yourRights = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Your Rights",
			paragraphs: [
				"Under Indonesian data protection law (UU PDP 27/2022), you have the following rights:",
			],
			lists: [
				{
					items: [
						{
							label: "Access",
							content:
								"Request access to your personal information that we hold",
						},
						{
							label: "Correction",
							content:
								"Request correction of inaccurate or incomplete information",
						},
						{
							label: "Deletion",
							content:
								"Request deletion of your personal information, subject to legal retention requirements",
						},
						{
							label: "Objection",
							content:
								"Object to processing of your information for certain purposes",
						},
						{
							label: "Data Portability",
							content:
								"Request a copy of your data in a structured, machine-readable format",
						},
						{
							label: "Withdrawal of Consent",
							content:
								"Withdraw consent for data processing where consent is the legal basis",
						},
						{
							label: "Complaint",
							content:
								"Lodge a complaint with the Indonesian data protection authority",
						},
					],
				},
			],
		},
		id: {
			title: "Hak Anda",
			paragraphs: [
				"Di bawah hukum perlindungan data Indonesia (UU PDP 27/2022), Anda memiliki hak berikut:",
			],
			lists: [
				{
					items: [
						{
							label: "Akses",
							content:
								"Meminta akses ke informasi pribadi Anda yang kami miliki",
						},
						{
							label: "Koreksi",
							content:
								"Meminta koreksi informasi yang tidak akurat atau tidak lengkap",
						},
						{
							label: "Penghapusan",
							content:
								"Meminta penghapusan informasi pribadi Anda, tunduk pada persyaratan penyimpanan hukum",
						},
						{
							label: "Keberatan",
							content:
								"Menolak pemrosesan informasi Anda untuk tujuan tertentu",
						},
						{
							label: "Portabilitas Data",
							content:
								"Meminta salinan data Anda dalam format terstruktur yang dapat dibaca mesin",
						},
						{
							label: "Penarikan Persetujuan",
							content:
								"Menarik persetujuan untuk pemrosesan data di mana persetujuan adalah dasar hukum",
						},
						{
							label: "Pengaduan",
							content:
								"Mengajukan pengaduan kepada otoritas perlindungan data Indonesia",
						},
					],
				},
			],
		},
	});

export const dataSecurity = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Data Security",
			paragraphs: [
				"We implement appropriate technical and organizational measures to protect your personal information:",
			],
			lists: [
				{
					items: [
						{
							label: "Encryption",
							content:
								"Data in transit is encrypted using TLS/SSL protocols; sensitive data at rest is encrypted",
						},
						{
							label: "Access Controls",
							content:
								"Strict access controls limit employee access to personal information on a need-to-know basis",
						},
						{
							label: "Security Monitoring",
							content:
								"Continuous monitoring for security threats and vulnerabilities",
						},
						{
							label: "Regular Audits",
							content: "Periodic security assessments and compliance audits",
						},
						{
							label: "Incident Response",
							content:
								"Established procedures for detecting, reporting, and responding to data breaches",
						},
					],
				},
			],
			additionalParagraphs: [
				"Despite our efforts, no security system is impenetrable. We cannot guarantee the absolute security of your information.",
			],
		},
		id: {
			title: "Keamanan Data",
			paragraphs: [
				"Kami menerapkan langkah-langkah teknis dan organisasi yang sesuai untuk melindungi informasi pribadi Anda:",
			],
			lists: [
				{
					items: [
						{
							label: "Enkripsi",
							content:
								"Data dalam perjalanan dienkripsi menggunakan protokol TLS/SSL; data sensitif yang disimpan dienkripsi",
						},
						{
							label: "Kontrol Akses",
							content:
								"Kontrol akses ketat membatasi akses karyawan ke informasi pribadi berdasarkan kebutuhan",
						},
						{
							label: "Pemantauan Keamanan",
							content:
								"Pemantauan terus-menerus terhadap ancaman dan kerentanan keamanan",
						},
						{
							label: "Audit Berkala",
							content: "Penilaian keamanan dan audit kepatuhan secara berkala",
						},
						{
							label: "Tanggap Insiden",
							content:
								"Prosedur yang telah ditetapkan untuk mendeteksi, melaporkan, dan menanggapi pelanggaran data",
						},
					],
				},
			],
			additionalParagraphs: [
				"Meskipun kami berupaya semaksimal mungkin, tidak ada sistem keamanan yang sepenuhnya kebal. Kami tidak dapat menjamin keamanan mutlak informasi Anda.",
			],
		},
	});

export const internationalTransfers = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "International Data Transfers",
			paragraphs: [
				"Your information may be transferred to and processed in countries other than Indonesia, including for cloud storage and data processing services. We ensure that such transfers comply with Indonesian data protection laws through:",
			],
			lists: [
				{
					items: [
						{
							label: "Adequacy Decisions",
							content:
								"Transfers to countries deemed to have adequate data protection",
						},
						{
							label: "Standard Contractual Clauses",
							content: "Use of approved data transfer agreements",
						},
						{
							label: "Data Processing Agreements",
							content:
								"Contracts with service providers that include data protection obligations",
						},
					],
				},
			],
		},
		id: {
			title: "Transfer Data Internasional",
			paragraphs: [
				"Informasi Anda dapat ditransfer ke dan diproses di negara selain Indonesia, termasuk untuk penyimpanan cloud dan layanan pemrosesan data. Kami memastikan bahwa transfer tersebut mematuhi hukum perlindungan data Indonesia melalui:",
			],
			lists: [
				{
					items: [
						{
							label: "Keputusan Kecukupan",
							content:
								"Transfer ke negara yang dianggap memiliki perlindungan data yang memadai",
						},
						{
							label: "Klausul Kontrak Standar",
							content: "Penggunaan perjanjian transfer data yang disetujui",
						},
						{
							label: "Perjanjian Pemrosesan Data",
							content:
								"Kontrak dengan penyedia layanan yang mencakup kewajiban perlindungan data",
						},
					],
				},
			],
		},
	});

export const childrenPrivacy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Children's Privacy",
			paragraphs: [
				"Our services are not intended for children under 17 years of age. We do not knowingly collect personal information from children. If you are a parent or guardian and believe your child has provided us with personal information, please contact us, and we will delete such information.",
			],
		},
		id: {
			title: "Privasi Anak-anak",
			paragraphs: [
				"Layanan kami tidak ditujukan untuk anak-anak di bawah usia 17 tahun. Kami tidak secara sadar mengumpulkan informasi pribadi dari anak-anak. Jika Anda adalah orang tua atau wali dan percaya bahwa anak Anda telah memberikan informasi pribadi kepada kami, silakan hubungi kami, dan kami akan menghapus informasi tersebut.",
			],
		},
	});

export const changesToPolicy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Changes to This Privacy Policy",
			paragraphs: [
				"We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of material changes by:",
			],
			lists: [
				{
					items: [
						{
							label: "In-App Notification",
							content: "Push notifications or in-app messages",
						},
						{
							label: "Email",
							content: "Notification to your registered email address",
						},
						{
							label: "Website Notice",
							content: "Prominent notice on our website",
						},
					],
				},
			],
			additionalParagraphs: [
				"Continued use of our services after changes become effective constitutes acceptance of the updated policy.",
			],
		},
		id: {
			title: "Perubahan pada Kebijakan Privasi Ini",
			paragraphs: [
				"Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu untuk mencerminkan perubahan dalam praktik atau persyaratan hukum kami. Kami akan memberi tahu Anda tentang perubahan material dengan:",
			],
			lists: [
				{
					items: [
						{
							label: "Notifikasi Dalam Aplikasi",
							content: "Notifikasi push atau pesan dalam aplikasi",
						},
						{
							label: "Email",
							content: "Notifikasi ke alamat email terdaftar Anda",
						},
						{
							label: "Pemberitahuan Situs Web",
							content: "Pemberitahuan mencolok di situs web kami",
						},
					],
				},
			],
			additionalParagraphs: [
				"Penggunaan layanan kami yang berkelanjutan setelah perubahan berlaku merupakan penerimaan kebijakan yang diperbarui.",
			],
		},
	});

export const contactUs = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Contact Us",
			paragraphs: [
				"For questions, concerns, or to exercise your rights regarding your personal information, please contact our Data Protection Officer:",
			],
			lists: [
				{
					items: [
						{
							label: "Email",
							content: "privacy@akademove.com",
						},
						{
							label: "Phone",
							content: "+62 21 1234 5678",
						},
						{
							label: "Address",
							content:
								"AkadeMove, Universitas Negeri Surabaya, Surabaya, Jawa Timur",
						},
						{
							label: "Response Time",
							content:
								"We aim to respond to all requests within 14 business days",
						},
					],
				},
			],
		},
		id: {
			title: "Hubungi Kami",
			paragraphs: [
				"Untuk pertanyaan, kekhawatiran, atau untuk menggunakan hak Anda terkait informasi pribadi Anda, silakan hubungi Petugas Perlindungan Data kami:",
			],
			lists: [
				{
					items: [
						{
							label: "Email",
							content: "privacy@akademove.com",
						},
						{
							label: "Telepon",
							content: "+62 21 1234 5678",
						},
						{
							label: "Alamat",
							content:
								"AkadeMove, Universitas Negeri Surabaya, Surabaya, Jawa Timur",
						},
						{
							label: "Waktu Respons",
							content:
								"Kami berusaha merespons semua permintaan dalam waktu 14 hari kerja",
						},
					],
				},
			],
		},
	});
