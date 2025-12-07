import { oc } from "@orpc/contract";
import { DriverApprovalSpec } from "./approval/driver-approval-spec";
import { DriverMainSpec } from "./main/driver-main-spec";
import { DriverScheduleSpec } from "./schedule/driver-schedule-spec";

export const DriverSpec = oc.router({
	...DriverMainSpec,
	...DriverApprovalSpec,
	schedule: oc.prefix("/{driverId}/schedules").router(DriverScheduleSpec),
});
