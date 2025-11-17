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

export const tables = {
	...configuration,
	...badge,
	...order,
	...coupon,
	...report,
	...review,
	...driver,
	...merchant,
	...wallet,
	...auth,
	...leaderboard,
	...notification,
	...payment,
	...payment,
	...transaction,
};
