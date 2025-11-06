import { oc } from "@orpc/contract";
import { implement, type RouterClient } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { AuthHandler } from "./auth/auth-handler";
import { AuthSpec } from "./auth/auth-spec";
import { ConfigurationHandler } from "./configuration/configuration-handler";
import { ConfigurationSpec } from "./configuration/configuration-spec";
import { CouponHandler } from "./coupon/coupon-handler";
import { CouponSpec } from "./coupon/coupon-spec";
import { DriverHandler } from "./driver/driver-handler";
import { DriverSpec } from "./driver/driver-spec";
import { MerchantHandler } from "./merchant/merchant-handler";
import { MerchantSpec } from "./merchant/merchant-spec";
import { OrderHandler } from "./order/order-handler";
import { OrderSpec } from "./order/order-spec";
import { ReportHandler } from "./report/report-handler";
import { ReportSpec } from "./report/report-spec";
import { ReviewHandler } from "./review/review-handler";
import { ReviewSpec } from "./review/review-spec";
import { DriverScheduleHandler } from "./schedule/schedule-handler";
import { DriverScheduleSpec } from "./schedule/schedule-spec";
import { UserHandler } from "./user/user-handler";
import { UserSpec } from "./user/user-spec";
import { WalletHandler } from "./wallet/wallet-handler";
import { WalletSpec } from "./wallet/wallet-spec";

export const FetchServerSpec = oc.router({
	auth: oc.prefix("/auth").router(AuthSpec),
	configuration: oc.prefix("/configurations").router(ConfigurationSpec),
	driver: oc.prefix("/drivers").router(DriverSpec),
	merchant: oc.prefix("/merchants").router(MerchantSpec),
	order: oc.prefix("/orders").router(OrderSpec),
	coupon: oc.prefix("/coupons").router(CouponSpec),
	report: oc.prefix("/reports").router(ReportSpec),
	review: oc.prefix("/reviews").router(ReviewSpec),
	driverSchedule: oc.prefix("/driver/schedules").router(DriverScheduleSpec),
	user: oc.prefix("/users").router(UserSpec),
	wallet: oc.prefix("/wallets").router(WalletSpec),
});

const os = implement(FetchServerSpec).$context<ORPCContext>();
export const FetchServerRouter = os.router({
	auth: AuthHandler,
	configuration: ConfigurationHandler,
	driver: DriverHandler,
	merchant: MerchantHandler,
	order: OrderHandler,
	coupon: CouponHandler,
	report: ReportHandler,
	review: ReviewHandler,
	driverSchedule: DriverScheduleHandler,
	user: UserHandler,
	wallet: WalletHandler,
});

export type ServerSpecClient = RouterClient<typeof FetchServerRouter>;
