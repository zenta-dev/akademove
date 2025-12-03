/**
 * Cookie Policy Content
 *
 * This file contains all content for the Cookie Policy page.
 * Indonesian translations can be added to the `id` property of each content object.
 */

import type { LegalSectionContent } from "../legal-i18n";
import { getLegalContent } from "../legal-i18n";

export const cookieIntro = () =>
	getLegalContent({
		en: [
			"This Cookie Policy explains how AkadeMove uses cookies and similar tracking technologies on our website and mobile application. By using our Services, you consent to our use of cookies as described in this policy.",
			"We use cookies to provide, improve, and protect our Services, and to give you a better experience. This policy should be read in conjunction with our Privacy Policy.",
		],
		id: [
			"Kebijakan Cookie ini menjelaskan bagaimana AkadeMove menggunakan cookie dan teknologi pelacakan serupa di situs web dan aplikasi seluler kami. Dengan menggunakan Layanan kami, Anda menyetujui penggunaan cookie oleh kami sebagaimana dijelaskan dalam kebijakan ini.",
			"Kami menggunakan cookie untuk menyediakan, meningkatkan, dan melindungi Layanan kami, serta untuk memberikan Anda pengalaman yang lebih baik. Kebijakan ini harus dibaca bersama dengan Kebijakan Privasi kami.	",
		],
	});

export const whatAreCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "What Are Cookies?",
			paragraphs: [
				"Cookies are small text files stored on your device (computer, smartphone, or tablet) when you visit a website or use an application. They help websites remember information about your visit, making your experience more efficient and personalized.",
				'Cookies can be "persistent" (remaining on your device until deleted or expired) or "session" (deleted when you close your browser).',
			],
		},
		id: {
			title: "Apa itu Cookie?",
			paragraphs: [
				"Kuki adalah berkas teks kecil yang disimpan di perangkat Anda (komputer, ponsel pintar, atau tablet) saat Anda mengunjungi situs web atau menggunakan aplikasi. Kuki membantu situs web mengingat informasi tentang kunjungan Anda, menjadikan pengalaman Anda lebih efisien dan personal.",
				'Kuki dapat berupa "persisten" (tetap di perangkat Anda sampai dihapus atau kedaluwarsa) atau "sesi" (dihapus saat Anda menutup browser).',
			],
		},
	});

export const cookiesWeUse = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Types of Cookies We Use",
			paragraphs: [],
			lists: [
				{
					items: [
						{
							label: "Essential Cookies",
							content:
								"Required for the Services to function properly. These enable core functionality like security, authentication, and payment processing. Without these cookies, certain features cannot be provided.",
						},
						{
							label: "Performance Cookies",
							content:
								"Collect information about how you use our Services, such as which pages you visit most often. This data helps us improve performance and user experience. These cookies are aggregated and anonymous.",
						},
						{
							label: "Functionality Cookies",
							content:
								"Remember your preferences and settings, such as language selection, location, and customizations. These enhance your experience by providing personalized features.",
						},
						{
							label: "Analytics Cookies",
							content:
								"Help us understand user behavior, measure traffic, and analyze trends. We use Google Analytics and similar tools to gather insights that improve our Services.",
						},
						{
							label: "Advertising Cookies",
							content:
								"Used to deliver relevant advertisements and measure campaign effectiveness. These cookies track your browsing activity across websites to show personalized ads.",
						},
					],
				},
			],
		},
		id: {
			title: "Jenis Kuki yang Kami Gunakan",
			paragraphs: [],
			lists: [
				{
					items: [
						{
							label: "Kuki Esensial",
							content:
								"Diperlukan agar Layanan berfungsi dengan baik. Kuki ini memungkinkan fungsi inti seperti keamanan, otentikasi, dan pemrosesan pembayaran. Tanpa kuki ini, fitur tertentu tidak dapat disediakan.",
						},
						{
							label: "Kuki Performa",
							content:
								"Mengumpulkan informasi tentang bagaimana Anda menggunakan Layanan kami, seperti halaman mana yang paling sering Anda kunjungi. Data ini membantu kami meningkatkan performa dan pengalaman pengguna. Kuki ini bersifat agregat dan anonim.",
						},
						{
							label: "Kuki Fungsionalitas",
							content:
								"Mengingat preferensi dan pengaturan Anda, seperti pilihan bahasa, lokasi, dan kustomisasi. Kuki ini meningkatkan pengalaman Anda dengan menyediakan fitur yang dipersonalisasi.",
						},
						{
							label: "Kuki Analitik",
							content:
								"Membantu kami memahami perilaku pengguna, mengukur lalu lintas, dan menganalisis tren. Kami menggunakan Google Analytics dan alat serupa untuk mengumpulkan wawasan yang meningkatkan Layanan kami.",
						},
						{
							label: "Kuki Iklan",
							content:
								"Digunakan untuk menyampaikan iklan yang relevan dan mengukur efektivitas kampanye. Kuki ini melacak aktivitas penelusuran Anda di berbagai situs web untuk menampilkan iklan yang dipersonalisasi.",
						},
					],
				},
			],
		},
	});

