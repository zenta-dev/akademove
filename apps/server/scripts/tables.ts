import * as auth from "@/core/tables/auth";
import * as configuration from "@/core/tables/configuration";
import * as coupon from "@/core/tables/coupon";
import * as driver from "@/core/tables/driver";
import * as merchant from "@/core/tables/merchant";
import * as order from "@/core/tables/order";
import * as report from "@/core/tables/report";
import * as review from "@/core/tables/review";
import * as wallet from "@/core/tables/wallet";

export const tables = {
	...configuration,
	...order,
	...coupon,
	...report,
	...review,
	...driver,
	...merchant,
	...wallet,
	...auth,
};
