import * as accountDeletion from "@/core/tables/account-deletion";
import * as auth from "@/core/tables/auth";
import * as badge from "@/core/tables/badge";
import * as broadcast from "@/core/tables/broadcast";
import * as chat from "@/core/tables/chat";
import * as configuration from "@/core/tables/configuration";
import * as contact from "@/core/tables/contact";
import * as coupon from "@/core/tables/coupon";
import * as driver from "@/core/tables/driver";
import * as driverQuizAnswer from "@/core/tables/driver-quiz-answer";
import * as driverQuizQuestion from "@/core/tables/driver-quiz-question";
import * as emergency from "@/core/tables/emergency";
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
	...accountDeletion,
	...auth,
	...badge,
	...broadcast,
	...chat,
	...configuration,
	...contact,
	...coupon,
	...driver,
	...driverQuizAnswer,
	...driverQuizQuestion,
	...emergency,
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
