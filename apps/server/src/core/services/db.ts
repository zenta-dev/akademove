import { env } from "cloudflare:workers";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as auth from "@/core/tables/auth";
import { isDev } from "@/utils";

export const getDatabase = () => {
	const client = postgres(env.MAIN_DB.connectionString);
	return drizzle({
		client,
		logger: isDev,
		schema: {
			...auth,
		},
	});
};

export type DatabaseInstance = ReturnType<typeof getDatabase>;
