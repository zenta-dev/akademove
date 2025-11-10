import { createORPCRouter } from "@/core/router/orpc";
import { DriverSpec } from "./driver-spec";
import { DriverMainHandler } from "./main/driver-main-handler";
import { DriverScheduleHandler } from "./schedule/driver-schedule-handler";

const { priv } = createORPCRouter(DriverSpec);

export const DriverHandler = priv.router({
	...DriverMainHandler,
	schedule: DriverScheduleHandler,
});
