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
	getUnreadCount: priv.getUnreadCount.handler(async ({ context }) => {
		const count = await context.repo.notification.getUnreadCount(
			context.user.id,
		);

		return {
			status: 200,
			body: {
				message: m.server_notifications_retrieved(),
				data: { count },
			},
		};
	}),
	markAsRead: priv.markAsRead.handler(
		async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const notification = await context.repo.notification.markAsRead(
					{
						id: params.id,
						userId: context.user.id,
					},
					{ tx },
				);

				return {
					status: 200,
					body: {
						message: m.server_notifications_retrieved(),
						data: notification,
					},
				};
			});
		},
	),
	markAllAsRead: priv.markAllAsRead.handler(async ({ context }) => {
		return await context.svc.db.transaction(async (tx) => {
			const count = await context.repo.notification.markAllAsRead(
				context.user.id,
				{ tx },
			);

			return {
				status: 200,
				body: {
					message: m.server_notifications_retrieved(),
					data: { count },
				},
			};
		});
	}),
	delete: priv.delete.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			await context.repo.notification.deleteNotification(
				{
					id: params.id,
					userId: context.user.id,
				},
				{ tx },
			);

			return {
				status: 200,
				body: {
					message: m.server_notifications_retrieved(),
					data: { ok: true },
				},
			};
		});
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
					data: {
						successCount: res.successCount,
						failureCount: res.failureCount,
						errors: res.errors,
					},
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
					data: {
						successCount: res.successCount,
						failureCount: res.failureCount,
						errors: res.errors,
					},
				},
			};
		},
	),
	saveToken: priv.saveToken.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			await context.repo.notification.saveToken(
				{
					...data,
					userId: context.user.id,
				},
				{ tx },
			);

			return {
				status: 200,
				body: {
					message: m.server_notification_token_saved(),
					data: { ok: true },
				},
			};
		});
	}),
	removeToken: priv.removeToken.handler(
		async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				await context.repo.notification.removeByToken(params, { tx });

				return {
					status: 200,
					body: {
						message: m.server_notification_token_removed(),
						data: { ok: true },
					},
				};
			});
		},
	),
});
