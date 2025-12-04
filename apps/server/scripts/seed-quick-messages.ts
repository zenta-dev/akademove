import "@cloudflare/workers-types";

import * as readline from "node:readline";
import type { InsertQuickMessageTemplate } from "@repo/schema/quick-message";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { v7 } from "uuid";
import { quickMessageTemplate } from "@/core/tables/quick-message";

console.log(`DB URL: ${process.env.DATABASE_URL}`);

const client = postgres(process.env.DATABASE_URL || "");
const db = drizzle({ client });

async function confirmExecution() {
	if (process.env.NODE_ENV === "production") {
		console.error("❌ Seeding is blocked in production!");
		process.exit(1);
	}

	// Skip confirmation if SKIP_CONFIRM is set
	if (process.env.SKIP_CONFIRM === "true") {
		console.log("⚠️  Skipping confirmation (SKIP_CONFIRM=true)");
		return;
	}

	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout,
	});

	const confirmation = await new Promise<string>((resolve) =>
		rl.question(
			"\n⚠️  WARNING: This will insert quick message templates into your database.\n" +
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

async function seedQuickMessages() {
	console.log("💬 Seeding Quick Message Templates...");

	const now = new Date();

	const TEMPLATES: Omit<
		InsertQuickMessageTemplate,
		"id" | "createdAt" | "updatedAt"
	>[] = [
		// ==========================================
		// DRIVER TEMPLATES (English)
		// ==========================================
		{
			role: "DRIVER",
			message: "On my way! 🚗",
			orderType: null, // All order types
			locale: "en",
			isActive: true,
			displayOrder: 1,
		},
		{
			role: "DRIVER",
			message: "I've arrived 📍",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 2,
		},
		{
			role: "DRIVER",
			message: "Running a bit late, sorry! 🚦",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 3,
		},
		{
			role: "DRIVER",
			message: "Where should I wait for you?",
			orderType: "RIDE",
			locale: "en",
			isActive: true,
			displayOrder: 4,
		},
		{
			role: "DRIVER",
			message: "Package delivered ✅",
			orderType: "DELIVERY",
			locale: "en",
			isActive: true,
			displayOrder: 5,
		},
		{
			role: "DRIVER",
			message: "Your order is here! ✅",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 6,
		},
		{
			role: "DRIVER",
			message: "Thank you! Have a great day 🙏",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 7,
		},

		// ==========================================
		// DRIVER TEMPLATES (Indonesian)
		// ==========================================
		{
			role: "DRIVER",
			message: "Dalam perjalanan! 🚗",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 1,
		},
		{
			role: "DRIVER",
			message: "Sudah sampai 📍",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 2,
		},
		{
			role: "DRIVER",
			message: "Maaf, sedikit terlambat 🚦",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 3,
		},
		{
			role: "DRIVER",
			message: "Tunggu di mana ya?",
			orderType: "RIDE",
			locale: "id",
			isActive: true,
			displayOrder: 4,
		},
		{
			role: "DRIVER",
			message: "Paket sudah diantar ✅",
			orderType: "DELIVERY",
			locale: "id",
			isActive: true,
			displayOrder: 5,
		},
		{
			role: "DRIVER",
			message: "Pesanan sudah sampai! ✅",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 6,
		},
		{
			role: "DRIVER",
			message: "Terima kasih! Semoga hari Anda menyenangkan 🙏",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 7,
		},

		// ==========================================
		// USER TEMPLATES (English)
		// ==========================================
		{
			role: "USER",
			message: "Where are you now? 📱",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 1,
		},
		{
			role: "USER",
			message: "Thank you! 🙏",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 2,
		},
		{
			role: "USER",
			message: "Please hurry, I'm in a rush 🏃",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 3,
		},
		{
			role: "USER",
			message: "I'm waiting at the pickup point",
			orderType: "RIDE",
			locale: "en",
			isActive: true,
			displayOrder: 4,
		},
		{
			role: "USER",
			message: "Please call me when you arrive",
			orderType: null,
			locale: "en",
			isActive: true,
			displayOrder: 5,
		},
		{
			role: "USER",
			message: "Can you please be careful with the package? 📦",
			orderType: "DELIVERY",
			locale: "en",
			isActive: true,
			displayOrder: 6,
		},
		{
			role: "USER",
			message: "Please make sure the food doesn't spill 🍜",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 7,
		},

		// ==========================================
		// USER TEMPLATES (Indonesian)
		// ==========================================
		{
			role: "USER",
			message: "Sekarang di mana? 📱",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 1,
		},
		{
			role: "USER",
			message: "Terima kasih! 🙏",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 2,
		},
		{
			role: "USER",
			message: "Tolong cepat ya, saya terburu-buru 🏃",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 3,
		},
		{
			role: "USER",
			message: "Saya tunggu di titik jemput",
			orderType: "RIDE",
			locale: "id",
			isActive: true,
			displayOrder: 4,
		},
		{
			role: "USER",
			message: "Tolong telepon saat sudah sampai",
			orderType: null,
			locale: "id",
			isActive: true,
			displayOrder: 5,
		},
		{
			role: "USER",
			message: "Tolong hati-hati dengan paketnya ya 📦",
			orderType: "DELIVERY",
			locale: "id",
			isActive: true,
			displayOrder: 6,
		},
		{
			role: "USER",
			message: "Pastikan makanannya tidak tumpah ya 🍜",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 7,
		},

		// ==========================================
		// MERCHANT TEMPLATES (English)
		// ==========================================
		{
			role: "MERCHANT",
			message: "Order ready for pickup! ✅",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 1,
		},
		{
			role: "MERCHANT",
			message: "Preparing your order... 👨‍🍳",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 2,
		},
		{
			role: "MERCHANT",
			message: "Sorry, this item is out of stock 😞",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 3,
		},
		{
			role: "MERCHANT",
			message: "Your order will be ready in 10 minutes ⏰",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 4,
		},
		{
			role: "MERCHANT",
			message: "Driver has picked up your order 🚗",
			orderType: "FOOD",
			locale: "en",
			isActive: true,
			displayOrder: 5,
		},

		// ==========================================
		// MERCHANT TEMPLATES (Indonesian)
		// ==========================================
		{
			role: "MERCHANT",
			message: "Pesanan siap diambil! ✅",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 1,
		},
		{
			role: "MERCHANT",
			message: "Sedang menyiapkan pesanan... 👨‍🍳",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 2,
		},
		{
			role: "MERCHANT",
			message: "Maaf, item ini habis 😞",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 3,
		},
		{
			role: "MERCHANT",
			message: "Pesanan siap dalam 10 menit ⏰",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 4,
		},
		{
			role: "MERCHANT",
			message: "Driver sudah mengambil pesanan 🚗",
			orderType: "FOOD",
			locale: "id",
			isActive: true,
			displayOrder: 5,
		},
	];

	try {
		const values = TEMPLATES.map((template) => ({
			...template,
			id: v7(),
			createdAt: now,
			updatedAt: now,
		}));

		await db.insert(quickMessageTemplate).values(values).onConflictDoNothing();

		console.log(
			`✅ Successfully seeded ${values.length} quick message templates`,
		);
		console.log("   - Driver templates: English + Indonesian");
		console.log("   - User templates: English + Indonesian");
		console.log("   - Merchant templates: English + Indonesian");
	} catch (error) {
		console.error("❌ Failed to seed quick messages:", error);
		throw error;
	}
}

async function main() {
	try {
		await confirmExecution();
		console.log("\n🌱 Starting quick message template seeding...\n");
		await seedQuickMessages();
		console.log("\n✅ Quick message templates seeded successfully.");
	} catch (error) {
		console.error("\n❌ Seeding failed:", error);
		process.exit(1);
	} finally {
		await client.end();
		process.exit(0);
	}
}

main();
