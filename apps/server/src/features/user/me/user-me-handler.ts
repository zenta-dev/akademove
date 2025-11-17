import { unflattenData } from "@repo/schema/flatten.helper";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { UserMeSpec } from "./user-me-spec";

const { priv } = createORPCRouter(UserMeSpec);

export const UserMeHandler = priv.router({
	update: priv.update.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(unflattenData(body));

			const opts = { tx };
			const res = await context.repo.user.me.update(
				context.user.id,
				data,
				opts,
			);

			return {
				status: 200,
				body: { message: "success", data: res },
			};
		});
	}),
	changePassword: priv.changePassword.handler(
		async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);

				const opts = { tx };
				const res = await context.repo.user.me.changePassword(
					context.user.id,
					data,
					opts,
				);

				return {
					status: 200,
					body: { message: "success", data: res },
				};
			});
		},
	),
});
