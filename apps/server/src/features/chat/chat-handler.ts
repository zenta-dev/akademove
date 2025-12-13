import { m } from "@repo/i18n";
import type { OrderEnvelope } from "@repo/schema/ws";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { OrderBaseRepository } from "@/features/order/repositories/order-base-repository";
import { logger } from "@/utils/logger";
import { ChatSpec } from "./chat-spec";

const { priv } = createORPCRouter(ChatSpec);

export const ChatHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.chat.listMessages({
			...query,
			userId: context.user.id,
		});

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

			// Broadcast the message to WebSocket room so other participants receive it in real-time
			try {
				const stub = OrderBaseRepository.getRoomStubByName(result.orderId);
				const broadcastPayload: OrderEnvelope = {
					e: "CHAT_MESSAGE",
					f: "s",
					t: "c",
					p: {
						message: {
							id: result.id,
							orderId: result.orderId,
							senderId: result.senderId,
							senderName: result.sender?.name ?? "Unknown",
							senderRole: result.sender?.role ?? "USER",
							message: result.message,
							sentAt: result.sentAt,
						},
					},
				};

				await stub.fetch(
					new Request("http://internal/broadcast", {
						method: "POST",
						headers: { "Content-Type": "application/json" },
						body: JSON.stringify(broadcastPayload),
					}),
				);

				logger.info(
					{
						messageId: result.id,
						orderId: result.orderId,
						senderId: result.senderId,
					},
					"[ChatHandler] Broadcast chat message to WebSocket room",
				);
			} catch (broadcastError) {
				// Log but don't fail the request - message is already saved to DB
				logger.error(
					{
						error: broadcastError,
						messageId: result.id,
						orderId: result.orderId,
					},
					"[ChatHandler] Failed to broadcast chat message to WebSocket",
				);
			}

			return {
				status: 200,
				body: { message: m.server_message_sent(), data: result },
			};
		});
	}),
});
