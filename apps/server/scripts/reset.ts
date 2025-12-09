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

	// Skip confirmation if FORCE_RESET is set
	if (process.env.FORCE_RESET === "true") {
		console.log("⚠️  Force reset enabled, skipping confirmation.");
		return;
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

async function _main() {
	console.log("🗑️  Starting database reset...");

	// Disable foreign key constraints temporarily
	await client`SET session_replication_role = replica;`;

	// Get all table names from the schema
	const tableNames = Object.keys(tables).filter((name) => {
		const table = tables[name as keyof typeof tables];
		return table instanceof PgTable;
	});

	console.log(`📋 Found ${tableNames.length} tables in schema`);

	// Delete all data from tables
	for (const tableName of tableNames) {
		const table = tables[tableName as keyof typeof tables];
		if (table instanceof PgTable) {
			try {
				await db.delete(table);
				console.log(`✓ Deleted data from ${tableName}`);
			} catch (error) {
				console.log(`⚠️  Skipped ${tableName}: ${(error as Error).message}`);
			}
		}
	}

	// Re-enable foreign key constraints
	await client`SET session_replication_role = DEFAULT;`;

	console.log("🎉 Database reset completed!");
	process.exit();
}

await _main();
