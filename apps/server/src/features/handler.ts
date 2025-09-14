import { createHono } from "@/core/hono";
import { DriverHandler } from "./driver/handler";
import { MerchantHandler } from "./merchant/handler";
import { OrderHandler } from "./order/handler";

const h = createHono();

h.route("/drivers", DriverHandler);
h.route("/merchants", MerchantHandler);
h.route("/orders", OrderHandler);

export { h as AppHandler };
