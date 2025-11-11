import { createORPCRouter } from "@/core/router/orpc";
import { FCMSpec } from "./fcm-spec";

const { priv } = createORPCRouter(FCMSpec);

export const FCMHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.notification.list({
			...query,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: {
				message: "success",
				data: rows,
				totalPages,
			},
		};
	}),
	subscribeToTopic: priv.subscribeToTopic.handler(
		async ({ context, input: { body } }) => {
			const res = await context.repo.notification.subscribeToTopic({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: {
					message: "success",
					data: res,
				},
			};
		},
	),
	unsubscribeToTopic: priv.unsubscribeToTopic.handler(
		async ({ context, input: { body } }) => {
			const res = await context.repo.notification.unsubscribeFromTopic({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: {
					message: "success",
					data: res,
				},
			};
		},
	),
	saveToken: priv.saveToken.handler(async ({ context, input: { body } }) => {
		await context.repo.notification.saveToken({
			...body,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: {
				message: "success",
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
					message: "success",
					data: { ok: true },
				},
			};
		},
	),
});
