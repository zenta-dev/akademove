import "@cloudflare/workers-types";

import { randomBytes } from "node:crypto";
import { readFile } from "node:fs/promises";
import { join } from "node:path";
import * as readline from "node:readline";
import { faker, fakerID_ID } from "@faker-js/faker";
import type { Phone, UserGender, UserRole } from "@repo/schema";
import type { InsertBadge } from "@repo/schema/badge";
import {
	CONSTANTS,
	type LEADERBOARD_CATEGORIES,
	type LEADERBOARD_PERIODS,
	type TRANSACTION_STATUS,
	type TRANSACTION_TYPE,
} from "@repo/schema/constants";
import type { InsertMerchant } from "@repo/schema/merchant";
import { eq, inArray, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { v7 } from "uuid";
import { S3StorageService } from "@/core/services/storage";
import { accountDeletion } from "@/core/tables/account-deletion";
import { broadcast } from "@/core/tables/broadcast";
import { orderChatMessage } from "@/core/tables/chat";
import {
	configuration,
	configurationAuditLog,
} from "@/core/tables/configuration";
import { contact } from "@/core/tables/contact";
import { coupon, couponUsage } from "@/core/tables/coupon";
import { driver, driverSchedule } from "@/core/tables/driver";
import { driverQuizAnswer } from "@/core/tables/driver-quiz-answer";
import { driverQuizQuestion } from "@/core/tables/driver-quiz-question";
import { emergency } from "@/core/tables/emergency";
import { leaderboard } from "@/core/tables/leaderboard";
import { merchant, merchantMenu } from "@/core/tables/merchant";
import { userNotification } from "@/core/tables/notification";
import { order, orderItem } from "@/core/tables/order";
import { payment } from "@/core/tables/payment";
import { report } from "@/core/tables/report";
import { review } from "@/core/tables/review";
import { transaction } from "@/core/tables/transaction";
import { PasswordManager } from "@/utils/password";
import { tables } from "./tables";

// Use Indonesian faker as primary
const id = fakerID_ID;

// Indonesian food/menu names
const INDONESIAN_FOOD_NAMES = [
	"Nasi Goreng Spesial",
	"Mie Ayam Bakso",
	"Soto Ayam",
	"Ayam Geprek",
	"Ayam Bakar Madu",
	"Nasi Padang",
	"Rendang Sapi",
	"Gado-Gado",
	"Sate Ayam",
	"Sate Kambing",
	"Bakso Urat",
	"Mie Goreng",
	"Nasi Uduk",
	"Nasi Kuning",
	"Pecel Lele",
	"Ikan Bakar",
	"Capcay",
	"Kwetiau Goreng",
	"Bihun Goreng",
	"Nasi Campur",
	"Rawon",
	"Tongseng",
	"Gulai Kambing",
	"Opor Ayam",
	"Ayam Penyet",
	"Es Teh Manis",
	"Es Jeruk",
	"Kopi Susu",
	"Teh Tarik",
	"Jus Alpukat",
	"Jus Mangga",
	"Es Campur",
	"Es Cendol",
	"Es Dawet",
	"Air Mineral",
];

const INDONESIAN_FOOD_CATEGORIES = [
	"Makanan Berat",
	"Makanan Ringan",
	"Minuman",
	"Snack",
	"Dessert",
	"Sarapan",
];

const _INDONESIAN_MERCHANT_NAMES = [
	"Warung Makan Sederhana",
	"Rumah Makan Padang Minang",
	"Warung Nasi Goreng Pak Kumis",
	"Kedai Kopi Kampus",
	"Kantin Mahasiswa Sejahtera",
	"Warung Bu Tini",
	"Mie Ayam Cak Kar",
	"Bakso Solo Pak Gimin",
	"Warung Sate Madura",
	"Depot Soto Lamongan",
	"Warung Pecel Bu Sri",
	"Kantin Fakultas Teknik",
	"Kedai Senja",
	"Warung Pojok",
	"Kopi Kenangan Kampus",
];

const _INDONESIAN_ATK_NAMES = [
	"Toko ATK Sejahtera",
	"Fotokopi & ATK Murah",
	"Toko Buku Kampus",
	"ATK Mahasiswa",
	"Stationery Corner",
];

const _INDONESIAN_PRINTING_NAMES = [
	"Printing Center Kampus",
	"Fotokopi 24 Jam",
	"Digital Printing Express",
	"Print & Copy Murah",
	"Percetakan Mahasiswa",
];

// Indonesian quiz questions for drivers
const INDONESIAN_QUIZ_QUESTIONS = [
	{
		question: "Apa yang harus dilakukan jika penumpang tidak memakai helm?",
		type: "MULTIPLE_CHOICE" as const,
		category: "SAFETY" as const,
		options: [
			{
				id: "a",
				text: "Tetap jalan saja",
				isCorrect: false,
			},
			{
				id: "b",
				text: "Minta penumpang memakai helm sebelum berangkat",
				isCorrect: true,
			},
			{
				id: "c",
				text: "Batalkan pesanan",
				isCorrect: false,
			},
			{
				id: "d",
				text: "Laporkan ke admin",
				isCorrect: false,
			},
		],
		explanation:
			"Keselamatan adalah prioritas utama. Pastikan penumpang memakai helm sebelum perjalanan dimulai.",
		points: 10,
	},
	{
		question:
			"Driver wajib memiliki SIM C yang masih berlaku untuk mengendarai motor.",
		type: "TRUE_FALSE" as const,
		category: "PLATFORM_RULES" as const,
		options: [
			{ id: "true", text: "Benar", isCorrect: true },
			{ id: "false", text: "Salah", isCorrect: false },
		],
		explanation:
			"Sesuai peraturan lalu lintas, setiap pengendara motor wajib memiliki SIM C yang masih berlaku.",
		points: 10,
	},
	{
		question: "Bagaimana cara berkomunikasi yang baik dengan penumpang?",
		type: "MULTIPLE_CHOICE" as const,
		category: "CUSTOMER_SERVICE" as const,
		options: [
			{ id: "a", text: "Diam saja selama perjalanan", isCorrect: false },
			{
				id: "b",
				text: "Berbicara sopan dan ramah, konfirmasi tujuan",
				isCorrect: true,
			},
			{ id: "c", text: "Berbicara keras dan cepat", isCorrect: false },
			{ id: "d", text: "Hanya fokus pada HP", isCorrect: false },
		],
		explanation:
			"Komunikasi yang baik dengan penumpang menciptakan pengalaman perjalanan yang nyaman.",
		points: 10,
	},
	{
		question:
			"Apa yang harus dilakukan saat terjadi kecelakaan selama perjalanan?",
		type: "MULTIPLE_CHOICE" as const,
		category: "EMERGENCY_PROCEDURES" as const,
		options: [
			{ id: "a", text: "Langsung kabur dari lokasi", isCorrect: false },
			{ id: "b", text: "Menunggu tanpa melakukan apapun", isCorrect: false },
			{
				id: "c",
				text: "Pastikan keselamatan, hubungi bantuan, dan laporkan ke platform",
				isCorrect: true,
			},
			{ id: "d", text: "Minta penumpang yang mengurus", isCorrect: false },
		],
		explanation:
			"Keselamatan adalah prioritas. Pastikan semua aman, hubungi bantuan darurat jika diperlukan, dan laporkan insiden ke platform.",
		points: 15,
	},
	{
		question:
			"Driver boleh membatalkan pesanan secara sepihak tanpa alasan yang jelas.",
		type: "TRUE_FALSE" as const,
		category: "PLATFORM_RULES" as const,
		options: [
			{ id: "true", text: "Benar", isCorrect: false },
			{ id: "false", text: "Salah", isCorrect: true },
		],
		explanation:
			"Pembatalan pesanan tanpa alasan yang jelas dapat mempengaruhi rating dan status akun driver.",
		points: 10,
	},
	{
		question: "Berapa jarak maksimal untuk pencarian driver dalam aplikasi?",
		type: "MULTIPLE_CHOICE" as const,
		category: "NAVIGATION" as const,
		options: [
			{ id: "a", text: "1 km", isCorrect: false },
			{ id: "b", text: "3 km", isCorrect: false },
			{ id: "c", text: "5 km", isCorrect: true },
			{ id: "d", text: "10 km", isCorrect: false },
		],
		explanation:
			"Radius pencarian driver standar adalah 5 km untuk memastikan waktu tunggu yang wajar.",
		points: 10,
	},
	{
		question:
			"Apa yang dimaksud dengan fitur 'Gender Preference' di AkadeMove?",
		type: "MULTIPLE_CHOICE" as const,
		category: "PLATFORM_RULES" as const,
		options: [
			{
				id: "a",
				text: "Fitur untuk memilih warna aplikasi",
				isCorrect: false,
			},
			{
				id: "b",
				text: "Fitur untuk penumpang memilih driver dengan jenis kelamin yang sama",
				isCorrect: true,
			},
			{ id: "c", text: "Fitur untuk mengubah profil", isCorrect: false },
			{ id: "d", text: "Fitur untuk memberikan rating", isCorrect: false },
		],
		explanation:
			"Gender Preference memungkinkan penumpang untuk memilih driver dengan jenis kelamin yang sama demi kenyamanan.",
		points: 10,
	},
	{
		question:
			"Kendaraan harus dalam kondisi baik dan layak jalan sebelum menerima orderan.",
		type: "TRUE_FALSE" as const,
		category: "VEHICLE_MAINTENANCE" as const,
		options: [
			{ id: "true", text: "Benar", isCorrect: true },
			{ id: "false", text: "Salah", isCorrect: false },
		],
		explanation:
			"Kendaraan yang terawat dengan baik menjamin keselamatan driver dan penumpang.",
		points: 10,
	},
	{
		question: "Bagaimana cara meningkatkan rating sebagai driver?",
		type: "MULTIPLE_CHOICE" as const,
		category: "CUSTOMER_SERVICE" as const,
		options: [
			{ id: "a", text: "Mengemudi dengan ugal-ugalan", isCorrect: false },
			{
				id: "b",
				text: "Bersikap ramah, tepat waktu, dan menjaga kebersihan kendaraan",
				isCorrect: true,
			},
			{ id: "c", text: "Sering membatalkan pesanan", isCorrect: false },
			{
				id: "d",
				text: "Meminta penumpang memberikan rating 5",
				isCorrect: false,
			},
		],
		explanation:
			"Rating yang baik didapat dari pelayanan yang konsisten, sikap ramah, dan profesionalisme.",
		points: 10,
	},
	{
		question:
			"Driver dapat mengaktifkan mode offline saat sedang ada jadwal kuliah.",
		type: "TRUE_FALSE" as const,
		category: "PLATFORM_RULES" as const,
		options: [
			{ id: "true", text: "Benar", isCorrect: true },
			{ id: "false", text: "Salah", isCorrect: false },
		],
		explanation:
			"AkadeMove memahami bahwa driver adalah mahasiswa. Fitur schedule memungkinkan driver mengatur waktu kerja sesuai jadwal kuliah.",
		points: 10,
	},
];

// Indonesian notification messages
const INDONESIAN_NOTIFICATIONS = [
	{
		title: "Pesanan Baru!",
		body: "Ada pesanan baru di sekitar Anda. Segera ambil pesanan!",
	},
	{
		title: "Promo Spesial",
		body: "Dapatkan diskon 20% untuk 3 perjalanan pertama hari ini!",
	},
	{
		title: "Rating Meningkat",
		body: "Selamat! Rating Anda naik menjadi 4.9. Pertahankan!",
	},
	{
		title: "Pembayaran Diterima",
		body: "Pembayaran sebesar Rp 25.000 telah berhasil diterima.",
	},
	{
		title: "Verifikasi Berhasil",
		body: "Akun Anda telah terverifikasi. Selamat bergabung!",
	},
	{
		title: "Pengingat Jadwal",
		body: "Anda memiliki jadwal offline dalam 30 menit.",
	},
	{
		title: "Badge Baru!",
		body: 'Selamat! Anda mendapatkan badge "Driver Bintang".',
	},
	{
		title: "Penarikan Berhasil",
		body: "Penarikan saldo Rp 500.000 sedang diproses.",
	},
];

// Indonesian broadcast messages
const INDONESIAN_BROADCASTS = [
	{
		title: "Pemeliharaan Sistem",
		message:
			"Sistem akan mengalami pemeliharaan pada tanggal 15 Januari 2024 pukul 02:00-04:00 WIB. Mohon maaf atas ketidaknyamanannya.",
	},
	{
		title: "Promo Akhir Tahun",
		message:
			"Nikmati diskon hingga 50% untuk semua layanan selama periode 25-31 Desember 2024!",
	},
	{
		title: "Update Aplikasi",
		message:
			"Versi terbaru aplikasi AkadeMove telah tersedia. Silakan update untuk pengalaman yang lebih baik.",
	},
	{
		title: "Kebijakan Baru",
		message:
			"Mulai 1 Februari 2024, semua driver wajib mengaktifkan verifikasi wajah sebelum memulai trip.",
	},
	{
		title: "Selamat Tahun Baru",
		message:
			"Tim AkadeMove mengucapkan Selamat Tahun Baru 2024! Semoga tahun ini penuh berkah.",
	},
];

// Indonesian contact subjects
const INDONESIAN_CONTACT_SUBJECTS = [
	"Kendala saat top up saldo",
	"Driver tidak datang",
	"Pesanan dibatalkan sepihak",
	"Aplikasi error saat pembayaran",
	"Permintaan pengembalian dana",
	"Keluhan tentang pelayanan driver",
	"Saran perbaikan aplikasi",
	"Pertanyaan tentang promo",
];

// Seeding options type
type SeedOptions = {
	mode: "all" | "base" | "custom";
	seeders: Set<string>;
};

// Parse command line arguments for non-interactive mode
// Usage: bun scripts/seed.ts --mode=all|base|custom [--seeders=1,2,3] [--yes]
function parseCliArgs(): {
	mode?: string;
	seeders?: string;
	skipConfirm: boolean;
} {
	const args = process.argv.slice(2);
	let mode: string | undefined;
	let seeders: string | undefined;
	let skipConfirm = false;

	for (const arg of args) {
		if (arg.startsWith("--mode=")) {
			mode = arg.split("=")[1];
		} else if (arg.startsWith("--seeders=")) {
			seeders = arg.split("=")[1];
		} else if (arg === "--yes" || arg === "-y") {
			skipConfirm = true;
		}
	}

	return { mode, seeders, skipConfirm };
}

async function promptSeedingOptions(): Promise<SeedOptions> {
	const cliArgs = parseCliArgs();

	// Non-interactive mode via CLI args
	if (cliArgs.mode) {
		if (cliArgs.mode === "all" || cliArgs.mode === "1") {
			console.log("📋 Mode: All (from CLI)");
			return { mode: "all", seeders: new Set() };
		}
		if (cliArgs.mode === "base" || cliArgs.mode === "2") {
			console.log("📋 Mode: Base (from CLI)");
			return {
				mode: "base",
				seeders: new Set(["users", "badges", "userBadges", "configurations"]),
			};
		}
		if (cliArgs.mode === "custom" || cliArgs.mode === "3") {
			const seederMap: Record<string, string> = {
				"1": "users",
				"2": "badges",
				"3": "userBadges",
				"4": "configurations",
				"5": "merchants",
				"6": "drivers",
				"7": "orders",
				"8": "merchantMenus",
				"9": "driverSchedules",
				"10": "driverQuizQuestions",
				"11": "driverQuizAnswers",
				"12": "coupons",
				"13": "transactions",
				"14": "payments",
				"15": "reviews",
				"16": "leaderboards",
				"17": "orderItems",
				"18": "couponUsages",
				"19": "orderChatMessages",
				"20": "emergencies",
				"21": "reports",
				"22": "broadcasts",
				"23": "contacts",
				"24": "userNotifications",
				"25": "accountDeletions",
			};
			const selectedSeeders = new Set(
				(cliArgs.seeders ?? "")
					.split(",")
					.map((s) => s.trim())
					.filter((s) => seederMap[s])
					.map((s) => seederMap[s]),
			);
			console.log(
				`📋 Mode: Custom (from CLI) - Seeders: ${[...selectedSeeders].join(", ")}`,
			);
			return { mode: "custom", seeders: selectedSeeders };
		}
	}

	// Interactive mode
	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout,
	});

	const question = (prompt: string): Promise<string> =>
		new Promise((resolve) => rl.question(prompt, resolve));

	console.log("\n📋 Seeding Options:");
	console.log(
		"1. All - Seed everything (users, badges, merchants, drivers, orders, etc.)",
	);
	console.log("2. Base - Seed only test users and badges");
	console.log("3. Custom - Pick specific seeders to run");

	const choice = await question("\nSelect option (1-3): ");

	if (choice === "1") {
		rl.close();
		return { mode: "all", seeders: new Set() };
	}

	if (choice === "2") {
		rl.close();
		return {
			mode: "base",
			seeders: new Set(["users", "badges", "userBadges", "configurations"]),
		};
	}

	if (choice === "3") {
		console.log("\n📦 Available seeders:");
		console.log("1. users - Test users and random users");
		console.log("2. badges - Badge definitions");
		console.log("3. userBadges - Assign badges to test users");
		console.log("4. configurations - System configurations");
		console.log("5. merchants - Merchant profiles");
		console.log("6. drivers - Driver profiles");
		console.log("7. orders - Sample orders");
		console.log("8. merchantMenus - Menu items for food merchants");
		console.log("9. driverSchedules - Driver availability schedules");
		console.log("10. driverQuizQuestions - Quiz bank for driver onboarding");
		console.log("11. driverQuizAnswers - Quiz attempt records");
		console.log("12. coupons - Discount codes");
		console.log("13. transactions - Financial transaction history");
		console.log("14. payments - Payment records");
		console.log("15. reviews - Ratings and reviews");
		console.log("16. leaderboards - Gamification rankings");
		console.log("17. orderItems - Order line items");
		console.log("18. couponUsages - Coupon redemption tracking");
		console.log("19. orderChatMessages - In-order communication");
		console.log("20. emergencies - Emergency incident records");
		console.log("21. reports - User report records");
		console.log("22. broadcasts - Announcement broadcasts");
		console.log("23. contacts - Support contact submissions");
		console.log("24. userNotifications - In-app notifications");
		console.log("25. accountDeletions - Account deletion requests");

		const selections = await question(
			"\nEnter seeder numbers separated by commas (e.g., 1,2,3): ",
		);

		const seederMap: Record<string, string> = {
			"1": "users",
			"2": "badges",
			"3": "userBadges",
			"4": "configurations",
			"5": "merchants",
			"6": "drivers",
			"7": "orders",
			"8": "merchantMenus",
			"9": "driverSchedules",
			"10": "driverQuizQuestions",
			"11": "driverQuizAnswers",
			"12": "coupons",
			"13": "transactions",
			"14": "payments",
			"15": "reviews",
			"16": "leaderboards",
			"17": "orderItems",
			"18": "couponUsages",
			"19": "orderChatMessages",
			"20": "emergencies",
			"21": "reports",
			"22": "broadcasts",
			"23": "contacts",
			"24": "userNotifications",
			"25": "accountDeletions",
		};

		const selectedSeeders = new Set(
			selections
				.split(",")
				.map((s) => s.trim())
				.filter((s) => seederMap[s])
				.map((s) => seederMap[s]),
		);

		rl.close();
		return { mode: "custom", seeders: selectedSeeders };
	}

	rl.close();
	console.log("❌ Invalid option selected.");
	process.exit(0);
}

