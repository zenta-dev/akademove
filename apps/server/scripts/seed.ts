import { scryptSync } from "node:crypto";
import * as readline from "node:readline";
import type { InsertUser } from "@repo/schema/user";
import { authPermission } from "@repo/shared";
import { BetterAuthError, betterAuth, email } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { admin } from "better-auth/plugins";
import { eq } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "@/core/tables/auth";
import {
	type ConfigurationDatabase,
	configuration,
} from "@/core/tables/configuration";
import * as driver from "@/core/tables/driver";
import * as merchant from "@/core/tables/merchant";
import * as order from "@/core/tables/order";
import * as promo from "@/core/tables/promo";
import * as report from "@/core/tables/report";
import * as review from "@/core/tables/review";
import * as schedule from "@/core/tables/schedule";

async function confirmExecution() {
	if (process.env.NODE_ENV === "production") {
		console.error("❌ Seeding is blocked in production!");
		process.exit(1);
	}

	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout,
	});

	const confirmation = await new Promise<string>((resolve) =>
		rl.question(
			"\n⚠️  WARNING: This will insert a large amount of seed data into your database.\n" +
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
await confirmExecution();

const client = postgres(process.env.DATABASE_URL || "");
const db = drizzle({ client });
const auth = betterAuth({
	database: drizzleAdapter(db, {
		provider: "pg",
		schema: schema,
	}),
	emailAndPassword: {
		enabled: true,
		password: {
			hash: async (password) => {
				const salt = crypto.getRandomValues(new Uint8Array(16));
				const saltHex = Array.from(salt)
					.map((b) => b.toString(16).padStart(2, "0"))
					.join("");

				const key = scryptSync(password.normalize("NFKC"), saltHex, 64, {
					N: 16384,
					r: 16,
					p: 1,
					maxmem: 128 * 16384 * 16 * 2,
				});

				const keyHex = Array.from(key)
					.map((b) => b.toString(16).padStart(2, "0"))
					.join("");
				return `${saltHex}:${keyHex}`;
			},
			verify: async ({ hash, password }) => {
				const [saltHex, keyHex] = hash.split(":");
				if (!saltHex || !keyHex) {
					throw new BetterAuthError("Invalid password hash");
				}
				const targetKey = scryptSync(password.normalize("NFKC"), saltHex, 64, {
					N: 16384,
					r: 16,
					p: 1,
					maxmem: 128 * 16384 * 16 * 2,
				});

				const targetKeyHex = Array.from(targetKey)
					.map((b) => b.toString(16).padStart(2, "0"))
					.join("");
				return targetKeyHex === keyHex;
			},
		},
	},
	plugins: [admin(authPermission)],
});

async function seedUser() {
	const _USER: Omit<InsertUser, "confirmPassword">[] = [
		{
			name: "Test Admin 1",
			email: "test-admin-1@akademove.com",
			role: "admin",
			password: "Ch@ngEThi5",
		},
		{
			name: "Test Operator 1",
			email: "test-operator-1@akademove.com",
			role: "operator",
			password: "Ch@ngEThi5",
		},
		{
			name: "Test Merchant 1",
			email: "test-merchant-1@akademove.com",
			role: "merchant",
			password: "Ch@ngEThi5",
		},
		{
			name: "Test Driver 1",
			email: "test-driver-1@akademove.com",
			role: "driver",
			password: "Ch@ngEThi5",
		},
		{
			name: "Test User 1",
			email: "test-user-1@akademove.com",
			role: "user",
			password: "Ch@ngEThi5",
		},
	];

	const promises = [];
	for (const user of _USER) {
		const find = await db
			.select()
			.from(schema.user)
			.where(eq(schema.user.email, user.email));
		if (find.length > 0) continue;
		promises.push(auth.api.createUser({ body: user }));
	}
	console.log(`SEEDING ${promises.length} USER`);
	await Promise.all(promises);
}

async function seedConfigurations() {
	console.log("Seeding Configurations");
	const _UPDATER_ID = "ize5yQd0uPJSZliK3vXZKxxdyRww9DCF"; // should pinning to master admin

	const _CONFIGS: ConfigurationDatabase[] = [
		{
			key: "ride-service-pricing",
			name: "Ride Pricing",
			value: {
				price_per_km: 5000,
				commission: 7,
			},
			description: "Current base price per km",
			updatedById: _UPDATER_ID,
			updatedAt: new Date(),
		},
		{
			key: "delivery-service-pricing",
			name: "Delivery Pricing",
			value: {
				price_per_km: 4500,
				commission: 5,
			},
			description: "Current base price per km",
			updatedById: _UPDATER_ID,
			updatedAt: new Date(),
		},
		{
			key: "food-service-pricing",
			name: "Food Pricing",
			value: {
				price_per_km: 4000,
				commission: 3,
			},
			description: "Current base price per km",
			updatedById: _UPDATER_ID,
			updatedAt: new Date(),
		},
	];
	for (const conf of _CONFIGS) {
		console.log("FIND CONFIG WITH KEY ", conf.key);
		const find = await db
			.select()
			.from(configuration)
			.where(eq(configuration.key, conf.key));
		if (find.length > 0) {
			console.log(find);
			continue;
		}
		const res = await db.insert(configuration).values(conf).returning();
		console.log(res);
	}
}

await seedUser();
await seedConfigurations();
console.log("✅ Database seeded with test data.");
process.exit();
