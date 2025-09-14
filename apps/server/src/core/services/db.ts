import { env } from "cloudflare:workers";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as auth from "@/core/tables/auth";
import * as driver from "@/core/tables/driver";
import * as merchant from "@/core/tables/merchant";
import * as order from "@/core/tables/order";
import * as schedule from "@/core/tables/schedule";
import { isDev } from "@/utils";

export const tables = {
	...auth,
	...driver,
	...merchant,
	...order,
	...schedule,
};

export const getDatabase = () => {
	const client = postgres(env.MAIN_DB.connectionString);
	return drizzle({
		client,
		logger: isDev,
		schema: tables,
	});
};

export type DatabaseInstance = ReturnType<typeof getDatabase>;
