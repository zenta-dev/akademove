import { env } from "cloudflare:workers";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as auth from "@/core/tables/auth";
import * as configuration from "@/core/tables/configuration";
import * as coupon from "@/core/tables/coupon";
import * as driver from "@/core/tables/driver";
import * as merchant from "@/core/tables/merchant";
import * as order from "@/core/tables/order";
import * as report from "@/core/tables/report";
import * as review from "@/core/tables/review";
import * as schedule from "@/core/tables/schedule";
import { isDev } from "@/utils";

export const tables = {
	...auth,
	...driver,
	...merchant,
	...order,
	...coupon,
	...report,
	...review,
	...schedule,
	...configuration,
};

export const getDatabase = () => {
	const client = postgres(env.MAIN_DB.connectionString);
	return drizzle({
		client,
		logger: isDev,
		schema: tables,
	});
};

export type DatabaseService = ReturnType<typeof getDatabase>;
