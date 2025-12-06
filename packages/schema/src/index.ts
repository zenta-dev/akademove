import { AccountDeletionSchemaRegistries } from "./account-deletion.js";
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
import { QuickMessageSchemaRegistries } from "./quick-message.js";
import { ReportSchemaRegistries } from "./report.js";
import { ReviewSchemaRegistries } from "./review.js";
import { TransactionSchemaRegistries } from "./transaction.js";
import { UserSchemaRegistries } from "./user.js";
import { walletSchemaRegistries } from "./wallet.js";
import { WSSchemaRegistries } from "./ws.js";

export const AllSchemaRegistries = {
	...CommonSchemaRegistries,
	...AccountDeletionSchemaRegistries,
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
	...QuickMessageSchemaRegistries,
	...ReportSchemaRegistries,
	...ReviewSchemaRegistries,
	...UserSchemaRegistries,
	...walletSchemaRegistries,
	...TransactionSchemaRegistries,
	...PaginationSchemaRegistries,
	...NotificationSchemaRegistries,
	...WSSchemaRegistries,
} satisfies SchemaRegistries;
export * from "./account-deletion.js";
export * from "./auth.js";
export * from "./badge.js";
export * from "./cart.js";
export * from "./chat.js";
export * from "./common.js";
export * from "./configuration.js";
export * from "./constants.js";
export * from "./contact.js";
export * from "./coupon.js";
export * from "./driver.js";
export * from "./emergency.js";
export * from "./leaderboard.js";
export * from "./merchant.js";
export * from "./notification.js";
export * from "./order.js";
export * from "./pagination.js";
export * from "./payment.js";
export * from "./position.js";
export * from "./quick-message.js";
export * from "./report.js";
export * from "./review.js";
export * from "./transaction.js";
export * from "./user.js";
export * from "./wallet.js";
export * from "./ws.js";
