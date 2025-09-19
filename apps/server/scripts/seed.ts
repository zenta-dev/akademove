import { scryptSync } from "node:crypto";
import * as readline from "node:readline";
import { faker } from "@faker-js/faker";
import { CONSTANTS } from "@repo/schema/constants";
import type { InsertMerchant } from "@repo/schema/merchant";
import type { InsertUser } from "@repo/schema/user";
import { authPermission } from "@repo/shared";
import { BetterAuthError, betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { admin } from "better-auth/plugins";
import { and, eq } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "@/core/tables/auth";
import {
	type ConfigurationDatabase,
	configuration,
} from "@/core/tables/configuration";
import { driver } from "@/core/tables/driver";
import { merchant } from "@/core/tables/merchant";

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

	const [admin] = await db
		.select()
		.from(schema.user)
		.where(and(eq(schema.user.email, "test-admin-1@akademove.com")));

	const _CONFIGS: ConfigurationDatabase[] = [
		{
			key: "ride-service-pricing",
			name: "Ride Pricing",
			value: {
				price_per_km: 5000,
				commission: 7,
			},
			description: "Current base price per km",
			updatedById: admin.id,
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
			updatedById: admin.id,
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
			updatedById: admin.id,
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
			continue;
		}
		await db.insert(configuration).values(conf).returning();
	}
}

async function seedMerchants() {
	console.log("Seeding Merchants");
	const users = await db
		.select()
		.from(schema.user)
		.where(eq(schema.user.role, "user"));

	if (users.length === 0) {
		console.warn("No users with role 'user' found.");
		return;
	}

	const merchants = Array.from({ length: 5 }).map(() => {
		const randomUser = users[Math.floor(Math.random() * users.length)];
		return {
			userId: randomUser.id,
			name: faker.company.name(),
			type: Math.random() < 0.5 ? "merchant" : "tenant",
			address: faker.location.streetAddress(),
			location: {
				lat: faker.location.latitude(),
				lng: faker.location.longitude(),
			},
			isActive: Math.random() < 0.5,
		} satisfies InsertMerchant & { userId: string };
	});

	await db.insert(merchant).values(merchants);
	console.log(`Inserted ${merchants.length} merchants.`);
}

async function seedDrivers() {
	console.log("Seeding Drivers");
	const users = await db
		.select()
		.from(schema.user)
		.where(eq(schema.user.role, "user"));

	if (users.length === 0) {
		console.warn("No users with role 'user' found.");
		return;
	}
	const drivers = Array.from({ length: 5 }).map(() => {
		const randomUser = users[Math.floor(Math.random() * users.length)];
		return {
			userId: randomUser.id,
			studentId: faker.string.alphanumeric(10),
			licenseNumber: faker.string.alphanumeric(8),
			status: faker.helpers.arrayElement(CONSTANTS.DRIVER_STATUSES),
			rating: Number.parseFloat(
				faker.number.float({ min: 1, max: 5 }).toFixed(1),
			),
			isOnline: faker.datatype.boolean(),
			currentLocation: faker.datatype.boolean()
				? {
						lat: faker.location.latitude(),
						lng: faker.location.longitude(),
					}
				: null,
			lastLocationUpdate: faker.datatype.boolean()
				? faker.date.recent({ days: 10 })
				: null,
			createdAt: new Date(),
		};
	});

	await db.insert(driver).values(drivers);
	console.log(`Inserted ${drivers.length} drivers.`);
}

await seedUser();
await Promise.all([seedConfigurations(), seedMerchants(), seedDrivers()]);
console.log("✅ Database seeded with test data.");
process.exit();
