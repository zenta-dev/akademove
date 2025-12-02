import { AuthSchemaRegistries } from "./auth.js";
import { BadgeSchemaRegistries } from "./badge.js";
import { CartSchemaRegistries } from "./cart.js";
import { ChatSchemaRegistries } from "./chat.js";
import { CommonSchemaRegistries, type SchemaRegistries } from "./common.js";
import { ConfigurationSchemaRegistries } from "./configuration.js";
import { ContactSchemaRegistries } from "./contact.js";
import { CouponSchemaRegistries } from "./coupon.js";
import { DriverSchemaRegistries } from "./driver.js";
import { EmergencySchemaRegistries } from "./emergency.js";
import { LeaderboardSchemaRegistries } from "./leaderboard.js";
import { MerchantSchemaRegistries } from "./merchant.js";
import { NotificationSchemaRegistries } from "./notification.js";
import { OrderSchemaRegistries } from "./order.js";
import { PaginationSchemaRegistries } from "./pagination.js";
import { PaymentSchemaRegistries } from "./payment.js";
import { PositionSchemaRegistries } from "./position.js";
import { ReportSchemaRegistries } from "./report.js";
import { ReviewSchemaRegistries } from "./review.js";
import { TransactionSchemaRegistries } from "./transaction.js";
import { UserSchemaRegistries } from "./user.js";
import { walletSchemaRegistries } from "./wallet.js";
import { WSSchemaRegistries } from "./ws.js";

export const AllSchemaRegistries = {
	...CommonSchemaRegistries,
	...AuthSchemaRegistries,
	...BadgeSchemaRegistries,
	...CartSchemaRegistries,
	...ChatSchemaRegistries,
	...ConfigurationSchemaRegistries,
	...ContactSchemaRegistries,
	...CouponSchemaRegistries,
	...DriverSchemaRegistries,
	...EmergencySchemaRegistries,
	...LeaderboardSchemaRegistries,
	...MerchantSchemaRegistries,
	...OrderSchemaRegistries,
	...PaymentSchemaRegistries,
	...PositionSchemaRegistries,
	...ReportSchemaRegistries,
	...ReviewSchemaRegistries,
	...UserSchemaRegistries,
	...walletSchemaRegistries,
	...TransactionSchemaRegistries,
	...PaginationSchemaRegistries,
	...NotificationSchemaRegistries,
	...WSSchemaRegistries,
} satisfies SchemaRegistries;
