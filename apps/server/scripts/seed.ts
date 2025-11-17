import "@cloudflare/workers-types";

import { randomBytes } from "node:crypto";
import { readFile } from "node:fs/promises";
import { join } from "node:path";
import * as readline from "node:readline";
import { faker } from "@faker-js/faker";
import type { InsertBadge } from "@repo/schema/badge";
import { CONSTANTS } from "@repo/schema/constants";
import type { InsertMerchant } from "@repo/schema/merchant";
import type { InsertUser } from "@repo/schema/user";
import { eq, inArray, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { v7 } from "uuid";
import { S3StorageService } from "@/core/services/storage";
import {
	configuration,
	configurationAuditLog,
} from "@/core/tables/configuration";
import { driver } from "@/core/tables/driver";
import { merchant } from "@/core/tables/merchant";
import { order } from "@/core/tables/order";
import { PasswordManager } from "@/utils/password";
import { tables } from "./tables";

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

const client = postgres(process.env.DATABASE_URL || "");
const db = drizzle({ client });
const storage = new S3StorageService({
	endpoint: process.env.S3_ENDPOINT || "",
	region: process.env.S3_REGION || "",
	accessKeyId: process.env.S3_ACCESS_KEY_ID || "",
	secretAccessKey: process.env.S3_SECRET_ACCESS_KEY || "",
	publicUrl: process.env.S3_PUBLIC_URL || "",
});

function generateId(): string {
	return randomBytes(32).toString("hex");
}

async function seedUser() {
	const pw = new PasswordManager();

	const FIXED_USERS: Omit<InsertUser, "confirmPassword" | "badges">[] = [
		{
			name: "Test Admin 1",
			email: "test-admin-1@akademove.com",
			role: "admin",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230851 },
		},
		{
			name: "Test Operator 1",
			email: "test-operator-1@akademove.com",
			role: "operator",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230852 },
		},
		{
			name: "Test Merchant 1",
			email: "test-merchant-1@akademove.com",
			role: "merchant",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230853 },
		},
		{
			name: "Test Driver 1",
			email: "test-driver-1@akademove.com",
			role: "driver",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230854 },
			gender: "male",
		},
		{
			name: "Test User 1",
			email: "test-user-1@akademove.com",
			role: "user",
			password: "Ch@ngEThi5",
			phone: { countryCode: "ID", number: 8573230855 },
			gender: "male",
		},
	];

	const RANDOM_USERS = Array.from({ length: 500 }).map(
		() =>
			({
				name: faker.person.fullName(),
				email: faker.internet.email().toLowerCase(),
				role: faker.helpers.arrayElement(["user", "driver", "merchant"]),
				password: "Ch@ngEThi5",
				phone: {
					countryCode: "ID",
					number: Number(
						faker.phone.number({ style: "human" }).replace(/\D/g, ""),
					),
				},
				gender: faker.helpers.arrayElement(["male", "female"]),
			}) as const,
	);

	const USERS = [
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
				},
				description: "Food delivery pricing",
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
		.where(eq(tables.user.role, "merchant"));

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

		return {
			id: v7(),
			userId: user.id,
			name: faker.company.name(),
			email: user.email,
			phone: user.phone,
			// categories: Array.from({
			// 	length: faker.number.int({ min: 1, max: 6 }),
			// }).map(() => faker.food.ethnicCategory()),
			address: faker.location.streetAddress(),
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
		.where(eq(tables.user.role, "driver"));

	if (users.length === 0) {
		console.warn("⚠️ No users with role 'driver' found.");
		return;
	}

	// Check existing drivers to avoid duplicates
	const existingDrivers = await db
		.select({ userId: driver.userId })
		.from(driver);

	const existingUserIds = new Set(existingDrivers.map((d) => d.userId));
	const availableUsers = users.filter((u) => !existingUserIds.has(u.id));

	if (availableUsers.length === 0) {
		console.log("✅ All driver users already have driver profiles.");
		return;
	}

	const drivers = availableUsers.map((user) => {
		const bankProvider = faker.helpers.arrayElement(CONSTANTS.BANK_PROVIDERS);
		const { lat, lng } = randomOffsetLatLng(BASE_LAT, BASE_LNG, OFFSET_METERS);

		return {
			id: v7(),
			userId: user.id,
			studentId: faker.number.int({ min: 2_000_000, max: 9_999_999 }),
			licensePlate: faker.string.alphanumeric(8).toUpperCase(),
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

	await db.insert(driver).values(drivers);
	console.log(
		`✅ Inserted ${drivers.length} drivers near (${BASE_LAT}, ${BASE_LNG}).`,
	);
}

async function seedOrders() {
	console.log("📦 Seeding Orders...");

	const users = await db
		.select({ id: tables.user.id })
		.from(tables.user)
		.where(eq(tables.user.role, "user"));

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
			type: "achievement",
			level: "bronze",
			targetRole: "user",
			criteria: {
				minOrders: 0, // Awarded upon registration approval
			},
			isActive: true,
			displayOrder: 100,
			iconPath: "assets/New-Customer.png",
		},
		{
			code: "FIRST_RIDE",
			name: "First Ride",
			description: "Complete your first ride successfully",
			type: "achievement",
			level: "bronze",
			targetRole: "user",
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
			type: "milestone",
			level: "silver",
			targetRole: "user",
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
			type: "milestone",
			level: "gold",
			targetRole: "user",
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
			type: "milestone",
			level: "platinum",
			targetRole: "user",
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
			type: "achievement",
			level: "bronze",
			targetRole: "driver",
			criteria: {
				minOrders: 0, // Awarded upon registration approval
			},
			isActive: true,
			displayOrder: 100,
			iconPath: "assets/New-Driver.png",
		},
		{
			code: "FIRST_TRIP",
			name: "First Trip",
			description: "Complete your first trip as a driver",
			type: "achievement",
			level: "bronze",
			targetRole: "driver",
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
			type: "performance",
			level: "silver",
			targetRole: "driver",
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
			type: "performance",
			level: "gold",
			targetRole: "driver",
			criteria: {
				minOrders: 100,
				minRating: 4.8,
			},
			benefits: {
				priorityBoost: 20,
				commissionReduction: 0.05, // 5% commission reduction
			},
			isActive: true,
			displayOrder: 111,
			iconPath: "assets/Star-Driver.png",
		},
		{
			code: "ELITE_DRIVER",
			name: "Elite Driver",
			description: "Maintain 4.9+ rating with 500 completed rides",
			type: "performance",
			level: "platinum",
			targetRole: "driver",
			criteria: {
				minOrders: 500,
				minRating: 4.9,
			},
			benefits: {
				priorityBoost: 30,
				commissionReduction: 0.1, // 10% commission reduction
			},
			isActive: true,
			displayOrder: 112,
			iconPath: "assets/Elite-Driver.png",
		},
		{
			code: "CENTURION",
			name: "Centurion",
			description: "Complete 100 rides",
			type: "milestone",
			level: "gold",
			targetRole: "driver",
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
			type: "achievement",
			level: "bronze",
			targetRole: "merchant",
			criteria: {
				minOrders: 0, // Awarded upon registration
			},
			isActive: true,
			displayOrder: 200,
			iconPath: "assets/New-Merchant.png",
		},
		{
			code: "FIRST_ORDER",
			name: "First Order",
			description: "Receive your first order",
			type: "achievement",
			level: "bronze",
			targetRole: "merchant",
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
			type: "performance",
			level: "silver",
			targetRole: "merchant",
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
			type: "performance",
			level: "gold",
			targetRole: "merchant",
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
	const cwd = process.cwd();

	await Promise.all([
		db
			.insert(tables.badge)
			.values(
				DEFAULT_BADGES.map((e) => ({ ...e, id: v7(), icon: `${e.code}.png` })),
			),
		...DEFAULT_BADGES.map(async (badge) => {
			const filePath = join(cwd, badge.iconPath);
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
	]);
}

async function seedUserBadges() {
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

	await db.insert(tables.userBadge).values(values);
}

async function main() {
	try {
		await confirmExecution();

		console.log("\n🌱 Starting database seeding...\n");

		await Promise.all([seedUser(), seedBadges()]);
		await Promise.all([
			seedConfigurations(),
			seedMerchants(),
			seedDrivers(),
			seedUserBadges(),
		]);
		await seedOrders();

		console.log("\n✅ Database seeded successfully with test data.");
	} catch (error) {
		console.error("\n❌ Seeding failed:", error);
		process.exit(1);
	} finally {
		await client.end();
		process.exit(0);
	}
}

main();
