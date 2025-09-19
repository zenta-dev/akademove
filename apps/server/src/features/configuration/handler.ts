import { implement } from "@orpc/server";
import type { ORPCCOntext } from "@/core/orpc";
import { ConfigurationSpec } from "./spec";

const os = implement(ConfigurationSpec).$context<ORPCCOntext>();

export const ConfigurationHandler = os.router({
	list: os.list.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.configuration.list(query);
		return {
			status: 200,
			body: {
				message: "Successfully retrieved configurations data",
				data: result,
			},
		};
	}),
	get: os.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.configuration.get(params.key);
		return {
			status: 200,
			body: {
				message: "Successfully retrieved configuration data",
				data: result,
			},
		};
	}),
	update: os.update.handler(async ({ context, input: { params, body } }) => {
		const result = await context.repo.configuration.update(params.key, body);
		return {
			status: 200,
			body: { message: "Configuration updated successfully", data: result },
		};
	}),
});
