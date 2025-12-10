import { m } from "@repo/i18n";
import { createORPCRouter } from "@/core/router/orpc";
import { UserLookupSpec } from "./user-lookup-spec";

const { priv } = createORPCRouter(UserLookupSpec);

export const UserLookupHandler = priv.router({
	byPhone: priv.byPhone.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.user.lookup.findByPhone(
			query.phone,
			context.user.id,
		);

		return {
			status: 200,
			body: {
				message: result ? m.server_user_found() : m.server_user_not_found(),
				data: result,
			},
		};
	}),
});
