import { createORPCRouter } from "@/core/router/orpc";
import { BadgeSpec } from "./badge-spec";
import { BadgeMainHandler } from "./main/badge-main-handler";
import { UserBadgeHandler } from "./user/user-badge-handler";

const { priv } = createORPCRouter(BadgeSpec);

export const BadgeHandler = priv.router({
	...BadgeMainHandler,
	user: UserBadgeHandler,
});
