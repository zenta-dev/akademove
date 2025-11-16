import { oc } from "@orpc/contract";
import { BadgeMainSpec } from "./main/badge-main-spec";
import { UserBadgeSpec } from "./user/user-badge-spec";

export const BadgeSpec = oc.router({
	...BadgeMainSpec,
	user: oc.prefix("/user").router(UserBadgeSpec),
});
