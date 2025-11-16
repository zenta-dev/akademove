import { oc } from "@orpc/contract";
import { BadgeMainSpec } from "./main/badge-main-spec";

export const BadgeSpec = oc.router({
	...BadgeMainSpec,
});
