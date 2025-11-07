import { oc } from "@orpc/contract";
import { DriverMainSpec } from "./main/driver-main-spec";
import { DriverScheduleSpec } from "./schedule/driver-schedule-spec";

export const DriverSpec = oc.router({
	...DriverMainSpec,
	schedule: oc.prefix("/{driverId}/schedules").router(DriverScheduleSpec),
});