export const specificCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Specific Cookies We Use",
			paragraphs: [],
			lists: [
				{
					title: "First-Party Cookies",
					items: [
						{
							label: "session_id",
							content: "Maintains your login session (Essential, Session)",
						},
						{
							label: "auth_token",
							content: "Authenticates your requests (Essential, Persistent)",
						},
						{
							label: "locale",
							content:
								"Remembers your language preference (Functionality, Persistent)",
						},
						{
							label: "theme",
							content:
								"Stores your dark/light mode preference (Functionality, Persistent)",
						},
						{
							label: "consent",
							content:
								"Records your cookie consent choices (Essential, Persistent)",
						},
					],
				},
				{
					title: "Third-Party Cookies",
					items: [
						{
							label: "Google Analytics (_ga, _gid)",
							content:
								"Tracks usage statistics and user journeys (Analytics, Persistent)",
						},
						{
							label: "Google Maps",
							content:
								"Enables map functionality and location services (Functionality, Session)",
						},
						{
							label: "Payment Processors (Midtrans)",
							content:
								"Facilitates secure payment processing (Essential, Session)",
						},
						{
							label: "Social Media (Facebook, Instagram)",
							content:
								"Enables social sharing features (Functionality, Persistent)",
						},
					],
				},
			],
		},
		id: {
			title: "Kuki Spesifik yang Kami Gunakan",
			paragraphs: [],
			lists: [
				{
					title: "Kuki Pihak Pertama",
					items: [
						{
							label: "session_id",
							content: "Mempertahankan sesi login Anda (Esensial, Sesi)",
						},
						{
							label: "auth_token",
							content: "Mengesahkan permintaan Anda (Esensial, Persisten)",
						},
						{
							label: "locale",
							content:
								"Mengingat preferensi bahasa Anda (Fungsionalitas, Persisten)",
						},
						{
							label: "theme",
							content:
								"Menyimpan preferensi mode gelap/terang Anda (Fungsionalitas, Persisten)",
						},
						{
							label: "consent",
							content:
								"Mencatat pilihan persetujuan cookie Anda (Esensial, Persisten)",
						},
					],
				},
				{
					title: "Kuki Pihak Ketiga",
					items: [
						{
							label: "Google Analytics (_ga, _gid)",
							content:
								"Melacak statistik penggunaan dan perjalanan pengguna (Analitik, Persisten)",
						},
						{
							label: "Google Maps",
							content:
								"Memungkinkan fungsi peta dan layanan lokasi (Fungsionalitas, Sesi)",
						},
						{
							label: "Payment Processors (Midtrans)",
							content:
								"Memfasilitasi pemrosesan pembayaran yang aman (Esensial, Sesi)",
						},
						{
							label: "Social Media (Facebook, Instagram)",
							content:
								"Memungkinkan fitur berbagi sosial (Fungsionalitas, Persisten)",
						},
					],
				},
			],
		},
	});

