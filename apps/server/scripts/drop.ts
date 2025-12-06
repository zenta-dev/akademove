import * as readline from "node:readline";
import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";

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
			"\n⚠️  WARNING: This will delete your entire database.\n" +
				"Type 'DROP' to continue: ",
			resolve,
		),
	);

	rl.close();

	if (confirmation !== "DROP") {
		console.log("❌ Operation cancelled.");
		process.exit(0);
	}
}

const client = postgres(process.env.DATABASE_URL || "");
const db = drizzle({ client });

async function main() {
	try {
		await confirmExecution();

		console.log("\n🌱 Dropping database...\n");
		await db.execute(sql`DROP EXTENSION IF EXISTS postgis CASCADE;

DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        EXECUTE 'DROP TABLE IF EXISTS public.' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;

DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'drizzle') LOOP
        EXECUTE 'DROP TABLE IF EXISTS drizzle.' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT n.nspname AS schema_name,
               t.typname  AS enum_name
        FROM pg_type t
        JOIN pg_namespace n ON n.oid = t.typnamespace
        WHERE t.typtype = 'e'
          AND n.nspname NOT IN ('pg_catalog', 'information_schema')
          AND pg_has_role(t.typowner, 'USAGE') -- current user has rights
    LOOP
        EXECUTE format('DROP TYPE IF EXISTS %I.%I CASCADE;', r.schema_name, r.enum_name);
    END LOOP;
END$$;
`);
	} catch (error) {
		console.error("\n❌ Seeding failed:", error);
		process.exit(1);
	} finally {
		await client.end();
		process.exit(0);
	}
}
main();
