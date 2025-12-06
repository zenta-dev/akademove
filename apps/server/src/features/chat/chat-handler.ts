import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { ChatSpec } from "./chat-spec";

const { priv } = createORPCRouter(ChatSpec);

export const ChatHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.chat.listMessages(query);

		return {
			status: 200,
			body: {
				message: m.server_chat_messages_retrieved(),
				data: result,
			},
		};
	}),
	send: priv.send.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.chat.create(
				{ ...data, userId: context.user.id },
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_message_sent(), data: result },
			};
		});
	}),
});
