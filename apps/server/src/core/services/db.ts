import { env } from "cloudflare:workers";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as auth from "@/core/tables/auth";
import * as badge from "@/core/tables/badge";
import * as configuration from "@/core/tables/configuration";
import * as coupon from "@/core/tables/coupon";
import * as driver from "@/core/tables/driver";
import * as leaderboard from "@/core/tables/leaderboard";
import * as merchant from "@/core/tables/merchant";
import * as notification from "@/core/tables/notification";
import * as order from "@/core/tables/order";
import * as payment from "@/core/tables/payment";
import * as report from "@/core/tables/report";
import * as review from "@/core/tables/review";
import * as transaction from "@/core/tables/transaction";
import * as wallet from "@/core/tables/wallet";
import { isDev } from "@/utils";

export const tables = {
	...auth,
	...badge,
	...configuration,
	...coupon,
	...driver,
	...leaderboard,
	...merchant,
	...notification,
	...order,
	...payment,
	...report,
	...review,
	...transaction,
	...wallet,
};

export const getDatabase = () => {
	const client = postgres(isDev ? env.DB_URL : env.MAIN_DB.connectionString);
	return drizzle({
		client,
		logger: isDev,
		schema: tables,
	});
};

export type DatabaseService = ReturnType<typeof getDatabase>;
export type DatabaseTransaction = Parameters<
	Parameters<DatabaseService["transaction"]>["0"]
>["0"];
export type DatabaseName = keyof DatabaseService["query"];
