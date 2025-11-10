import { createORPCRouter } from "@/core/router/orpc";
import { FCMSpec } from "./fcm-spec";

const { priv } = createORPCRouter(FCMSpec);

export const FCMHandler = priv.router({
	subscribeToTopic: priv.subscribeToTopic.handler(
		async ({ context, input: { body } }) => {
			const res = await context.svc.firebase.subscribeToTopic(
				body.token,
				body.topic,
				context.user.id,
			);

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
			const res = await context.svc.firebase.unsubscribeFromTopic(
				body.token,
				body.topic,
				context.user.id,
			);

			return {
				status: 200,
				body: {
					message: "success",
					data: res,
				},
			};
		},
	),
	save: priv.save.handler(async ({ context, input: { body } }) => {
		await context.svc.firebase.saveToken(context.user.id, body.token);

		return {
			status: 200,
			body: {
				message: "success",
				data: { ok: true },
			},
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { body } }) => {
		await context.svc.firebase.deleteToken(body.token);

		return {
			status: 200,
			body: {
				message: "success",
				data: { ok: true },
			},
		};
	}),
});