async function confirmExecution() {
	if (process.env.NODE_ENV === "production") {
		console.error("❌ Seeding is blocked in production!");
		process.exit(1);
	}

	// Skip confirmation if --yes flag is provided
	const cliArgs = parseCliArgs();
	if (cliArgs.skipConfirm) {
		console.log("⚠️  Skipping confirmation (--yes flag provided)");
		return;
	}

	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout,
	});

	const confirmation = await new Promise<string>((resolve) =>
		rl.question(
			"\n⚠️  WARNING: This will insert seed data into your database.\n" +
				"Type 'SEED' to continue: ",
			resolve,
		),
	);

	rl.close();

	if (confirmation !== "SEED") {
		console.log("❌ Operation cancelled.");
		process.exit(0);
	}
}

console.log(`DB URL: ${process.env.DATABASE_URL}`);

const client = postgres(process.env.DATABASE_URL || "");
const db = drizzle({ client });

// Lazy-initialize storage only when needed (for badge seeding)
let _storage: S3StorageService | null = null;
function getStorage(): S3StorageService | null {
	if (_storage) return _storage;

	const endpoint = process.env.S3_ENDPOINT;
	const region = process.env.S3_REGION;
	const accessKeyId = process.env.S3_ACCESS_KEY_ID;
	const secretAccessKey = process.env.S3_SECRET_ACCESS_KEY;
	const publicUrl = process.env.S3_PUBLIC_URL;

	if (!endpoint || !region || !accessKeyId || !secretAccessKey || !publicUrl) {
		console.warn(
			"⚠️ S3 credentials not configured. Badge icons will not be uploaded.",
		);
		return null;
	}

	_storage = new S3StorageService({
		endpoint,
		region,
		accessKeyId,
		secretAccessKey,
		publicUrl,
	});
	return _storage;
}

function generateId(): string {
	return randomBytes(16).toString("hex");
}

