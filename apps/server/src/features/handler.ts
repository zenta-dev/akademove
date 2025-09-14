import { createHono } from "@/core/hono";
import { DriverHandler } from "./driver/handler";
import { MerchantHandler } from "./merchant/handler";

const h = createHono();

h.route("/drivers", DriverHandler);
h.route("/merchants", MerchantHandler);

export { h as AppHandler };
