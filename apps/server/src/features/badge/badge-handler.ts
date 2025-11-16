import { createORPCRouter } from "@/core/router/orpc";
import { BadgeSpec } from "./badge-spec";
import { BadgeMainHandler } from "./main/badge-main-handler";

const { priv } = createORPCRouter(BadgeSpec);

export const BadgeHandler = priv.router({
	...BadgeMainHandler,
});
