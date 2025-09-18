import * as readline from "node:readline";
import { drizzle } from "drizzle-orm/postgres-js";
import { seed } from "drizzle-seed";
import postgres from "postgres";

import * as auth from "@/core/tables/auth";
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

async function main() {
	await confirmExecution();

	const client = postgres(process.env.DATABASE_URL || "");
	const db = drizzle({ client });

	await seed(
		db,
		{
			...auth,
			...driver,
			...merchant,
			...order,
			...promo,
			...report,
			...review,
			...schedule,
		},
		{ count: 100 },
	);

	console.log("✅ Database seeded with test data.");
}

main().catch((err) => {
	console.error("❌ Error during seeding:", err);
	process.exit(1);
});