type InsertUser = {
	name: string;
	email: string;
	role: UserRole;
	password: string;
	phone: Phone;
	gender?: UserGender;
};
async function seedUser(baseOnly = false) {
	const pw = new PasswordManager();

	const FIXED_USERS: InsertUser[] = [
		{
			name: "Test Admin 1",
			email: "test-admin-1@akademove.com",
			role: "ADMIN",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230851 },
		},
		{
			name: "Test Operator 1",
			email: "test-operator-1@akademove.com",
			role: "OPERATOR",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230852 },
		},
		{
			name: "Test Merchant 1",
			email: "test-merchant-1@akademove.com",
			role: "MERCHANT",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230853 },
		},
		{
			name: "Test Driver 1",
			email: "test-driver-1@akademove.com",
			role: "DRIVER",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230854 },
			gender: "MALE",
		},
		{
			name: "Test User 1",
			email: "test-user-1@akademove.com",
			role: "USER",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230855 },
			gender: "MALE",
		},
	] as const;

	const RANDOM_USERS = baseOnly
		? []
		: Array.from({ length: 500 }).map(
				() =>
					({
						name: faker.person.fullName(),
						email: faker.internet.email().toLowerCase(),
						role: faker.helpers.arrayElement(["USER", "DRIVER", "MERCHANT"]),
						password: "Ch@ngEThi5",
						phone: {
							countryCode: "ID",
							number: Number(
								faker.phone.number({ style: "human" }).replace(/\D/g, ""),
							),
						},
						gender: faker.helpers.arrayElement(["MALE", "FEMALE"]),
					}) as const,
			);

	const USERS = baseOnly
		? FIXED_USERS
		: [
				...new Map(
					[...FIXED_USERS, ...RANDOM_USERS].map((u) => [u.email, u]),
				).values(),
			];

	console.log("🔍 Checking existing users...");

	const existing = await db
		.select({ email: tables.user.email, phone: tables.user.phone })
		.from(tables.user)
		.where(
			inArray(
				tables.user.email,
				USERS.map((u) => u.email),
			),
		);

	const existingEmails = new Set(existing.map((u) => u.email));
	const existingPhones = new Set(existing.map((u) => JSON.stringify(u.phone)));

	const missingUsers = USERS.filter(
		(u) =>
			!existingEmails.has(u.email) &&
			!existingPhones.has(JSON.stringify(u.phone)),
	);

	if (missingUsers.length === 0) {
		console.log("✅ All users already exist.");
		return;
	}

	console.log(`🌱 Seeding ${missingUsers.length} new users...`);

	try {
		const hashedPassword = pw.hash("Ch@ngEThi5");

		// Batch insert users and accounts
		const userInsertData = missingUsers.map((user) => ({
			...user,
			id: generateId(),
		}));

		const insertedUsers = await db
			.insert(tables.user)
			.values(userInsertData)
			.returning({ id: tables.user.id });

		const accountInsertData = insertedUsers.map((user) => ({
			id: generateId(),
			accountId: generateId(),
			userId: user.id,
			providerId: "credentials",
			password: hashedPassword,
		}));
		const walletInsertData = insertedUsers.map((user) => ({
			id: v7(),
			userId: user.id,
			balance: "0",
		}));

		await Promise.all([
			db.insert(tables.account).values(accountInsertData),
			db.insert(tables.wallet).values(walletInsertData),
		]);

		console.log("✅ User seeding complete.");
	} catch (err) {
		console.error("❌ Failed to seed users:", err);
		throw err;
	}
}

export async function seedConfigurations() {
	console.log("🔧 Seeding Configurations...");

	// Use a transaction for consistency
	await db.transaction(async (tx) => {
		const [admin] = await tx
			.select()
			.from(tables.user)
			.where(eq(tables.user.email, "test-admin-1@akademove.com"))
			.limit(1);

		if (!admin) {
			console.warn("⚠️ Admin user not found. Skipping configurations.");
			return;
		}

		const now = new Date();

		const CONFIGS = [
			{
				key: "ride-service-pricing",
				name: "Ride Pricing",
				value: {
					baseFare: 5_000,
					perKmRate: 2_500,
					minimumFare: 10_000,
					platformFeeRate: 0.02,
					taxRate: 0.11,
				},
				description: "Ride service pricing structure",
				updatedById: admin.id,
				createdAt: now,
				updatedAt: now,
			},
			{
				key: "delivery-service-pricing",
				name: "Delivery Pricing",
				value: {
					baseFare: 8_000,
					perKmRate: 3_000,
					minimumFare: 12_000,
					perKg: 2_000,
					platformFeeRate: 0.02,
					taxRate: 0.11,
				},
				description: "Delivery pricing per km/kg",
				updatedById: admin.id,
				createdAt: now,
				updatedAt: now,
			},
			{
				key: "food-service-pricing",
				name: "Food Pricing",
				value: {
					baseFare: 8_000,
					perKmRate: 2_500,
					minimumFare: 10_000,
					platformFeeRate: 0.02,
					taxRate: 0.11,
					merchantCommissionRate: 0.1, // 10% merchant commission
				},
				description: "Food delivery pricing",
				updatedById: admin.id,
				createdAt: now,
				updatedAt: now,
			},
			{
				key: "business-configuration",
				name: "Business Configuration",
				value: {
					// Wallet limits (in IDR)
					minTransferAmount: 10_000,
					minWithdrawalAmount: 50_000,
					minTopUpAmount: 10_000,
					quickTopUpAmounts: [
						10_000, 25_000, 50_000, 100_000, 250_000, 500_000,
					],
					// Cancellation fees (as decimal, e.g., 0.1 = 10%)
					userCancellationFeeBeforeAccept: 0, // 0% before driver accepts
					userCancellationFeeAfterAccept: 0.1, // 10% after driver accepts
					noShowFee: 0.5, // 50% no-show penalty
					// Delivery verification
					highValueOrderThreshold: 100_000, // 100k IDR threshold for OTP
				},
				description:
					"Business configuration for wallet limits, cancellation fees, and delivery verification",
				updatedById: admin.id,
				createdAt: now,
				updatedAt: now,
			},
		];

		await tx
			.insert(configuration)
			.values(CONFIGS)
			.onConflictDoUpdate({
				target: configuration.key,
				set: {
					name: sql`excluded.name`,
					value: sql`excluded.value`,
					description: sql`excluded.description`,
					updatedById: sql`excluded.updated_by_id`,
					updatedAt: sql`excluded.updated_at`,
				},
			});

		const existingConfigs = await tx
			.select({
				key: configuration.key,
				value: configuration.value,
			})
			.from(configuration)
			.where(
				sql`${configuration.key} IN (${sql.join(
					CONFIGS.map((c) => sql`${c.key}`),
					sql`, `,
				)})`,
			);

		const existingMap = Object.fromEntries(
			existingConfigs.map((c) => [c.key, c.value]),
		);

		const auditLogs = CONFIGS.map((conf) => {
			const previousValue = existingMap[conf.key];
			const operation = previousValue ? "UPDATE" : "INSERT";
			return {
				tableName: "configurations",
				recordId: conf.key,
				operation,
				oldData: previousValue ?? null,
				newData: conf.value,
				updatedById: admin.id,
				updatedAt: now,
			} as const;
		});

		await tx.insert(configurationAuditLog).values(auditLogs);

		console.log("✅ Configurations seeded/updated successfully.");
	});
}

async function seedMerchants() {
	console.log("🏪 Seeding Merchants...");

	const users = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.role, "MERCHANT"));

	if (users.length === 0) {
		console.warn("⚠️ No users with role 'merchant' found.");
		return;
	}

	// Check existing merchants to avoid duplicates
	const existingMerchants = await db
		.select({ userId: merchant.userId })
		.from(merchant);

	const existingUserIds = new Set(existingMerchants.map((m) => m.userId));
	const availableUsers = users.filter((u) => !existingUserIds.has(u.id));

	if (availableUsers.length === 0) {
		console.log("✅ All merchant users already have merchants.");
		return;
	}

	const merchantsToCreate = Math.min(50, availableUsers.length);
	const merchants = Array.from({ length: merchantsToCreate }).map((_, i) => {
		const user = availableUsers[i];
		const bankProvider = faker.helpers.arrayElement(CONSTANTS.BANK_PROVIDERS);
		const category = faker.helpers.arrayElement(CONSTANTS.MERCHANT_CATEGORIES);

		return {
			id: v7(),
			userId: user.id,
			name: faker.company.name(),
			email: user.email,
			phone: user.phone ?? undefined,
			address: faker.location.streetAddress(),
			category,
			location: {
				y: faker.location.latitude(),
				x: faker.location.longitude(),
			},
			bank: {
				provider: bankProvider,
				number: faker.number.int({ min: 1_000_000, max: 9_999_999 }),
			},
		} satisfies InsertMerchant & { userId: string; id: string };
	});

	await db.insert(merchant).values(merchants);
	console.log(`✅ Inserted ${merchants.length} merchants.`);
}

const BASE_LAT = -6.2221877;
const BASE_LNG = 106.8724405;
const OFFSET_METERS = 5000;

function randomOffsetLatLng(
	baseLat: number,
	baseLng: number,
	radiusMeters: number,
) {
	const radiusDeg = radiusMeters / 111000;
	const u = Math.random();
	const v = Math.random();
	const w = radiusDeg * Math.sqrt(u);
	const t = 2 * Math.PI * v;
	const dy = w * Math.sin(t);
	const dx = w * Math.cos(t);
	const newLat = baseLat + dy;
	const newLng = baseLng + dx / Math.cos(baseLat * (Math.PI / 180));
	return { lat: newLat, lng: newLng };
}

