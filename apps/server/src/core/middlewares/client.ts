import { os } from "@orpc/server";
import { ClientAgentSchema } from "@repo/schema/common";
import type { ORPCContext } from "../orpc";

export const clientMiddleware = os
	.$context<ORPCContext>()
	.middleware(async ({ context, next }) => {
		const agent = await ClientAgentSchema.safeParseAsync(
			context.req.headers.get("X-Client-Agent"),
		);
		return await next({
			context: {
				clientAgent: agent.data ?? "unknown",
			},
		});
	});
