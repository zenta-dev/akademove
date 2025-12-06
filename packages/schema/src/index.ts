import { AccountDeletionSchemaRegistries } from "./account-deletion.js";
import { AuthSchemaRegistries } from "./auth.js";
import { BadgeSchemaRegistries } from "./badge.js";
import { BroadcastSchemaRegistries } from "./broadcast.js";
import { CartSchemaRegistries } from "./cart.js";
import { ChatSchemaRegistries } from "./chat.js";
import { CommonSchemaRegistries, type SchemaRegistries } from "./common.js";
import { ConfigurationSchemaRegistries } from "./configuration.js";
import { ContactSchemaRegistries } from "./contact.js";
import { CouponSchemaRegistries } from "./coupon.js";
import { DriverSchemaRegistries } from "./driver.js";
import { DriverQuizAnswerSchemaRegistries } from "./driver-quiz-answer.js";
import { DriverQuizQuestionSchemaRegistries } from "./driver-quiz-question.js";
import { EmergencySchemaRegistries } from "./emergency.js";
import { LeaderboardSchemaRegistries } from "./leaderboard.js";
import { MerchantSchemaRegistries } from "./merchant.js";
import { NewsletterSchemaRegistries } from "./newsletter.js";
import { OrderSchemaRegistries } from "./order.js";
import { PaginationSchemaRegistries } from "./pagination.js";
import { PaymentSchemaRegistries } from "./payment.js";
import { PositionSchemaRegistries } from "./position.js";
import { QuickMessageSchemaRegistries } from "./quick-message.js";
import { ReportSchemaRegistries } from "./report.js";
import { ReviewSchemaRegistries } from "./review.js";
import { SupportChatSchemaRegistries } from "./support-chat.js";
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
	...DriverQuizAnswerSchemaRegistries,
	...DriverQuizQuestionSchemaRegistries,
	...DriverSchemaRegistries,
	...EmergencySchemaRegistries,
	...LeaderboardSchemaRegistries,
	...MerchantSchemaRegistries,
	...NewsletterSchemaRegistries,
	...BroadcastSchemaRegistries,
	...OrderSchemaRegistries,
	...PaymentSchemaRegistries,
	...PositionSchemaRegistries,
	...QuickMessageSchemaRegistries,
	...ReportSchemaRegistries,
	...ReviewSchemaRegistries,
	...SupportChatSchemaRegistries,
	...UserSchemaRegistries,
	...walletSchemaRegistries,
	...TransactionSchemaRegistries,
	...PaginationSchemaRegistries,
	...WSSchemaRegistries,
} satisfies SchemaRegistries;
export * from "./account-deletion.js";
export * from "./auth.js";
export * from "./badge.js";
export * from "./broadcast.js";
export * from "./cart.js";
export * from "./chat.js";
export * from "./common.js";
export * from "./configuration.js";
export * from "./constants.js";
export * from "./contact.js";
export * from "./coupon.js";
export * from "./driver.js";
export * from "./driver-quiz-answer.js";
export * from "./driver-quiz-question.js";
export * from "./emergency.js";
export * from "./leaderboard.js";
export * from "./merchant.js";
export * from "./newsletter.js";
export * from "./notification.js";
export * from "./order.js";
export * from "./pagination.js";
export * from "./payment.js";
export * from "./position.js";
export * from "./quick-message.js";
export * from "./report.js";
export * from "./review.js";
export * from "./support-chat.js";
export * from "./transaction.js";
export * from "./user.js";
export * from "./wallet.js";
export * from "./ws.js";
