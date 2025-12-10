import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { QuickMessageSpec } from "./quick-message-spec";

const { priv, pub } = createORPCRouter(QuickMessageSpec);

export const QuickMessageHandler = {
	// Public endpoint for users/drivers/merchants to list quick messages
	list: pub.list.handler(async ({ context, input: { query } }) => {
		const templates = await context.repo.quickMessage.listTemplates(query);

		return {
			status: 200,
			body: {
				message: m.server_quick_messages_retrieved(),
				data: { rows: templates },
			},
		};
	}),

	// Admin endpoints for managing templates
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const template = await context.repo.quickMessage.get(params.id);

		return {
			status: 200,
			body: {
				message: m.server_quick_message_retrieved(),
				data: template,
			},
		};
	}),

	create: priv.create.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const template = await context.repo.quickMessage.create(data, { tx });

			logger.info(
				{ templateId: template.id, role: template.role },
				"[QuickMessageHandler] Template created",
			);

			return {
				status: 200,
				body: {
					message: m.server_quick_message_created(),
					data: template,
				},
			};
		});
	}),

	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const template = await context.repo.quickMessage.update(params.id, data, {
				tx,
			});

			logger.info(
				{ templateId: params.id },
				"[QuickMessageHandler] Template updated",
			);

			return {
				status: 200,
				body: {
					message: m.server_quick_message_updated(),
					data: template,
				},
			};
		});
	}),

	delete: priv.delete.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			await context.repo.quickMessage.delete(params.id, { tx });

			logger.info(
				{ templateId: params.id },
				"[QuickMessageHandler] Template deleted",
			);

			return {
				status: 200,
				body: {
					message: m.server_quick_message_deleted(),
					data: { success: true },
				},
			};
		});
	}),
};