export const howWeUseCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "How We Use Cookies",
			paragraphs: ["We use cookies for the following purposes:"],
			lists: [
				{
					items: [
						{
							label: "Authentication",
							content: "Keep you logged in and verify your identity",
						},
						{
							label: "Security",
							content:
								"Detect and prevent fraudulent activity and security threats",
						},
						{
							label: "Preferences",
							content:
								"Remember your settings, language, and customization choices",
						},
						{
							label: "Performance",
							content:
								"Monitor app performance, load times, and technical issues",
						},
						{
							label: "Analytics",
							content:
								"Understand usage patterns, popular features, and user journeys",
						},
						{
							label: "Advertising",
							content:
								"Deliver targeted promotions and measure marketing effectiveness",
						},
						{
							label: "Improvement",
							content: "Identify areas for enhancement and test new features",
						},
					],
				},
			],
		},
		id: {
			title: "Bagaimana Kami Menggunakan Kuki",
			paragraphs: ["Kami menggunakan kuki untuk tujuan berikut:"],
			lists: [
				{
					items: [
						{
							label: "Otentikasi",
							content:
								"Menjaga Anda tetap masuk dan memverifikasi identitas Anda",
						},
						{
							label: "Keamanan",
							content:
								"Mendeteksi dan mencegah aktivitas penipuan dan ancaman keamanan",
						},
						{
							label: "Preferensi",
							content:
								"Mengingat pengaturan, bahasa, dan pilihan kustomisasi Anda",
						},
						{
							label: "Performa",
							content:
								"Memantau performa aplikasi, waktu muat, dan masalah teknis",
						},
						{
							label: "Analitik",
							content:
								"Memahami pola penggunaan, fitur populer, dan perjalanan pengguna",
						},
						{
							label: "Iklan",
							content:
								"Menyampaikan promosi yang ditargetkan dan mengukur efektivitas pemasaran",
						},
						{
							label: "Peningkatan",
							content:
								"Mengidentifikasi area untuk peningkatan dan menguji fitur baru",
						},
					],
				},
			],
		},
	});

