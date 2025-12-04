import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { ConfigurationSpec } from "./configuration-spec";

const { priv } = createORPCRouter(ConfigurationSpec);

export const ConfigurationHandler = priv.router({
	list: priv.list
		.use(hasPermission({ configurations: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.configuration.list(query);
			return {
				status: 200,
				body: {
					message: m.server_configurations_retrieved(),
					data: result,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ configurations: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.configuration.get(params.key);
			return {
				status: 200,
				body: {
					message: m.server_configuration_retrieved(),
					data: result,
				},
			};
		}),
	update: priv.update
		.use(hasPermission({ configurations: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.configuration.update(params.key, {
				...data,
				userId: context.user.id,
			});
			return {
				status: 200,
				body: { message: m.server_configuration_updated(), data: result },
			};
		}),
});
