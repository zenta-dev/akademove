import { ClientAgentSchema } from "@repo/schema/common";
import { createMiddleware } from "hono/factory";
import type { HonoContext } from "../interface";

export const honoClientAgentMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		const agent = await ClientAgentSchema.safeParseAsync(
			c.req.raw.headers.get("X-Client-Agent"),
		);
		c.set("clientAgent", agent.data ?? "unknown");
		return await next();
	},
);
