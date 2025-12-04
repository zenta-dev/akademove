import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { NotificationSpec } from "./notification-spec";

const { priv } = createORPCRouter(NotificationSpec);

export const NotificationHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.notification.list({
			...query,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: {
				message: m.server_notifications_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	subscribeToTopic: priv.subscribeToTopic.handler(
		async ({ context, input: { body } }) => {
			const data = trimObjectValues(body);
			const res = await context.repo.notification.subscribeToTopic({
				...data,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: {
					message: m.server_notification_subscribed(),
					data: res,
				},
			};
		},
	),
	unsubscribeToTopic: priv.unsubscribeToTopic.handler(
		async ({ context, input: { body } }) => {
			const data = trimObjectValues(body);
			const res = await context.repo.notification.unsubscribeFromTopic({
				...data,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: {
					message: m.server_notification_unsubscribed(),
					data: res,
				},
			};
		},
	),
	saveToken: priv.saveToken.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);
		await context.repo.notification.saveToken({
			...data,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: {
				message: m.server_notification_token_saved(),
				data: { ok: true },
			},
		};
	}),
	removeToken: priv.removeToken.handler(
		async ({ context, input: { params } }) => {
			await context.repo.notification.removeByToken(params);

			return {
				status: 200,
				body: {
					message: m.server_notification_token_removed(),
					data: { ok: true },
				},
			};
		},
	),
});
