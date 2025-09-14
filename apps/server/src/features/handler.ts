import { createHono } from "@/core/hono";
import { DriverHandler } from "./driver/handler";
import { MerchantHandler } from "./merchant/handler";
import { OrderHandler } from "./order/handler";
import { PromoHandler } from "./promo/handler";
import { ScheduleHandler } from "./schedule/handler";

const h = createHono();

h.route("/drivers", DriverHandler);
h.route("/merchants", MerchantHandler);
h.route("/orders", OrderHandler);
h.route("/schedules", ScheduleHandler);
h.route("/promos", PromoHandler);

export { h as AppHandler };