export const managingCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Managing Your Cookie Preferences",
			paragraphs: [
				"You have control over cookies and can manage them in several ways:",
			],
			lists: [
				{
					title: "Browser Settings",
					items: [
						{
							label: "Block Cookies",
							content:
								"Configure your browser to reject all cookies or specific types",
						},
						{
							label: "Delete Cookies",
							content: "Remove existing cookies from your browser at any time",
						},
						{
							label: "Notification",
							content: "Set your browser to notify you when cookies are set",
						},
					],
				},
				{
					title: "Our Cookie Consent Tool",
					items: [
						{
							label: "Preference Center",
							content:
								"Manage your cookie preferences through our in-app cookie settings",
						},
						{
							label: "Granular Control",
							content:
								"Choose which non-essential cookie categories to accept or reject",
						},
					],
				},
				{
					title: "Third-Party Opt-Outs",
					items: [
						{
							label: "Google Analytics",
							content: "Install the Google Analytics Opt-out Browser Add-on",
						},
						{
							label: "Advertising",
							content:
								"Use opt-out tools from advertising networks like NAI or DAA",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Note:** Blocking essential cookies may prevent certain features from functioning properly. If you disable cookies, you may not be able to access all parts of our Services.",
			],
		},
		id: {
			title: "Mengelola Preferensi Kuki Anda",
			paragraphs: [
				"Anda memiliki kontrol atas kuki dan dapat mengelolanya dengan beberapa cara:",
			],
			lists: [
				{
					title: "Pengaturan Browser",
					items: [
						{
							label: "Blokir Kuki",
							content:
								"Konfigurasikan browser Anda untuk menolak semua kuki atau jenis tertentu",
						},
						{
							label: "Hapus Kuki",
							content: "Hapus kuki yang ada dari browser Anda kapan saja",
						},
						{
							label: "Notifikasi",
							content:
								"Atur browser Anda untuk memberi tahu Anda saat kuki disetel",
						},
					],
				},
				{
					title: "Alat Persetujuan Kuki Kami",
					items: [
						{
							label: "Pusat Preferensi",
							content:
								"Mengelola preferensi kuki Anda melalui pengaturan kuki di aplikasi kami",
						},
						{
							label: "Kontrol Granular",
							content:
								"Pilih kategori kuki non-esensial mana yang akan diterima atau ditolak",
						},
					],
				},
				{
					title: "Opt-Out Pihak Ketiga",
					items: [
						{
							label: "Google Analytics",
							content: "Pasang Google Analytics Opt-out Browser Add-on",
						},
						{
							label: "Iklan",
							content:
								"Gunakan alat opt-out dari jaringan iklan seperti NAI atau DAA",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Catatan:** Memblokir kuki esensial dapat mencegah fitur tertentu berfungsi dengan baik. Jika Anda menonaktifkan kuki, Anda mungkin tidak dapat mengakses semua bagian dari Layanan kami.",
			],
		},
	});

export const thirdPartyServices = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Third-Party Services",
			paragraphs: [
				"We use third-party services that may set their own cookies. These services have their own privacy policies:",
			],
			lists: [
				{
					items: [
						{
							label: "Google Analytics",
							content:
								"Web analytics service - https://policies.google.com/privacy",
						},
						{
							label: "Google Maps",
							content:
								"Mapping and location services - https://policies.google.com/privacy",
						},
						{
							label: "Midtrans",
							content: "Payment gateway - https://midtrans.com/privacy-notice",
						},
						{
							label: "Firebase",
							content:
								"Push notifications and analytics - https://firebase.google.com/support/privacy",
						},
						{
							label: "Cloudflare",
							content:
								"Content delivery and security - https://www.cloudflare.com/privacypolicy",
						},
					],
				},
			],
			additionalParagraphs: [
				"We are not responsible for the privacy practices of these third parties. We encourage you to review their policies.",
			],
		},
		id: {
			title: "Layanan Pihak Ketiga",
			paragraphs: [
				"Kami menggunakan layanan pihak ketiga yang mungkin menetapkan kuki mereka sendiri. Layanan ini memiliki kebijakan privasi mereka sendiri:",
			],
			lists: [
				{
					items: [
						{
							label: "Google Analytics",
							content:
								"Layanan analitik web - https://policies.google.com/privacy",
						},
						{
							label: "Google Maps",
							content:
								"Layanan pemetaan dan lokasi - https://policies.google.com/privacy",
						},
						{
							label: "Midtrans",
							content:
								"Gateway pembayaran - https://midtrans.com/privacy-notice",
						},
						{
							label: "Firebase",
							content:
								"Notifikasi push dan analitik - https://firebase.google.com/support/privacy",
						},
						{
							label: "Cloudflare",
							content:
								"Pengiriman konten dan keamanan - https://www.cloudflare.com/privacypolicy",
						},
					],
				},
			],
			additionalParagraphs: [
				"Kami tidak bertanggung jawab atas praktik privasi pihak ketiga ini. Kami mendorong Anda untuk meninjau kebijakan mereka.",
			],
		},
	});

export const changesToCookiePolicy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Changes to This Cookie Policy",
			paragraphs: [
				"We may update this Cookie Policy from time to time to reflect changes in our practices or for operational, legal, or regulatory reasons. We will notify you of material changes by:",
				'- Updating the "Last Updated" date at the top of this policy',
				"- Providing notice through our Services or via email",
				"- Requesting renewed consent where required",
				"",
				"We encourage you to review this policy periodically.",
			],
		},
		id: {
			title: "Perubahan pada Kebijakan Kuki Ini",
			paragraphs: [
				"Kami dapat memperbarui Kebijakan Kuki ini dari waktu ke waktu untuk mencerminkan perubahan dalam praktik kami atau untuk alasan operasional, hukum, atau regulasi. Kami akan memberi tahu Anda tentang perubahan material dengan cara:",
				'- Memperbarui tanggal "Terakhir Diperbarui" di bagian atas kebijakan ini',
				"- Memberikan pemberitahuan melalui Layanan kami atau melalui email",
				"- Meminta persetujuan ulang jika diperlukan",
				"",
				"Kami mendorong Anda untuk meninjau kebijakan ini secara berkala.",
			],
		},
	});

export const contactCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Contact Us About Cookies",
			paragraphs: [
				"If you have questions about our use of cookies or this Cookie Policy, please contact us:",
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
					],
				},
			],
		},
		id: {
			title: "Hubungi Kami Tentang Kuki",
			paragraphs: [
				"Jika Anda memiliki pertanyaan tentang penggunaan kuki kami atau Kebijakan Kuki ini, silakan hubungi kami:",
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
					],
				},
			],
		},
	});
