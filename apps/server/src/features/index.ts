import { oc } from "@orpc/contract";
import { implement, type RouterClient } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { AccountDeletionHandler } from "./account-deletion/account-deletion-handler";
import { AccountDeletionSpec } from "./account-deletion/account-deletion-spec";
import { AnalyticsHandler } from "./analytics/analytics-handler";
import { AnalyticsSpec } from "./analytics/analytics-spec";
import { AuditHandler } from "./audit/audit-handler";
import { AuditSpec } from "./audit/audit-spec";
import { AuthHandler } from "./auth/auth-handler";
import { AuthSpec } from "./auth/auth-spec";
import { BadgeHandler } from "./badge/badge-handler";
import { BadgeSpec } from "./badge/badge-spec";
import { BankHandler } from "./bank/bank-handler";
import { BankSpec } from "./bank/bank-spec";
import { BannerHandler } from "./banner/banner-handler";
import { BannerSpec } from "./banner/banner-spec";
import { BroadcastHandler } from "./broadcast/broadcast-handler";
import { BroadcastSpec } from "./broadcast/broadcast-spec";
import { ChatHandler } from "./chat/chat-handler";
import { ChatSpec } from "./chat/chat-spec";
import { ConfigurationHandler } from "./configuration/configuration-handler";
import { ConfigurationSpec } from "./configuration/configuration-spec";
import { ContactHandler } from "./contact/contact-handler";
import { ContactSpec } from "./contact/contact-spec";
import { CouponHandler } from "./coupon/coupon-handler";
import { CouponSpec } from "./coupon/coupon-spec";
import { DriverHandler } from "./driver/driver-handler";
import { DriverSpec } from "./driver/driver-spec";
import { DriverQuizAnswerHandler } from "./driver-quiz-answer/driver-quiz-answer-handler";
import { DriverQuizAnswerSpec } from "./driver-quiz-answer/driver-quiz-answer-spec";
import { DriverQuizQuestionHandler } from "./driver-quiz-question/driver-quiz-question-handler";
import { DriverQuizQuestionSpec } from "./driver-quiz-question/driver-quiz-question-spec";
import { EmergencyHandler } from "./emergency/emergency-handler";
import { EmergencySpec } from "./emergency/emergency-spec";
import { FraudHandler } from "./fraud/fraud-handler";
import { FraudSpec } from "./fraud/fraud-spec";
import { LeaderboardHandler } from "./leaderboard/leaderboard-handler";
import { LeaderboardSpec } from "./leaderboard/leaderboard-spec";
import { MerchantHandler } from "./merchant/merchant-handler";
import { MerchantSpec } from "./merchant/merchant-spec";
import { NotificationHandler } from "./notification/notification-handler";
import { NotificationSpec } from "./notification/notification-spec";
import { OrderHandler } from "./order/order-handler";
import { OrderSpec } from "./order/order-spec";
import { PaymentHandler } from "./payment/payment-handler";
import { PaymentSpec } from "./payment/payment-spec";
import { QuickMessageHandler } from "./quick-message/quick-message-handler";
import { QuickMessageSpec } from "./quick-message/quick-message-spec";
import { ReportHandler } from "./report/report-handler";
import { ReportSpec } from "./report/report-spec";
import { ReviewHandler } from "./review/review-handler";
import { ReviewSpec } from "./review/review-spec";
import { TransactionHandler } from "./transaction/transaction-handler";
import { TransactionSpec } from "./transaction/transaction-spec";
import { UserHandler } from "./user/user-handler";
import { UserSpec } from "./user/user-spec";
import { WalletHandler } from "./wallet/wallet-handler";
import { WalletSpec } from "./wallet/wallet-spec";

export const FetchServerSpec = oc.router({
	accountDeletion: oc.prefix("/account-deletion").router(AccountDeletionSpec),
	analytics: oc.prefix("/analytics").router(AnalyticsSpec),
	audit: oc.prefix("/audit-logs").router(AuditSpec),
	auth: oc.prefix("/auth").router(AuthSpec),
	badge: oc.prefix("/badges").router(BadgeSpec),
	bank: oc.prefix("/bank").router(BankSpec),
	banner: oc.prefix("/banners").router(BannerSpec),
	broadcast: oc.prefix("/broadcasts").router(BroadcastSpec),
	chat: oc.prefix("/chat").router(ChatSpec),
	configuration: oc.prefix("/configurations").router(ConfigurationSpec),
	contact: oc.prefix("/contacts").router(ContactSpec),
	quickMessage: oc.prefix("/quick-messages").router(QuickMessageSpec),
	driver: oc.prefix("/drivers").router(DriverSpec),
	driverQuizQuestion: oc
		.prefix("/driver-quiz-questions")
		.router(DriverQuizQuestionSpec),
	driverQuizAnswer: oc
		.prefix("/driver-quiz-answers")
		.router(DriverQuizAnswerSpec),
	emergency: oc.prefix("/emergencies").router(EmergencySpec),
	fraud: oc.prefix("/fraud").router(FraudSpec),
	leaderboard: oc.prefix("/leaderboards").router(LeaderboardSpec),
	merchant: oc.prefix("/merchants").router(MerchantSpec),
	order: oc.prefix("/orders").router(OrderSpec),
	payment: oc.prefix("/payments").router(PaymentSpec),
	coupon: oc.prefix("/coupons").router(CouponSpec),
	report: oc.prefix("/reports").router(ReportSpec),
	review: oc.prefix("/reviews").router(ReviewSpec),
	transaction: oc.prefix("/transactions").router(TransactionSpec),
	user: oc.prefix("/users").router(UserSpec),
	wallet: oc.prefix("/wallets").router(WalletSpec),
	notification: oc.prefix("/notifications").router(NotificationSpec),
});

const os = implement(FetchServerSpec).$context<ORPCContext>();
export const FetchServerRouter = os.router({
	accountDeletion: AccountDeletionHandler,
	analytics: AnalyticsHandler,
	audit: AuditHandler,
	auth: AuthHandler,
	badge: BadgeHandler,
	bank: BankHandler,
	banner: BannerHandler,
	broadcast: BroadcastHandler,
	chat: ChatHandler,
	configuration: ConfigurationHandler,
	contact: ContactHandler,
	quickMessage: QuickMessageHandler,
	driver: DriverHandler,
	driverQuizQuestion: DriverQuizQuestionHandler,
	driverQuizAnswer: DriverQuizAnswerHandler,
	emergency: EmergencyHandler,
	fraud: FraudHandler,
	leaderboard: LeaderboardHandler,
	merchant: MerchantHandler,
	order: OrderHandler,
	payment: PaymentHandler,
	coupon: CouponHandler,
	report: ReportHandler,
	review: ReviewHandler,
	transaction: TransactionHandler,
	user: UserHandler,
	wallet: WalletHandler,
	notification: NotificationHandler,
});

export type ServerSpecClient = RouterClient<typeof FetchServerRouter>;
