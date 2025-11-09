import { env } from "cloudflare:workers";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as auth from "@/core/tables/auth";
import * as configuration from "@/core/tables/configuration";
import * as coupon from "@/core/tables/coupon";
import * as driver from "@/core/tables/driver";
import * as merchant from "@/core/tables/merchant";
import * as order from "@/core/tables/order";
import * as payment from "@/core/tables/payment";
import * as report from "@/core/tables/report";
import * as review from "@/core/tables/review";
import * as transaction from "@/core/tables/transaction";
import * as wallet from "@/core/tables/wallet";
import { isDev } from "@/utils";

export const tables = {
	...auth,
	...driver,
	...merchant,
	...order,
	...coupon,
	...report,
	...review,
	...configuration,
	...wallet,
	...payment,
	...transaction,
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
export type DatabaseTransaction = Parameters<
	Parameters<DatabaseService["transaction"]>["0"]
>["0"];
export type DatabaseName = keyof DatabaseService["query"];
export type DatabaseTables =
	| auth.UserTable
	| auth.AccountTable
	| auth.VerificationTable
	| configuration.ConfigurationTable
	| configuration.ConfigurationAuditLogTable
	| coupon.CouponTable
	| coupon.CouponAuditLogTable
	| coupon.CouponUsageTable
	| driver.DriverTable
	| driver.DriverScheduleTable
	| merchant.MerchantTable
	| merchant.MerchantMenuTable
	| order.OrderTable
	| payment.PaymentTable
	| report.ReportTable
	| report.ReportAuditLogTable
	| review.ReviewTable
	| transaction.TransactionTable
	| wallet.WalletTable;
