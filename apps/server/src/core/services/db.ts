import { env } from "cloudflare:workers";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as auth from "@/core/tables/auth";
import * as driver from "@/core/tables/driver";
import { isDev } from "@/utils";

export const getDatabase = () => {
	const client = postgres(env.MAIN_DB.connectionString);
	return drizzle({
		client,
		logger: isDev,
		schema: {
			...auth,
			...driver,
		},
	});
};

export type DatabaseInstance = ReturnType<typeof getDatabase>;
