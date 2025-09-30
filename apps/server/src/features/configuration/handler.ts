import { implement } from "@orpc/server";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { ConfigurationSpec } from "./spec";

const os = implement(ConfigurationSpec)
	.$context<ORPCCOntext>()
	.use(authMiddleware);

export const ConfigurationHandler = os.router({
	list: os.list
		.use(hasPermission({ configurations: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.configuration.list(query);
			return {
				status: 200,
				body: {
					message: "Successfully retrieved configurations data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ configurations: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.configuration.get(params.key);
			return {
				status: 200,
				body: {
					message: "Successfully retrieved configuration data",
					data: result,
				},
			};
		}),
	update: os.update
		.use(hasPermission({ configurations: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.configuration.update(params.key, body);
			return {
				status: 200,
				body: { message: "Configuration updated successfully", data: result },
			};
		}),
});