async function seedDrivers() {
	console.log("🚗 Seeding Drivers near location...");

	const users = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.role, "DRIVER"));

	if (users.length === 0) {
		console.warn("⚠️ No users with role 'driver' found.");
		return;
	}

	// Check existing drivers to avoid duplicates (userId, studentId, licensePlate)
	const existingDrivers = await db
		.select({
			userId: driver.userId,
			studentId: driver.studentId,
			licensePlate: driver.licensePlate,
		})
		.from(driver);

	const existingUserIds = new Set(existingDrivers.map((d) => d.userId));
	const availableUsers = users.filter((u) => !existingUserIds.has(u.id));

	if (availableUsers.length === 0) {
		console.log("✅ All driver users already have driver profiles.");
		return;
	}

	// Pre-populate Sets with existing values from database to avoid unique constraint violations
	const usedStudentIds = new Set<number>(
		existingDrivers.map((d) => d.studentId),
	);
	const usedLicensePlates = new Set<string>(
		existingDrivers.map((d) => d.licensePlate),
	);

	const generateUniqueStudentId = (): number => {
		let id: number;
		do {
			id = faker.number.int({ min: 2_000_000, max: 9_999_999 });
		} while (usedStudentIds.has(id));
		usedStudentIds.add(id);
		return id;
	};

	const generateUniqueLicensePlate = (): string => {
		let plate: string;
		do {
			plate = faker.string.alphanumeric(8).toUpperCase();
		} while (usedLicensePlates.has(plate));
		usedLicensePlates.add(plate);
		return plate;
	};

	const drivers = availableUsers.map((user) => {
		const bankProvider = faker.helpers.arrayElement(CONSTANTS.BANK_PROVIDERS);
		const { lat, lng } = randomOffsetLatLng(BASE_LAT, BASE_LNG, OFFSET_METERS);

		return {
			id: v7(),
			userId: user.id,
			studentId: generateUniqueStudentId(),
			licensePlate: generateUniqueLicensePlate(),
			status: faker.helpers.arrayElement(CONSTANTS.DRIVER_STATUSES),
			rating: Number.parseFloat(
				faker.number.float({ min: 3.5, max: 5 }).toFixed(1),
			),
			isOnline: faker.datatype.boolean(),
			currentLocation: sql`ST_SetSRID(ST_MakePoint(${lng}, ${lat}), 4326)`,
			lastLocationUpdate: faker.date.recent({ days: 10 }),
			bank: {
				provider: bankProvider,
				number: faker.number.int({ min: 1_000_000, max: 9_999_999 }),
			},
			studentCard: "DL-0199ef0c-7758-7508-b906-4a706df54709.jpg",
			driverLicense: "DL-0199ef0c-7758-7508-b906-4a706df54709.jpg",
			vehicleCertificate: "DL-0199ef0c-7758-7508-b906-4a706df54709.jpg",
			createdAt: new Date(),
			updatedAt: new Date(),
		};
	});

	// Insert drivers in smaller batches to handle potential conflicts
	const BATCH_SIZE = 10;
	let insertedCount = 0;

	for (let i = 0; i < drivers.length; i += BATCH_SIZE) {
		const batch = drivers.slice(i, i + BATCH_SIZE);
		try {
			await db.insert(driver).values(batch);
			insertedCount += batch.length;
		} catch (_error) {
			// If batch fails, try inserting one by one
			for (const d of batch) {
				try {
					await db.insert(driver).values(d);
					insertedCount += 1;
				} catch {
					console.warn(
						`⚠️ Skipped driver for user ${d.userId} (duplicate constraint)`,
					);
				}
			}
		}
	}

	console.log(
		`✅ Inserted ${insertedCount} drivers near (${BASE_LAT}, ${BASE_LNG}).`,
	);
}

async function seedOrders() {
	console.log("📦 Seeding Orders...");

	const users = await db
		.select({ id: tables.user.id })
		.from(tables.user)
		.where(eq(tables.user.role, "USER"));

	const drivers = await db.select({ id: driver.id }).from(driver);
	const merchants = await db.select({ id: merchant.id }).from(merchant);

	if (!users.length) {
		console.warn("⚠️ No user accounts found.");
		return;
	}

	const maybePick = <T extends { id: string }>(arr: T[]) =>
		arr.length > 0 && faker.datatype.boolean()
			? faker.helpers.arrayElement(arr).id
			: null;

	const orders = Array.from({ length: 50 }).map(() => {
		const u = faker.helpers.arrayElement(users);
		const distanceKm = Number(
			faker.number.float({ min: 1, max: 50 }).toFixed(2),
		);
		const baseFare = faker.number.int({
			min: 5000,
			max: 15000,
			multipleOf: 500,
		});
		const perKmRate = faker.number.int({
			min: 2000,
			max: 5000,
			multipleOf: 100,
		});
		const totalPrice = baseFare + Math.round(distanceKm * perKmRate);

		const pickup = {
			x: Number(faker.location.longitude({ min: 106.7, max: 106.9 })),
			y: Number(faker.location.latitude({ min: -6.3, max: -6.1 })),
		};
		const dropoff = {
			x: Number(faker.location.longitude({ min: 106.7, max: 106.9 })),
			y: Number(faker.location.latitude({ min: -6.3, max: -6.1 })),
		};

		return {
			id: v7(),
			userId: u.id,
			driverId: maybePick(drivers),
			merchantId: maybePick(merchants),
			type: faker.helpers.arrayElement(CONSTANTS.ORDER_TYPES),
			status: faker.helpers.arrayElement(CONSTANTS.ORDER_STATUSES),
			pickupLocation: sql`ST_SetSRID(ST_MakePoint(${pickup.x}, ${pickup.y}), 4326)`,
			dropoffLocation: sql`ST_SetSRID(ST_MakePoint(${dropoff.x}, ${dropoff.y}), 4326)`,
			distanceKm,
			basePrice: `${baseFare}`,
			totalPrice: `${totalPrice}`,
			createdAt: faker.date.recent({ days: 30 }),
		};
	});

	await db.insert(order).values(orders);
	console.log(`✅ Inserted ${orders.length} orders.`);
}

async function seedBadges() {
	type Insert = Omit<InsertBadge, "icon"> & {
		iconPath: string;
	};
	const DEFAULT_BADGES: Insert[] = [
		// ==========================================
		// USER BADGES (Passengers)
		// ==========================================
		{
			code: "NEW_CUSTOMER",
			name: "New Customer",
			description: "Welcome to the akademove community!",
			type: "ACHIEVEMENT",
			level: "BRONZE",
			targetRole: "USER",
			criteria: {
				minOrders: 0,
			},
			isActive: true,
			displayOrder: 100,
			iconPath: "assets/New-Customer.png",
		},
		{
			code: "FIRST_RIDE",
			name: "First Ride",
			description: "Complete your first ride successfully",
			type: "ACHIEVEMENT",
			level: "BRONZE",
			targetRole: "USER",
			criteria: {
				minOrders: 1,
			},
			isActive: true,
			displayOrder: 1,
			iconPath: "assets/First-Ride.png",
		},
		{
			code: "FREQUENT_RIDER",
			name: "Frequent Rider",
			description: "Complete 50 rides",
			type: "MILESTONE",
			level: "SILVER",
			targetRole: "USER",
			criteria: {
				minOrders: 50,
			},
			isActive: true,
			displayOrder: 10,
			iconPath: "assets/Frequent-Rider.png",
		},
		{
			code: "SUPER_RIDER",
			name: "Super Rider",
			description: "Complete 100 rides",
			type: "MILESTONE",
			level: "GOLD",
			targetRole: "USER",
			criteria: {
				minOrders: 100,
			},
			isActive: true,
			displayOrder: 11,
			iconPath: "assets/Super-Rider.png",
		},
		{
			code: "ELITE_RIDER",
			name: "Elite Rider",
			description: "Complete 500 rides",
			type: "MILESTONE",
			level: "PLATINUM",
			targetRole: "USER",
			criteria: {
				minOrders: 500,
			},
			isActive: true,
			displayOrder: 12,
			iconPath: "assets/Elite-Rider.png",
		},

		// ==========================================
		// DRIVER BADGES
		// ==========================================
		{
			code: "NEW_DRIVER",
			name: "New Driver",
			description: "Welcome to the driver community!",
			type: "ACHIEVEMENT",
			level: "BRONZE",
			targetRole: "DRIVER",
			criteria: {
				minOrders: 0,
			},
			isActive: true,
			displayOrder: 100,
			iconPath: "assets/New-Driver.png",
		},
		{
			code: "FIRST_TRIP",
			name: "First Trip",
			description: "Complete your first trip as a driver",
			type: "ACHIEVEMENT",
			level: "BRONZE",
			targetRole: "DRIVER",
			criteria: {
				minOrders: 1,
			},
			isActive: true,
			displayOrder: 101,
			iconPath: "assets/First-Trip.png",
		},
		{
			code: "RELIABLE_DRIVER",
			name: "Reliable Driver",
			description: "Maintain 4.5+ rating with 50 completed rides",
			type: "PERFORMANCE",
			level: "SILVER",
			targetRole: "DRIVER",
			criteria: {
				minOrders: 50,
				minRating: 4.5,
			},
			benefits: {
				priorityBoost: 10,
			},
			isActive: true,
			displayOrder: 110,
			iconPath: "assets/Reliable-Driver.png",
		},
		{
			code: "STAR_DRIVER",
			name: "Star Driver",
			description: "Maintain 4.8+ rating with 100 completed rides",
			type: "PERFORMANCE",
			level: "GOLD",
			targetRole: "DRIVER",
			criteria: {
				minOrders: 100,
				minRating: 4.8,
			},
			benefits: {
				priorityBoost: 20,
				commissionReduction: 0.05,
			},
			isActive: true,
			displayOrder: 111,
			iconPath: "assets/Star-Driver.png",
		},
		{
			code: "ELITE_DRIVER",
			name: "Elite Driver",
			description: "Maintain 4.9+ rating with 500 completed rides",
			type: "PERFORMANCE",
			level: "PLATINUM",
			targetRole: "DRIVER",
			criteria: {
				minOrders: 500,
				minRating: 4.9,
			},
			benefits: {
				priorityBoost: 30,
				commissionReduction: 0.1,
			},
			isActive: true,
			displayOrder: 112,
			iconPath: "assets/Elite-Driver.png",
		},
		{
			code: "CENTURION",
			name: "Centurion",
			description: "Complete 100 rides",
			type: "MILESTONE",
			level: "GOLD",
			targetRole: "DRIVER",
			criteria: {
				minOrders: 100,
			},
			benefits: {
				priorityBoost: 15,
			},
			isActive: true,
			displayOrder: 120,
			iconPath: "assets/Centurion.png",
		},

		// ==========================================
		// MERCHANT BADGES
		// ==========================================
		{
			code: "NEW_MERCHANT",
			name: "New Merchant",
			description: "Welcome to the merchant community!",
			type: "ACHIEVEMENT",
			level: "BRONZE",
			targetRole: "MERCHANT",
			criteria: {
				minOrders: 0,
			},
			isActive: true,
			displayOrder: 200,
			iconPath: "assets/New-Merchant.png",
		},
		{
			code: "FIRST_ORDER",
			name: "First Order",
			description: "Receive your first order",
			type: "ACHIEVEMENT",
			level: "BRONZE",
			targetRole: "MERCHANT",
			criteria: {
				minOrders: 1,
			},
			isActive: true,
			displayOrder: 201,
			iconPath: "assets/First-Order.png",
		},
		{
			code: "POPULAR_MERCHANT",
			name: "Popular Merchant",
			description: "Complete 50 orders with 4.5+ rating",
			type: "PERFORMANCE",
			level: "SILVER",
			targetRole: "MERCHANT",
			criteria: {
				minOrders: 50,
				minRating: 4.5,
			},
			benefits: {
				priorityBoost: 10,
			},
			isActive: true,
			displayOrder: 210,
			iconPath: "assets/Popular-Merchant.png",
		},
		{
			code: "TOP_RATED_MERCHANT",
			name: "Top Rated Merchant",
			description: "Maintain 4.8+ rating with 100 orders",
			type: "PERFORMANCE",
			level: "GOLD",
			targetRole: "MERCHANT",
			criteria: {
				minOrders: 100,
				minRating: 4.8,
			},
			benefits: {
				priorityBoost: 20,
				commissionReduction: 0.05,
			},
			isActive: true,
			displayOrder: 211,
			iconPath: "assets/Top-Rated-Merchant.png",
		},
	];
	// Use the script's directory to resolve asset paths (works regardless of cwd)
	const scriptDir = import.meta.dirname ?? process.cwd();
	const serverDir = join(scriptDir, "..");

	console.log("🎖️ Seeding Badges...");

	// Insert badge records into the database
	await db
		.insert(tables.badge)
		.values(
			DEFAULT_BADGES.map((e) => ({ ...e, id: v7(), icon: `${e.code}.png` })),
		)
		.onConflictDoNothing();

	// Upload badge icons to S3 (if storage is configured)
	const storage = getStorage();
	if (storage) {
		await Promise.all(
			DEFAULT_BADGES.map(async (badge) => {
				const filePath = join(serverDir, badge.iconPath);
				const buff = await readFile(filePath);
				const fileName = `${badge.code}.png`;

				const file = new File([buff], fileName, {
					type: "image/png",
					lastModified: Date.now(),
				});

				return storage.upload({
					bucket: "badges",
					key: fileName,
					file,
				});
			}),
		);
		console.log("✅ Badge icons uploaded to S3.");
	}

	console.log("✅ Badges seeded successfully.");
}

