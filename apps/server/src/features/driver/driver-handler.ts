import { createORPCRouter } from "@/core/router/orpc";
import { DriverApprovalHandler } from "./approval/driver-approval-handler";
import { DriverSpec } from "./driver-spec";
import { DriverMainHandler } from "./main/driver-main-handler";
import { DriverScheduleHandler } from "./schedule/driver-schedule-handler";

const { priv } = createORPCRouter(DriverSpec);

export const DriverHandler = priv.router({
	...DriverMainHandler,
	...DriverApprovalHandler,
	schedule: DriverScheduleHandler,
});
