import { oc } from "@orpc/contract";
import { implement, type RouterClient } from "@orpc/server";
import type { ORPCCOntext } from "@/core/orpc";
import { ConfigurationHandler } from "./configuration/handler";
import { ConfigurationSpec } from "./configuration/spec";
import { DriverHandler } from "./driver/handler";
import { DriverSpec } from "./driver/spec";
import { MerchantHandler } from "./merchant/handler";
import { MerchantSpec } from "./merchant/spec";
import { OrderHandler } from "./order/handler";
import { OrderSpec } from "./order/spec";
import { PromoHandler } from "./promo/handler";
import { PromoSpec } from "./promo/spec";
import { ReportHandler } from "./report/handler";
import { ReportSpec } from "./report/spec";
import { ReviewHandler } from "./review/handler";
import { ReviewSpec } from "./review/spec";
import { ScheduleHandler } from "./schedule/handler";
import { ScheduleSpec } from "./schedule/spec";
import { UserHandler } from "./user/handler";
import { UserSpec } from "./user/spec";

export const ServerSpec = oc.router({
	configuration: oc.prefix("/configurations").router(ConfigurationSpec),
	driver: oc.prefix("/drivers").router(DriverSpec),
	merchant: oc.prefix("/merchants").router(MerchantSpec),
	order: oc.prefix("/orders").router(OrderSpec),
	promo: oc.prefix("/promos").router(PromoSpec),
	report: oc.prefix("/reports").router(ReportSpec),
	review: oc.prefix("/reviews").router(ReviewSpec),
	schedule: oc.prefix("/schedules").router(ScheduleSpec),
	user: oc.prefix("/users").router(UserSpec),
});

const os = implement(ServerSpec).$context<ORPCCOntext>();
export const ServerRouter = os.router({
	configuration: ConfigurationHandler,
	driver: DriverHandler,
	merchant: MerchantHandler,
	order: OrderHandler,
	promo: PromoHandler,
	report: ReportHandler,
	review: ReviewHandler,
	schedule: ScheduleHandler,
	user: UserHandler,
});

export type ServerSpecClient = RouterClient<typeof ServerRouter>;