async function seedUserBadges() {
	console.log("🏅 Seeding User Badges...");

	const [
		testUser,
		testDriver,
		testMerchant,
		newCustomerBadge,
		newDriverBadge,
		newMerchantBadge,
	] = await Promise.all([
		db
			.select()
			.from(tables.user)
			.where(eq(tables.user.email, "test-user-1@akademove.com"))
			.then(([r]) => r),
		db
			.select()
			.from(tables.user)
			.where(eq(tables.user.email, "test-driver-1@akademove.com"))
			.then(([r]) => r),
		db
			.select()
			.from(tables.user)
			.where(eq(tables.user.email, "test-merchant-1@akademove.com"))
			.then(([r]) => r),
		db
			.select()
			.from(tables.badge)
			.where(eq(tables.badge.code, "NEW_CUSTOMER"))
			.then(([r]) => r),
		db
			.select()
			.from(tables.badge)
			.where(eq(tables.badge.code, "NEW_DRIVER"))
			.then(([r]) => r),
		db
			.select()
			.from(tables.badge)
			.where(eq(tables.badge.code, "NEW_MERCHANT"))
			.then(([r]) => r),
	]);

	if (
		!testUser ||
		!testDriver ||
		!testMerchant ||
		!newCustomerBadge ||
		!newDriverBadge ||
		!newMerchantBadge
	) {
		console.warn(
			"⚠️ Required test users or badges not found. Skipping user badges.",
		);
		return;
	}

	const values = [
		{
			id: v7(),
			userId: testUser.id,
			badgeId: newCustomerBadge.id,
		},
		{
			id: v7(),
			userId: testDriver.id,
			badgeId: newDriverBadge.id,
		},
		{
			id: v7(),
			userId: testMerchant.id,
			badgeId: newMerchantBadge.id,
		},
	];

	await db.insert(tables.userBadge).values(values).onConflictDoNothing();
	console.log("✅ User badges assigned successfully.");
}

// ==========================================
// NEW SEEDERS - Indonesian Data Priority
// ==========================================

async function seedMerchantMenus() {
	console.log("🍜 Seeding Merchant Menus...");

	const merchants = await db
		.select({ id: merchant.id, category: merchant.category })
		.from(merchant);

	if (merchants.length === 0) {
		console.warn("⚠️ No merchants found. Skipping merchant menus.");
		return;
	}

	// Check existing menus
	const existingMenus = await db
		.select({ merchantId: merchantMenu.merchantId })
		.from(merchantMenu);
	const merchantsWithMenus = new Set(existingMenus.map((m) => m.merchantId));

	const merchantsToSeed = merchants.filter(
		(m) => !merchantsWithMenus.has(m.id),
	);

	if (merchantsToSeed.length === 0) {
		console.log("✅ All merchants already have menus.");
		return;
	}

	const menus: Array<{
		id: string;
		merchantId: string;
		name: string;
		category: string;
		price: string;
		stock: number;
	}> = [];

	for (const m of merchantsToSeed) {
		// Only Food category merchants get food menus
		if (m.category === "Food") {
			const menuCount = faker.number.int({ min: 5, max: 15 });
			for (let i = 0; i < menuCount; i++) {
				menus.push({
					id: v7(),
					merchantId: m.id,
					name: faker.helpers.arrayElement(INDONESIAN_FOOD_NAMES),
					category: faker.helpers.arrayElement(INDONESIAN_FOOD_CATEGORIES),
					price: faker.number
						.int({ min: 5000, max: 50000, multipleOf: 1000 })
						.toString(),
					stock: faker.number.int({ min: 10, max: 100 }),
				});
			}
		}
	}

	if (menus.length === 0) {
		console.log("⚠️ No Food merchants found. Skipping menus.");
		return;
	}

	await db.insert(merchantMenu).values(menus);
	console.log(`✅ Inserted ${menus.length} merchant menu items.`);
}

async function seedDriverSchedules() {
	console.log("📅 Seeding Driver Schedules...");

	const drivers = await db.select({ id: driver.id }).from(driver);

	if (drivers.length === 0) {
		console.warn("⚠️ No drivers found. Skipping schedules.");
		return;
	}

	// Check existing schedules
	const existingSchedules = await db
		.select({ driverId: driverSchedule.driverId })
		.from(driverSchedule);
	const driversWithSchedules = new Set(
		existingSchedules.map((s) => s.driverId),
	);

	const driversToSeed = drivers.filter((d) => !driversWithSchedules.has(d.id));

	if (driversToSeed.length === 0) {
		console.log("✅ All drivers already have schedules.");
		return;
	}

	const schedules: Array<{
		id: string;
		name: string;
		driverId: string;
		dayOfWeek: (typeof CONSTANTS.DAY_OF_WEEK)[number];
		startTime: { h: number; m: number };
		endTime: { h: number; m: number };
		isRecurring: boolean;
		isActive: boolean;
	}> = [];

	const scheduleNames = [
		"Kuliah Pagi",
		"Kuliah Siang",
		"Praktikum",
		"UTS",
		"UAS",
		"Kerja Kelompok",
		"Organisasi Kampus",
	];

	for (const d of driversToSeed) {
		// Add 2-4 schedules per driver (class times)
		const scheduleCount = faker.number.int({ min: 2, max: 4 });
		const usedDays = new Set<string>();

		for (let i = 0; i < scheduleCount; i++) {
			let dayOfWeek: (typeof CONSTANTS.DAY_OF_WEEK)[number];
			do {
				dayOfWeek = faker.helpers.arrayElement(CONSTANTS.DAY_OF_WEEK);
			} while (usedDays.has(dayOfWeek));
			usedDays.add(dayOfWeek);

			const startHour = faker.number.int({ min: 7, max: 16 });
			const durationHours = faker.number.int({ min: 2, max: 4 });

			schedules.push({
				id: v7(),
				name: faker.helpers.arrayElement(scheduleNames),
				driverId: d.id,
				dayOfWeek,
				startTime: { h: startHour, m: 0 },
				endTime: { h: Math.min(startHour + durationHours, 21), m: 0 },
				isRecurring: true,
				isActive: true,
			});
		}
	}

	await db.insert(driverSchedule).values(schedules);
	console.log(`✅ Inserted ${schedules.length} driver schedules.`);
}

async function seedDriverQuizQuestions() {
	console.log("❓ Seeding Driver Quiz Questions...");

	// Check existing questions
	const existing = await db
		.select({ id: driverQuizQuestion.id })
		.from(driverQuizQuestion);

	if (existing.length > 0) {
		console.log("✅ Quiz questions already exist.");
		return;
	}

	const questions = INDONESIAN_QUIZ_QUESTIONS.map((q, idx) => ({
		id: v7(),
		...q,
		isActive: true,
		displayOrder: idx + 1,
	}));

	await db.insert(driverQuizQuestion).values(questions);
	console.log(`✅ Inserted ${questions.length} quiz questions.`);
}

async function seedDriverQuizAnswers() {
	console.log("📝 Seeding Driver Quiz Answers...");

	const drivers = await db
		.select({ id: driver.id, quizStatus: driver.quizStatus })
		.from(driver);

	if (drivers.length === 0) {
		console.warn("⚠️ No drivers found. Skipping quiz answers.");
		return;
	}

	// Check existing answers
	const existingAnswers = await db
		.select({ driverId: driverQuizAnswer.driverId })
		.from(driverQuizAnswer);
	const driversWithAnswers = new Set(existingAnswers.map((a) => a.driverId));

	const driversToSeed = drivers
		.filter((d) => !driversWithAnswers.has(d.id))
		.slice(0, 30); // Only seed for 30 drivers

	if (driversToSeed.length === 0) {
		console.log("✅ Drivers already have quiz answers.");
		return;
	}

	const questions = await db.select().from(driverQuizQuestion);
	if (questions.length === 0) {
		console.warn("⚠️ No quiz questions found. Skipping answers.");
		return;
	}

	const answers: Array<{
		id: string;
		driverId: string;
		status: "IN_PROGRESS" | "COMPLETED" | "PASSED" | "FAILED";
		totalQuestions: number;
		correctAnswers: number;
		totalPoints: number;
		earnedPoints: number;
		passingScore: number;
		scorePercentage: number;
		answers: Array<{
			questionId: string;
			selectedOptionId: string;
			isCorrect: boolean;
			pointsEarned: number;
			answeredAt: Date;
		}>;
		startedAt: Date;
		completedAt: Date | null;
	}> = [];

	for (const d of driversToSeed) {
		const isPassed = faker.datatype.boolean({ probability: 0.7 });
		const correctCount = isPassed
			? faker.number.int({ min: 7, max: 10 })
			: faker.number.int({ min: 3, max: 6 });

		const totalPoints = questions.reduce((sum, q) => sum + q.points, 0);
		const earnedPoints = Math.round((correctCount / 10) * totalPoints);
		const scorePercentage = Math.round((correctCount / 10) * 100);

		const answerTime = new Date();
		const answerDetails = questions.map((q, idx) => {
			const isCorrect = idx < correctCount;
			const correctOption = q.options.find((o) => o.isCorrect);
			const wrongOptions = q.options.filter((o) => !o.isCorrect);
			return {
				questionId: q.id,
				selectedOptionId: isCorrect
					? (correctOption?.id ?? "")
					: (faker.helpers.arrayElement(wrongOptions)?.id ?? ""),
				isCorrect,
				pointsEarned: isCorrect ? q.points : 0,
				answeredAt: new Date(answerTime.getTime() + idx * 60000), // 1 minute per question
			};
		});

		const startedAt = faker.date.recent({ days: 30 });
		answers.push({
			id: v7(),
			driverId: d.id,
			status: isPassed ? "PASSED" : "FAILED",
			totalQuestions: 10,
			correctAnswers: correctCount,
			totalPoints,
			earnedPoints,
			passingScore: 70,
			scorePercentage,
			answers: answerDetails,
			startedAt,
			completedAt: new Date(startedAt.getTime() + 1000 * 60 * 15), // 15 min later
		});
	}

	await db.insert(driverQuizAnswer).values(answers);
	console.log(`✅ Inserted ${answers.length} quiz answer records.`);
}

