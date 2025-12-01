import { oc } from "@orpc/contract";
import { implement, type RouterClient } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { AuthHandler } from "./auth/auth-handler";
import { AuthSpec } from "./auth/auth-spec";
import { BadgeHandler } from "./badge/badge-handler";
import { BadgeSpec } from "./badge/badge-spec";
import { ChatHandler } from "./chat/chat-handler";
import { ChatSpec } from "./chat/chat-spec";
import { ConfigurationHandler } from "./configuration/configuration-handler";
import { ConfigurationSpec } from "./configuration/configuration-spec";
import { CouponHandler } from "./coupon/coupon-handler";
import { CouponSpec } from "./coupon/coupon-spec";
import { DriverHandler } from "./driver/driver-handler";
import { DriverSpec } from "./driver/driver-spec";
import { EmergencyHandler } from "./emergency/emergency-handler";
import { EmergencySpec } from "./emergency/emergency-spec";
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
	auth: oc.prefix("/auth").router(AuthSpec),
	badge: oc.prefix("/badges").router(BadgeSpec),
	chat: oc.prefix("/chat").router(ChatSpec),
	configuration: oc.prefix("/configurations").router(ConfigurationSpec),
	driver: oc.prefix("/drivers").router(DriverSpec),
	emergency: oc.prefix("/emergencies").router(EmergencySpec),
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
	auth: AuthHandler,
	badge: BadgeHandler,
	chat: ChatHandler,
	configuration: ConfigurationHandler,
	driver: DriverHandler,
	emergency: EmergencyHandler,
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
