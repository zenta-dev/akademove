import { createHono } from "@/core/hono";
import { DriverHandler } from "./driver/handler";
import { MerchantHandler } from "./merchant/handler";
import { OrderHandler } from "./order/handler";
import { PromoHandler } from "./promo/handler";
import { ReportHandler } from "./report/handler";
import { ReviewHandler } from "./review/handler";
import { ScheduleHandler } from "./schedule/handler";
import { UserHandler } from "./user/handler";

const h = createHono()
	.route("/drivers", DriverHandler)
	.route("/merchants", MerchantHandler)
	.route("/orders", OrderHandler)
	.route("/schedules", ScheduleHandler)
	.route("/promos", PromoHandler)
	.route("/reports", ReportHandler)
	.route("/reviews", ReviewHandler)
	.route("/users", UserHandler);

export { h as AppHandler };
export type AppHandlerRoutes = typeof h;
