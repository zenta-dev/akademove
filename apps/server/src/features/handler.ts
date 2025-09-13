import { createHono } from "@/core/hono";
import { DriverHandler } from "./driver/handler";

const h = createHono();

h.route("/drivers", DriverHandler);

export { h as AppHandler };
