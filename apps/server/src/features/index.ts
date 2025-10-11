import { oc } from "@orpc/contract";
import { implement, type RouterClient } from "@orpc/server";
import { clientMiddleware } from "@/core/middlewares/client";
import type { ORPCContext } from "@/core/orpc";
import { AuthHandler } from "./auth/handler";
import { AuthSpec } from "./auth/spec";
import { ConfigurationHandler } from "./configuration/handler";
import { ConfigurationSpec } from "./configuration/spec";
import { CouponHandler } from "./coupon/handler";
import { CouponSpec } from "./coupon/spec";
import { DriverHandler } from "./driver/handler";
import { DriverSpec } from "./driver/spec";
import { MerchantHandler } from "./merchant/handler";
import { MerchantSpec } from "./merchant/spec";
import { OrderHandler } from "./order/handler";
import { OrderSpec } from "./order/spec";
import { ReportHandler } from "./report/handler";
import { ReportSpec } from "./report/spec";
import { ReviewHandler } from "./review/handler";
import { ReviewSpec } from "./review/spec";
import { ScheduleHandler } from "./schedule/handler";
import { ScheduleSpec } from "./schedule/spec";
import { UserHandler } from "./user/handler";
import { UserSpec } from "./user/spec";

export const ServerSpec = oc.router({
	auth: oc.prefix("/auth").router(AuthSpec),
	configuration: oc.prefix("/configurations").router(ConfigurationSpec),
	driver: oc.prefix("/drivers").router(DriverSpec),
	merchant: oc.prefix("/merchants").router(MerchantSpec),
	order: oc.prefix("/orders").router(OrderSpec),
	coupon: oc.prefix("/coupons").router(CouponSpec),
	report: oc.prefix("/reports").router(ReportSpec),
	review: oc.prefix("/reviews").router(ReviewSpec),
	schedule: oc.prefix("/schedules").router(ScheduleSpec),
	user: oc.prefix("/users").router(UserSpec),
});

const os = implement(ServerSpec).$context<ORPCContext>().use(clientMiddleware);
export const ServerRouter = os.router({
	auth: AuthHandler,
	configuration: ConfigurationHandler,
	driver: DriverHandler,
	merchant: MerchantHandler,
	order: OrderHandler,
	coupon: CouponHandler,
	report: ReportHandler,
	review: ReviewHandler,
	schedule: ScheduleHandler,
	user: UserHandler,
});

export type ServerSpecClient = RouterClient<typeof ServerRouter>;