async function seedCoupons() {
	console.log("🎫 Seeding Coupons...");

	// Check existing coupons
	const existing = await db.select({ code: coupon.code }).from(coupon);

	if (existing.length > 0) {
		console.log("✅ Coupons already exist.");
		return;
	}

	const [admin] = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.email, "test-admin-1@akademove.com"))
		.limit(1);

	if (!admin) {
		console.warn("⚠️ Admin user not found. Skipping coupons.");
		return;
	}

	const now = new Date();
	const coupons = [
		{
			id: v7(),
			name: "Promo Mahasiswa Baru",
			code: "MAHASISWABARU",
			couponType: "FIRST_ORDER" as const,
			rules: { general: { minOrderAmount: 10000, maxDiscountAmount: 15000 } },
			discountPercentage: 50,
			usageLimit: 1000,
			usedCount: 0,
			periodStart: now,
			periodEnd: new Date(now.getTime() + 90 * 24 * 60 * 60 * 1000),
			isActive: true,
			createdById: admin.id,
		},
		{
			id: v7(),
			name: "Diskon Akhir Tahun",
			code: "AKHIRTAHUN2024",
			couponType: "EVENT" as const,
			rules: { general: { minOrderAmount: 20000, maxDiscountAmount: 25000 } },
			discountPercentage: 30,
			usageLimit: 500,
			usedCount: 0,
			periodStart: now,
			periodEnd: new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000),
			isActive: true,
			eventName: "Promo Akhir Tahun",
			eventDescription: "Diskon spesial menyambut tahun baru",
			createdById: admin.id,
		},
		{
			id: v7(),
			name: "Gratis Ongkir",
			code: "GRATISONGKIR",
			couponType: "GENERAL" as const,
			rules: { general: { minOrderAmount: 15000, maxDiscountAmount: 10000 } },
			discountAmount: "10000",
			usageLimit: 2000,
			usedCount: 0,
			periodStart: now,
			periodEnd: new Date(now.getTime() + 60 * 24 * 60 * 60 * 1000),
			isActive: true,
			createdById: admin.id,
		},
		{
			id: v7(),
			name: "Diskon Weekend",
			code: "WEEKENDHEMAT",
			couponType: "GENERAL" as const,
			rules: {
				general: { minOrderAmount: 25000, maxDiscountAmount: 20000 },
				time: {
					allowedDays: ["SATURDAY", "SUNDAY"] as (
						| "SUNDAY"
						| "MONDAY"
						| "TUESDAY"
						| "WEDNESDAY"
						| "THURSDAY"
						| "FRIDAY"
						| "SATURDAY"
					)[],
				},
			},
			discountPercentage: 25,
			usageLimit: 1500,
			usedCount: 0,
			periodStart: now,
			periodEnd: new Date(now.getTime() + 45 * 24 * 60 * 60 * 1000),
			isActive: true,
			createdById: admin.id,
		},
		{
			id: v7(),
			name: "Promo Ramadhan",
			code: "RAMADHAN2024",
			couponType: "EVENT" as const,
			rules: { general: { minOrderAmount: 30000, maxDiscountAmount: 35000 } },
			discountPercentage: 40,
			usageLimit: 3000,
			usedCount: 0,
			periodStart: now,
			periodEnd: new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000),
			isActive: false, // Not active yet
			eventName: "Promo Ramadhan",
			eventDescription: "Diskon spesial bulan Ramadhan",
			createdById: admin.id,
		},
	];

	await db.insert(coupon).values(coupons);
	console.log(`✅ Inserted ${coupons.length} coupons.`);
}

async function seedTransactions() {
	console.log("💰 Seeding Transactions...");

	const wallets = await db
		.select({ id: tables.wallet.id, userId: tables.wallet.userId })
		.from(tables.wallet);

	if (wallets.length === 0) {
		console.warn("⚠️ No wallets found. Skipping transactions.");
		return;
	}

	// Check existing transactions
	const existingTxns = await db
		.select({ walletId: transaction.walletId })
		.from(transaction);

	if (existingTxns.length > 0) {
		console.log("✅ Transactions already exist.");
		return;
	}

	const transactions: Array<{
		id: string;
		walletId: string;
		type: (typeof TRANSACTION_TYPE)[number];
		amount: string;
		balanceBefore: string;
		balanceAfter: string;
		status: (typeof TRANSACTION_STATUS)[number];
		description: string;
		referenceId: string;
	}> = [];

	// Create transactions for first 50 wallets
	const walletsToSeed = wallets.slice(0, 50);

	for (const w of walletsToSeed) {
		let balance = 0;

		// Create 3-5 transactions per wallet
		const txCount = faker.number.int({ min: 3, max: 5 });

		for (let i = 0; i < txCount; i++) {
			const type = faker.helpers.arrayElement([
				"TOPUP",
				"PAYMENT",
				"EARNING",
			] as const);
			const amount =
				type === "TOPUP"
					? faker.number.int({ min: 50000, max: 500000, multipleOf: 10000 })
					: type === "PAYMENT"
						? faker.number.int({ min: 10000, max: 50000, multipleOf: 1000 })
						: faker.number.int({ min: 15000, max: 100000, multipleOf: 1000 });

			const balanceBefore = balance;
			const balanceAfter =
				type === "PAYMENT" ? balance - amount : balance + amount;
			balance = balanceAfter;

			transactions.push({
				id: v7(),
				walletId: w.id,
				type,
				amount: amount.toString(),
				balanceBefore: balanceBefore.toString(),
				balanceAfter: balanceAfter.toString(),
				status: "SUCCESS",
				description:
					type === "TOPUP"
						? "Top up saldo via QRIS"
						: type === "PAYMENT"
							? "Pembayaran perjalanan"
							: "Pendapatan dari orderan",
				referenceId: v7(),
			});
		}
	}

	await db.insert(transaction).values(transactions);
	console.log(`✅ Inserted ${transactions.length} transactions.`);
}

async function seedPayments() {
	console.log("💳 Seeding Payments...");

	const txns = await db
		.select({ id: transaction.id, type: transaction.type })
		.from(transaction)
		.where(eq(transaction.type, "TOPUP"));

	if (txns.length === 0) {
		console.warn("⚠️ No TOPUP transactions found. Skipping payments.");
		return;
	}

	// Check existing payments
	const existingPayments = await db
		.select({ transactionId: payment.transactionId })
		.from(payment);

	if (existingPayments.length > 0) {
		console.log("✅ Payments already exist.");
		return;
	}

	const payments = txns.map((t) => {
		const method = faker.helpers.arrayElement([
			"QRIS",
			"BANK_TRANSFER",
		] as const);
		const bankProvider =
			method === "BANK_TRANSFER"
				? faker.helpers.arrayElement(CONSTANTS.BANK_PROVIDERS)
				: null;

		return {
			id: v7(),
			transactionId: t.id,
			provider: "MIDTRANS" as const,
			method,
			bankProvider,
			amount: faker.number
				.int({ min: 50000, max: 500000, multipleOf: 10000 })
				.toString(),
			status: "SUCCESS" as const,
			externalId: `MID-${v7().slice(0, 8).toUpperCase()}`,
		};
	});

	await db.insert(payment).values(payments);
	console.log(`✅ Inserted ${payments.length} payments.`);
}

async function seedReviews() {
	console.log("⭐ Seeding Reviews...");

	const completedOrders = await db
		.select({
			id: order.id,
			userId: order.userId,
			driverId: order.driverId,
		})
		.from(order)
		.where(eq(order.status, "COMPLETED"));

	if (completedOrders.length === 0) {
		console.warn("⚠️ No completed orders found. Skipping reviews.");
		return;
	}

	// Check existing reviews
	const existingReviews = await db
		.select({ orderId: review.orderId })
		.from(review);
	const ordersWithReviews = new Set(existingReviews.map((r) => r.orderId));

	const ordersToSeed = completedOrders
		.filter((o) => !ordersWithReviews.has(o.id) && o.driverId !== null)
		.slice(0, 30);

	if (ordersToSeed.length === 0) {
		console.log("✅ Reviews already exist or no eligible orders.");
		return;
	}

	// Get drivers' user IDs
	const driverIds = [
		...new Set(ordersToSeed.map((o) => o.driverId).filter(Boolean)),
	] as string[];
	const driverUsers = await db
		.select({ id: driver.id, userId: driver.userId })
		.from(driver)
		.where(inArray(driver.id, driverIds));
	const driverUserMap = new Map(driverUsers.map((d) => [d.id, d.userId]));

	const reviews: Array<{
		id: string;
		orderId: string;
		fromUserId: string;
		toUserId: string;
		category: (typeof CONSTANTS.REVIEW_CATEGORIES)[number];
		score: number;
		comment: string;
	}> = [];

	const positiveComments = [
		"Driver sangat ramah dan sopan. Terima kasih!",
		"Perjalanan nyaman dan aman. Recommended!",
		"Tepat waktu dan komunikatif. Mantap!",
		"Kendaraan bersih dan terawat. Good job!",
		"Pelayanan sangat baik. Pasti order lagi!",
	];

	const neutralComments = [
		"Cukup baik, perjalanan lancar.",
		"Standar, tidak ada masalah.",
		"Oke lah, sampai tujuan dengan selamat.",
	];

	for (const o of ordersToSeed) {
		const driverUserId = driverUserMap.get(o.driverId ?? "");
		if (!driverUserId) continue;

		const score = faker.number.int({ min: 3, max: 5 });
		reviews.push({
			id: v7(),
			orderId: o.id,
			fromUserId: o.userId,
			toUserId: driverUserId,
			category: faker.helpers.arrayElement(CONSTANTS.REVIEW_CATEGORIES),
			score,
			comment:
				score >= 4
					? faker.helpers.arrayElement(positiveComments)
					: faker.helpers.arrayElement(neutralComments),
		});
	}

	if (reviews.length > 0) {
		await db.insert(review).values(reviews);
	}
	console.log(`✅ Inserted ${reviews.length} reviews.`);
}

