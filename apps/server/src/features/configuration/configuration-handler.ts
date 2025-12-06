import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { ConfigurationSpec } from "./configuration-spec";
import { BusinessConfigurationService } from "./services";

const { pub, priv } = createORPCRouter(ConfigurationSpec);

export const ConfigurationHandler = pub.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.configuration.list(query);
		return {
			status: 200,
			body: {
				message: m.server_configurations_retrieved(),
				data: result,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.configuration.get(params.key);
		return {
			status: 200,
			body: {
				message: m.server_configuration_retrieved(),
				data: result,
			},
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
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
	/**
	 * Public endpoint to get business configuration.
	 * Accessible without authentication.
	 */
	getBusinessConfig: pub.getBusinessConfig.handler(async ({ context }) => {
		const config = await BusinessConfigurationService.getConfig(
			context.svc.db,
			context.svc.kv,
		);
		return {
			status: 200,
			body: {
				message: m.server_configuration_retrieved(),
				data: config,
			},
		};
	}),
});
