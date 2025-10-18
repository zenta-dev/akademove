import * as readline from "node:readline";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { account, user, verification } from "@/core/tables/auth";
import { configuration } from "@/core/tables/configuration";
import { coupon, couponUsage } from "@/core/tables/coupon";
import { driver } from "@/core/tables/driver";
import { merchant, merchantMenu } from "@/core/tables/merchant";
import { order } from "@/core/tables/order";
import { report } from "@/core/tables/report";
import { review } from "@/core/tables/review";
import { schedule } from "@/core/tables/schedule";

async function confirmExecution() {
	if (process.env.NODE_ENV === "production") {
		console.error("❌ Reset is blocked in production!");
		process.exit(1);
	}

	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout,
	});

	const confirmation = await new Promise<string>((resolve) =>
		rl.question(
			"\n⚠️  WARNING: This will delete your database.\n" +
				"Type 'RESET' to continue: ",
			resolve,
		),
	);

	rl.close();

	if (confirmation !== "RESET") {
		console.log("❌ Operation cancelled.");
		process.exit(0);
	}
}
await confirmExecution();

const client = postgres(process.env.DATABASE_URL || "");
const db = drizzle({ client });

export const tables = {
	user,
	account,
	verification,
	configuration,
	couponUsage,
	coupon,
	driver,
	merchantMenu,
	merchant,
	order,
	report,
	review,
	schedule,
};

async function main() {
	const promises = [];
	for (const [_, table] of Object.entries(tables)) {
		promises.push(db.delete(table));
	}
	await Promise.all(promises);
	process.exit();
}

await main();
