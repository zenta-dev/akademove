import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { ConfigurationSpec } from "./configuration-spec";
import { BusinessConfigurationService } from "./services";

const { pub, priv } = createORPCRouter(ConfigurationSpec);

export const ConfigurationHandler = pub.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		// Only ADMIN and OPERATOR can list configurations
		if (context.user.role !== "ADMIN" && context.user.role !== "OPERATOR") {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

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
		// Only ADMIN and OPERATOR can get configuration details
		if (context.user.role !== "ADMIN" && context.user.role !== "OPERATOR") {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

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
		// Only ADMIN and OPERATOR can update configurations
		if (context.user.role !== "ADMIN" && context.user.role !== "OPERATOR") {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

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