async function seedLeaderboards() {
	console.log("🏆 Seeding Leaderboards...");

	// Check existing leaderboards
	const existing = await db.select({ id: leaderboard.id }).from(leaderboard);

	if (existing.length > 0) {
		console.log("✅ Leaderboards already exist.");
		return;
	}

	const drivers = await db
		.select({ id: driver.id, userId: driver.userId, rating: driver.rating })
		.from(driver)
		.limit(20);

	if (drivers.length === 0) {
		console.warn("⚠️ No drivers found. Skipping leaderboards.");
		return;
	}

	const now = new Date();
	const periodStart = new Date(now.getFullYear(), now.getMonth(), 1);
	const periodEnd = new Date(now.getFullYear(), now.getMonth() + 1, 0);

	const leaderboards: Array<{
		id: string;
		userId: string;
		driverId: string;
		category: (typeof LEADERBOARD_CATEGORIES)[number];
		period: (typeof LEADERBOARD_PERIODS)[number];
		rank: number;
		score: number;
		periodStart: Date;
		periodEnd: Date;
	}> = [];

	// Sort drivers by rating and create rankings
	const sortedDrivers = [...drivers].sort(
		(a, b) => (b.rating ?? 0) - (a.rating ?? 0),
	);

	sortedDrivers.forEach((d, idx) => {
		leaderboards.push({
			id: v7(),
			userId: d.userId,
			driverId: d.id,
			category: "RATING",
			period: "MONTHLY",
			rank: idx + 1,
			score: Math.round((d.rating ?? 0) * 100),
			periodStart,
			periodEnd,
		});
	});

	// Add volume category
	const shuffled = [...drivers].sort(() => Math.random() - 0.5);
	shuffled.forEach((d, idx) => {
		leaderboards.push({
			id: v7(),
			userId: d.userId,
			driverId: d.id,
			category: "VOLUME",
			period: "MONTHLY",
			rank: idx + 1,
			score: faker.number.int({ min: 10, max: 100 }),
			periodStart,
			periodEnd,
		});
	});

	await db.insert(leaderboard).values(leaderboards);
	console.log(`✅ Inserted ${leaderboards.length} leaderboard entries.`);
}

async function seedOrderItems() {
	console.log("🛒 Seeding Order Items...");

	// Get FOOD orders without items
	const foodOrders = await db
		.select({ id: order.id, merchantId: order.merchantId })
		.from(order)
		.where(eq(order.type, "FOOD"));

	if (foodOrders.length === 0) {
		console.warn("⚠️ No FOOD orders found. Skipping order items.");
		return;
	}

	// Check existing order items
	const existingItems = await db
		.select({ orderId: orderItem.orderId })
		.from(orderItem);
	const ordersWithItems = new Set(existingItems.map((i) => i.orderId));

	const ordersToSeed = foodOrders
		.filter((o) => !ordersWithItems.has(o.id) && o.merchantId !== null)
		.slice(0, 30);

	if (ordersToSeed.length === 0) {
		console.log("✅ Order items already exist.");
		return;
	}

	// Get menus for merchants
	const merchantIds = [
		...new Set(ordersToSeed.map((o) => o.merchantId).filter(Boolean)),
	] as string[];
	const menus = await db
		.select()
		.from(merchantMenu)
		.where(inArray(merchantMenu.merchantId, merchantIds));

	if (menus.length === 0) {
		console.warn("⚠️ No menus found. Skipping order items.");
		return;
	}

	const menusByMerchant = new Map<string, typeof menus>();
	for (const m of menus) {
		const existing = menusByMerchant.get(m.merchantId) ?? [];
		existing.push(m);
		menusByMerchant.set(m.merchantId, existing);
	}

	const items: Array<{
		orderId: string;
		menuId: string;
		quantity: number;
		unitPrice: string;
	}> = [];

	for (const o of ordersToSeed) {
		const merchantMenus = menusByMerchant.get(o.merchantId ?? "");
		if (!merchantMenus || merchantMenus.length === 0) continue;

		const itemCount = faker.number.int({ min: 1, max: 3 });
		const selectedMenus = faker.helpers.arrayElements(merchantMenus, itemCount);

		for (const menu of selectedMenus) {
			items.push({
				orderId: o.id,
				menuId: menu.id,
				quantity: faker.number.int({ min: 1, max: 3 }),
				unitPrice: menu.price,
			});
		}
	}

	if (items.length > 0) {
		await db.insert(orderItem).values(items);
	}
	console.log(`✅ Inserted ${items.length} order items.`);
}

async function seedCouponUsages() {
	console.log("🎟️ Seeding Coupon Usages...");

	const coupons = await db.select({ id: coupon.id }).from(coupon);
	const completedOrders = await db
		.select({ id: order.id, userId: order.userId })
		.from(order)
		.where(eq(order.status, "COMPLETED"));

	if (coupons.length === 0 || completedOrders.length === 0) {
		console.warn("⚠️ No coupons or orders found. Skipping coupon usages.");
		return;
	}

	// Check existing usages
	const existing = await db.select({ id: couponUsage.id }).from(couponUsage);

	if (existing.length > 0) {
		console.log("✅ Coupon usages already exist.");
		return;
	}

	const usages = completedOrders.slice(0, 20).map((o) => ({
		id: v7(),
		couponId: faker.helpers.arrayElement(coupons).id,
		orderId: o.id,
		userId: o.userId,
		discountApplied: faker.number
			.int({ min: 5000, max: 20000, multipleOf: 1000 })
			.toString(),
		usedAt: faker.date.recent({ days: 30 }),
	}));

	await db.insert(couponUsage).values(usages);
	console.log(`✅ Inserted ${usages.length} coupon usages.`);
}

async function seedOrderChatMessages() {
	console.log("💬 Seeding Order Chat Messages...");

	const activeOrders = await db
		.select({ id: order.id, userId: order.userId, driverId: order.driverId })
		.from(order)
		.where(
			inArray(order.status, ["ACCEPTED", "ARRIVING", "IN_TRIP", "COMPLETED"]),
		);

	if (activeOrders.length === 0) {
		console.warn("⚠️ No active orders found. Skipping chat messages.");
		return;
	}

	// Check existing messages
	const existing = await db
		.select({ orderId: orderChatMessage.orderId })
		.from(orderChatMessage);
	const ordersWithMessages = new Set(existing.map((m) => m.orderId));

	const ordersToSeed = activeOrders
		.filter((o) => !ordersWithMessages.has(o.id) && o.driverId !== null)
		.slice(0, 20);

	if (ordersToSeed.length === 0) {
		console.log("✅ Chat messages already exist.");
		return;
	}

	// Get driver user IDs
	const driverIds = [
		...new Set(ordersToSeed.map((o) => o.driverId).filter(Boolean)),
	] as string[];
	const driverUsers = await db
		.select({ id: driver.id, userId: driver.userId })
		.from(driver)
		.where(inArray(driver.id, driverIds));
	const driverUserMap = new Map(driverUsers.map((d) => [d.id, d.userId]));

	const driverMessages = [
		"Dalam perjalanan menuju lokasi Anda",
		"Sudah sampai di lokasi penjemputan",
		"Mohon ditunggu sebentar ya",
		"Terima kasih, selamat sampai tujuan!",
	];

	const userMessages = [
		"Baik, saya tunggu di depan gedung",
		"Oke, saya pakai baju merah",
		"Sudah di lokasi, tolong segera ya",
		"Terima kasih drivernya ramah!",
	];

	const messages: Array<{
		id: string;
		orderId: string;
		senderId: string;
		message: string;
		sentAt: Date;
	}> = [];

	for (const o of ordersToSeed) {
		const driverUserId = driverUserMap.get(o.driverId ?? "");
		if (!driverUserId) continue;

		const baseTime = faker.date.recent({ days: 7 });

		// Driver message
		messages.push({
			id: v7(),
			orderId: o.id,
			senderId: driverUserId,
			message: faker.helpers.arrayElement(driverMessages),
			sentAt: baseTime,
		});

		// User reply
		messages.push({
			id: v7(),
			orderId: o.id,
			senderId: o.userId,
			message: faker.helpers.arrayElement(userMessages),
			sentAt: new Date(baseTime.getTime() + 1000 * 60 * 2),
		});
	}

	if (messages.length > 0) {
		await db.insert(orderChatMessage).values(messages);
	}
	console.log(`✅ Inserted ${messages.length} chat messages.`);
}

async function seedEmergencies() {
	console.log("🚨 Seeding Emergencies...");

	// Check existing emergencies
	const existing = await db.select({ id: emergency.id }).from(emergency);

	if (existing.length > 0) {
		console.log("✅ Emergencies already exist.");
		return;
	}

	const activeOrders = await db
		.select({ id: order.id, userId: order.userId, driverId: order.driverId })
		.from(order)
		.where(inArray(order.status, ["IN_TRIP", "COMPLETED"]))
		.limit(5);

	if (activeOrders.length === 0) {
		console.warn("⚠️ No active orders found. Skipping emergencies.");
		return;
	}

	const [admin] = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.email, "test-admin-1@akademove.com"))
		.limit(1);

	const emergencies = activeOrders
		.filter((o) => o.driverId !== null)
		.slice(0, 3)
		.map((o) => ({
			id: v7(),
			orderId: o.id,
			userId: o.userId,
			driverId: o.driverId,
			type: faker.helpers.arrayElement(CONSTANTS.EMERGENCY_TYPES),
			status: faker.helpers.arrayElement(["REPORTED", "RESOLVED"] as const),
			description: faker.helpers.arrayElement([
				"Kecelakaan ringan di jalan",
				"Penumpang merasa tidak aman",
				"Kehilangan barang di kendaraan",
			]),
			location: sql`ST_SetSRID(ST_MakePoint(${BASE_LNG + faker.number.float({ min: -0.01, max: 0.01 })}, ${BASE_LAT + faker.number.float({ min: -0.01, max: 0.01 })}), 4326)`,
			contactedAuthorities: [],
			respondedById: admin?.id,
			resolution: faker.datatype.boolean()
				? "Masalah telah diselesaikan dengan baik"
				: null,
			reportedAt: faker.date.recent({ days: 30 }),
		}));

	await db.insert(emergency).values(emergencies);
	console.log(`✅ Inserted ${emergencies.length} emergency records.`);
}

async function seedReports() {
	console.log("📋 Seeding Reports...");

	// Check existing reports
	const existing = await db.select({ id: report.id }).from(report);

	if (existing.length > 0) {
		console.log("✅ Reports already exist.");
		return;
	}

	const users = await db
		.select({ id: tables.user.id })
		.from(tables.user)
		.where(eq(tables.user.role, "USER"))
		.limit(10);

	const driverUsers = await db
		.select({ id: tables.user.id })
		.from(tables.user)
		.where(eq(tables.user.role, "DRIVER"))
		.limit(10);

	if (users.length === 0 || driverUsers.length === 0) {
		console.warn("⚠️ Not enough users found. Skipping reports.");
		return;
	}

	const [admin] = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.email, "test-admin-1@akademove.com"))
		.limit(1);

	const reports = Array.from({ length: 5 }).map(() => ({
		id: v7(),
		reporterId: faker.helpers.arrayElement(users).id,
		targetUserId: faker.helpers.arrayElement(driverUsers).id,
		category: faker.helpers.arrayElement(CONSTANTS.REPORT_CATEGORIES),
		description: faker.helpers.arrayElement([
			"Driver mengemudi terlalu cepat dan berbahaya",
			"Driver tidak sopan dalam berkomunikasi",
			"Driver meminta pembayaran di luar aplikasi",
			"Kendaraan tidak sesuai dengan yang terdaftar",
			"Driver membatalkan pesanan tanpa alasan jelas",
		]),
		status: faker.helpers.arrayElement(["PENDING", "RESOLVED"] as const),
		handledById: faker.datatype.boolean() ? admin?.id : null,
		resolution: faker.datatype.boolean()
			? "Laporan telah ditindaklanjuti dan driver diberi peringatan"
			: null,
		reportedAt: faker.date.recent({ days: 30 }),
	}));

	await db.insert(report).values(reports);
	console.log(`✅ Inserted ${reports.length} reports.`);
}

