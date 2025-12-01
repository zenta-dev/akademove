import { AuthSchemaRegistries } from "./auth.ts";
import { BadgeSchemaRegistries } from "./badge.ts";
import { ChatSchemaRegistries } from "./chat.ts";
import { CommonSchemaRegistries, type SchemaRegistries } from "./common.ts";
import { ConfigurationSchemaRegistries } from "./configuration.ts";
import { CouponSchemaRegistries } from "./coupon.ts";
import { DriverSchemaRegistries } from "./driver.ts";
import { EmergencySchemaRegistries } from "./emergency.ts";
import { LeaderboardSchemaRegistries } from "./leaderboard.ts";
import { MerchantSchemaRegistries } from "./merchant.ts";
import { NotificationSchemaRegistries } from "./notification.ts";
import { OrderSchemaRegistries } from "./order.ts";
import { PaginationSchemaRegistries } from "./pagination.ts";
import { PaymentSchemaRegistries } from "./payment.ts";
import { PositionSchemaRegistries } from "./position.ts";
import { ReportSchemaRegistries } from "./report.ts";
import { ReviewSchemaRegistries } from "./review.ts";
import { TransactionSchemaRegistries } from "./transaction.ts";
import { UserSchemaRegistries } from "./user.ts";
import { WalletSchemaRegistries } from "./wallet.ts";
import { WSSchemaRegistries } from "./ws.ts";

export const AllSchemaRegistries = {
	...CommonSchemaRegistries,
	...AuthSchemaRegistries,
	...BadgeSchemaRegistries,
	...ChatSchemaRegistries,
	...ConfigurationSchemaRegistries,
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
	...WalletSchemaRegistries,
	...TransactionSchemaRegistries,
	...PaginationSchemaRegistries,
	...NotificationSchemaRegistries,
	...WSSchemaRegistries,
} satisfies SchemaRegistries;
