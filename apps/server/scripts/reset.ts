import * as readline from "node:readline";
import { PgTable } from "drizzle-orm/pg-core";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { tables } from "./tables";

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

async function main() {
	const promises = [];
	for (const [_, table] of Object.entries(tables)) {
		if (table instanceof PgTable) promises.push(db.delete(table));
	}
	await Promise.all(promises);
	process.exit();
}

await main();