async function seedBroadcasts() {
	console.log("📢 Seeding Broadcasts...");

	// Check existing broadcasts
	const existing = await db.select({ id: broadcast.id }).from(broadcast);

	if (existing.length > 0) {
		console.log("✅ Broadcasts already exist.");
		return;
	}

	const [admin] = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.email, "test-admin-1@akademove.com"))
		.limit(1);

	if (!admin) {
		console.warn("⚠️ Admin user not found. Skipping broadcasts.");
		return;
	}

	const broadcasts = INDONESIAN_BROADCASTS.map((b, idx) => ({
		id: v7(),
		...b,
		type: faker.helpers.arrayElement(["EMAIL", "IN_APP", "ALL"] as const),
		status: idx < 2 ? ("SENT" as const) : ("PENDING" as const),
		targetAudience: faker.helpers.arrayElement([
			"ALL",
			"USERS",
			"DRIVERS",
		] as const),
		totalRecipients: idx < 2 ? faker.number.int({ min: 100, max: 500 }) : 0,
		sentCount: idx < 2 ? faker.number.int({ min: 90, max: 500 }) : 0,
		failedCount: idx < 2 ? faker.number.int({ min: 0, max: 10 }) : 0,
		createdBy: admin.id,
		sentAt: idx < 2 ? faker.date.recent({ days: 7 }) : null,
		scheduledAt: idx >= 2 ? faker.date.soon({ days: 7 }) : null,
	}));

	await db.insert(broadcast).values(broadcasts);
	console.log(`✅ Inserted ${broadcasts.length} broadcasts.`);
}

async function seedContacts() {
	console.log("📞 Seeding Contacts...");

	// Check existing contacts
	const existing = await db.select({ id: contact.id }).from(contact);

	if (existing.length > 0) {
		console.log("✅ Contacts already exist.");
		return;
	}

	const users = await db
		.select({
			id: tables.user.id,
			name: tables.user.name,
			email: tables.user.email,
		})
		.from(tables.user)
		.where(eq(tables.user.role, "USER"))
		.limit(10);

	const [admin] = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.email, "test-admin-1@akademove.com"))
		.limit(1);

	const contacts = Array.from({ length: 8 }).map((_, idx) => {
		const user = users[idx % users.length];
		const isResolved = idx < 3;
		return {
			id: v7(),
			name: user?.name ?? id.person.fullName(),
			email: user?.email ?? id.internet.email(),
			subject:
				INDONESIAN_CONTACT_SUBJECTS[idx % INDONESIAN_CONTACT_SUBJECTS.length],
			message: faker.helpers.arrayElement([
				"Saya mengalami masalah saat melakukan top up saldo. Mohon bantuannya.",
				"Driver tidak datang meskipun sudah menunggu lama. Bagaimana solusinya?",
				"Aplikasi selalu error saat pembayaran. Tolong diperbaiki.",
				"Saya ingin mengajukan pengembalian dana karena pesanan dibatalkan.",
				"Terima kasih atas layanannya yang sangat baik!",
			]),
			status: isResolved ? ("RESOLVED" as const) : ("PENDING" as const),
			userId: user?.id,
			respondedById: isResolved ? admin?.id : null,
			response: isResolved
				? "Terima kasih telah menghubungi kami. Masalah Anda telah kami tindaklanjuti."
				: null,
			respondedAt: isResolved ? faker.date.recent({ days: 3 }) : null,
		};
	});

	await db.insert(contact).values(contacts);
	console.log(`✅ Inserted ${contacts.length} contact submissions.`);
}

async function seedUserNotifications() {
	console.log("🔔 Seeding User Notifications...");

	const users = await db
		.select({ id: tables.user.id })
		.from(tables.user)
		.limit(30);

	if (users.length === 0) {
		console.warn("⚠️ No users found. Skipping notifications.");
		return;
	}

	// Check existing notifications
	const existing = await db
		.select({ userId: userNotification.userId })
		.from(userNotification);

	if (existing.length > 0) {
		console.log("✅ User notifications already exist.");
		return;
	}

	const notifications: Array<{
		id: string;
		userId: string;
		title: string;
		body: string;
		isRead: boolean;
		createdAt: Date;
		readAt: Date | null;
	}> = [];

	for (const u of users.slice(0, 20)) {
		const notifCount = faker.number.int({ min: 2, max: 5 });
		for (let i = 0; i < notifCount; i++) {
			const notif = faker.helpers.arrayElement(INDONESIAN_NOTIFICATIONS);
			const isRead = faker.datatype.boolean();
			const createdAt = faker.date.recent({ days: 14 });

			notifications.push({
				id: v7(),
				userId: u.id,
				title: notif.title,
				body: notif.body,
				isRead,
				createdAt,
				readAt: isRead ? new Date(createdAt.getTime() + 1000 * 60 * 30) : null,
			});
		}
	}

	await db.insert(userNotification).values(notifications);
	console.log(`✅ Inserted ${notifications.length} user notifications.`);
}

async function seedAccountDeletions() {
	console.log("🗑️ Seeding Account Deletions...");

	// Check existing
	const existing = await db
		.select({ id: accountDeletion.id })
		.from(accountDeletion);

	if (existing.length > 0) {
		console.log("✅ Account deletions already exist.");
		return;
	}

	const users = await db
		.select({
			id: tables.user.id,
			name: tables.user.name,
			email: tables.user.email,
			phone: tables.user.phone,
			role: tables.user.role,
		})
		.from(tables.user)
		.where(eq(tables.user.role, "USER"))
		.limit(5);

	const [admin] = await db
		.select()
		.from(tables.user)
		.where(eq(tables.user.email, "test-admin-1@akademove.com"))
		.limit(1);

	const reasons = [
		"NO_LONGER_NEEDED",
		"PRIVACY_CONCERNS",
		"SWITCHING_SERVICE",
		"TOO_MANY_NOTIFICATIONS",
		"DIFFICULT_TO_USE",
		"POOR_EXPERIENCE",
		"OTHER",
	] as const;

	const deletions = users.map((u, idx) => {
		const isReviewed = idx < 2;
		return {
			id: v7(),
			fullName: u.name ?? id.person.fullName(),
			email: u.email,
			phone: `08${faker.number.int({ min: 1000000000, max: 9999999999 })}`,
			accountType: "USER" as const,
			reason: faker.helpers.arrayElement(reasons),
			additionalInfo: faker.datatype.boolean()
				? "Saya tidak lagi menggunakan layanan ini"
				: null,
			status: isReviewed ? ("APPROVED" as const) : ("PENDING" as const),
			userId: u.id,
			reviewedById: isReviewed ? admin?.id : null,
			reviewNotes: isReviewed ? "Permintaan disetujui sesuai kebijakan" : null,
			reviewedAt: isReviewed ? faker.date.recent({ days: 5 }) : null,
			completedAt: isReviewed ? faker.date.recent({ days: 3 }) : null,
		};
	});

	await db.insert(accountDeletion).values(deletions);
	console.log(`✅ Inserted ${deletions.length} account deletion requests.`);
}

async function main() {
	try {
		await confirmExecution();

		const options = await promptSeedingOptions();

		console.log("\n🌱 Starting database seeding...\n");

		// Determine which seeders to run
		const shouldRun = (seeder: string) => {
			if (options.mode === "all") return true;
			return options.seeders.has(seeder);
		};

		// Phase 1: Foundation data (users and badges)
		const phase1: Promise<void>[] = [];

		if (shouldRun("users")) {
			phase1.push(seedUser(options.mode === "base"));
		}
		if (shouldRun("badges")) {
			phase1.push(seedBadges());
		}

		if (phase1.length > 0) {
			await Promise.all(phase1);
		}

		// Phase 2: Dependent data (requires users to exist)
		const phase2: Promise<void>[] = [];

		if (shouldRun("userBadges")) {
			phase2.push(seedUserBadges());
		}
		if (shouldRun("configurations")) {
			phase2.push(seedConfigurations());
		}
		if (shouldRun("merchants")) {
			phase2.push(seedMerchants());
		}
		if (shouldRun("drivers")) {
			phase2.push(seedDrivers());
		}

		if (phase2.length > 0) {
			await Promise.all(phase2);
		}

		// Phase 3: Orders and related data (requires users, drivers, merchants)
		const phase3: Promise<void>[] = [];

		if (shouldRun("orders")) {
			phase3.push(seedOrders());
		}
		if (shouldRun("merchantMenus")) {
			phase3.push(seedMerchantMenus());
		}
		if (shouldRun("driverSchedules")) {
			phase3.push(seedDriverSchedules());
		}
		if (shouldRun("driverQuizQuestions")) {
			phase3.push(seedDriverQuizQuestions());
		}
		if (shouldRun("driverQuizAnswers")) {
			phase3.push(seedDriverQuizAnswers());
		}
		if (shouldRun("coupons")) {
			phase3.push(seedCoupons());
		}

		if (phase3.length > 0) {
			await Promise.all(phase3);
		}

		// Phase 4: Financial and transaction data (requires orders)
		const phase4: Promise<void>[] = [];

		if (shouldRun("transactions")) {
			phase4.push(seedTransactions());
		}
		if (shouldRun("payments")) {
			phase4.push(seedPayments());
		}
		if (shouldRun("orderItems")) {
			phase4.push(seedOrderItems());
		}
		if (shouldRun("couponUsages")) {
			phase4.push(seedCouponUsages());
		}

		if (phase4.length > 0) {
			await Promise.all(phase4);
		}

		// Phase 5: User interaction and gamification data
		const phase5: Promise<void>[] = [];

		if (shouldRun("reviews")) {
			phase5.push(seedReviews());
		}
		if (shouldRun("leaderboards")) {
			phase5.push(seedLeaderboards());
		}
		if (shouldRun("orderChatMessages")) {
			phase5.push(seedOrderChatMessages());
		}
		if (shouldRun("emergencies")) {
			phase5.push(seedEmergencies());
		}
		if (shouldRun("reports")) {
			phase5.push(seedReports());
		}
		if (shouldRun("broadcasts")) {
			phase5.push(seedBroadcasts());
		}
		if (shouldRun("contacts")) {
			phase5.push(seedContacts());
		}
		if (shouldRun("userNotifications")) {
			phase5.push(seedUserNotifications());
		}
		if (shouldRun("accountDeletions")) {
			phase5.push(seedAccountDeletions());
		}

		if (phase5.length > 0) {
			await Promise.all(phase5);
		}

		console.log("\n✅ Database seeded successfully.");
	} catch (error) {
		console.error("\n❌ Seeding failed:", error);
		process.exit(1);
	} finally {
		await client.end();
		process.exit(0);
	}
}

main();
