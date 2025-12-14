import { m } from "@repo/i18n";
import type { SupportChatEnvelope } from "@repo/schema/support-chat";
import { trimObjectValues } from "@repo/shared";
import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { SupportChatSpec } from "./support-chat-spec";
import { SupportChatRoom } from "./support-chat-ws";

const { priv } = createORPCRouter(SupportChatSpec);

export const SupportChatHandler = priv.router({
	// ==================== TICKET OPERATIONS ====================
	listTickets: priv.listTickets.handler(
		async ({ context, input: { query } }) => {
			// Users can only see their own tickets, admins/operators can see all
			const isSupport =
				context.user.role === "ADMIN" || context.user.role === "OPERATOR";

			const result = await context.repo.supportChat.listTickets({
				...query,
				// Non-support users can only see their own tickets
				userId: isSupport ? query.userId : context.user.id,
			});

			return {
				status: 200,
				body: {
					message: m.server_support_tickets_retrieved(),
					data: result,
				},
			};
		},
	),

	getTicket: priv.getTicket.handler(async ({ context, input: { params } }) => {
		const ticket = await context.repo.supportChat.getTicket(params.id);

		// Check if user has access to this ticket
		const isSupport =
			context.user.role === "ADMIN" || context.user.role === "OPERATOR";
		if (!isSupport && ticket.userId !== context.user.id) {
			throw new Error("You do not have access to this ticket");
		}

		return {
			status: 200,
			body: {
				message: m.server_support_ticket_retrieved(),
				data: ticket,
			},
		};
	}),

	createTicket: priv.createTicket.handler(
		async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const ticket = await context.repo.supportChat.createTicket(
					{ ...data, userId: context.user.id },
					{ tx },
				);

				logger.info(
					{ ticketId: ticket.id, userId: context.user.id },
					"[SupportChatHandler] Support ticket created",
				);

				return {
					status: 201,
					body: {
						message: m.server_support_ticket_created(),
						data: ticket,
					},
				};
			});
		},
	),

	updateTicket: priv.updateTicket
		.use(requireRoles("ADMIN", "OPERATOR"))
		.handler(async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const ticket = await context.repo.supportChat.updateTicket(
					params.id,
					data,
					{ tx },
				);

				// Broadcast ticket update to WebSocket room
				try {
					const stub = SupportChatRoom.getRoomStubByName(params.id);
					const broadcastPayload: SupportChatEnvelope = {
						e: "TICKET_UPDATED",
						f: "s",
						t: "c",
						p: {
							ticket,
							ticketId: params.id,
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
						{ ticketId: params.id },
						"[SupportChatHandler] Broadcast ticket update to WebSocket",
					);
				} catch (broadcastError) {
					logger.error(
						{ error: broadcastError, ticketId: params.id },
						"[SupportChatHandler] Failed to broadcast ticket update",
					);
				}

				return {
					status: 200,
					body: {
						message: m.server_support_ticket_updated(),
						data: ticket,
					},
				};
			});
		}),

	// ==================== MESSAGE OPERATIONS ====================
	listMessages: priv.listMessages.handler(
		async ({ context, input: { query } }) => {
			// Verify user has access to this ticket
			const isParticipant = await context.repo.supportChat.isTicketParticipant(
				query.ticketId,
				context.user.id,
			);
			const isSupport =
				context.user.role === "ADMIN" || context.user.role === "OPERATOR";

			if (!isParticipant && !isSupport) {
				throw new Error("You do not have access to this ticket");
			}

			const result = await context.repo.supportChat.listMessages(query);

			return {
				status: 200,
				body: {
					message: m.server_support_messages_retrieved(),
					data: result,
				},
			};
		},
	),

	sendMessage: priv.sendMessage.handler(
		async ({ context, input: { body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);

				// Verify user has access to this ticket
				const isParticipant =
					await context.repo.supportChat.isTicketParticipant(
						data.ticketId,
						context.user.id,
						{ tx },
					);
				const isSupport =
					context.user.role === "ADMIN" || context.user.role === "OPERATOR";

				if (!isParticipant && !isSupport) {
					throw new Error("You do not have access to this ticket");
				}

				// Verify ticket is not closed
				const ticket = await context.repo.supportChat.getTicket(data.ticketId, {
					tx,
				});
				if (ticket.status === "CLOSED") {
					throw new Error(m.error_ticket_closed());
				}

				const message = await context.repo.supportChat.createMessage(
					{
						...data,
						userId: context.user.id,
						isFromSupport: isSupport,
					},
					{ tx },
				);

				// Broadcast message to WebSocket room
				try {
					const stub = SupportChatRoom.getRoomStubByName(data.ticketId);
					const broadcastPayload: SupportChatEnvelope = {
						e: "NEW_MESSAGE",
						f: "s",
						t: "c",
						p: {
							message,
							ticketId: data.ticketId,
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
						{ messageId: message.id, ticketId: data.ticketId },
						"[SupportChatHandler] Broadcast message to WebSocket",
					);
				} catch (broadcastError) {
					logger.error(
						{
							error: broadcastError,
							messageId: message.id,
							ticketId: data.ticketId,
						},
						"[SupportChatHandler] Failed to broadcast message to WebSocket",
					);
				}

				// Send push notification to other participant
				try {
					const notifyUserId = isSupport ? ticket.userId : ticket.assignedToId;

					if (notifyUserId) {
						await context.repo.notification.sendNotificationToUserId({
							fromUserId: context.user.id,
							toUserId: notifyUserId,
							title: isSupport ? "Support Reply" : "New Support Message",
							body: message.message.slice(0, 100),
							data: {
								type: "SUPPORT_CHAT",
								ticketId: data.ticketId,
								deeplink: `akademove://support/ticket/${data.ticketId}`,
							},
						});
					}
				} catch (notifyError) {
					logger.error(
						{ error: notifyError, ticketId: data.ticketId },
						"[SupportChatHandler] Failed to send push notification",
					);
				}

				return {
					status: 201,
					body: {
						message: m.server_message_sent(),
						data: message,
					},
				};
			});
		},
	),

	getUnreadCount: priv.getUnreadCount.handler(
		async ({ context, input: { query } }) => {
			const result = await context.repo.supportChat.getUnreadCount(
				query.ticketId,
				context.user.id,
			);

			return {
				status: 200,
				body: {
					message: m.server_unread_count_retrieved(),
					data: result,
				},
			};
		},
	),

	markAsRead: priv.markAsRead.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.supportChat.markMessagesAsRead(
				data.ticketId,
				context.user.id,
				{ tx },
			);

			// Broadcast read receipt to WebSocket room
			try {
				const stub = SupportChatRoom.getRoomStubByName(data.ticketId);
				const broadcastPayload: SupportChatEnvelope = {
					e: "MESSAGE_READ",
					f: "s",
					t: "c",
					p: {
						ticketId: data.ticketId,
						userId: context.user.id,
					},
				};

				await stub.fetch(
					new Request("http://internal/broadcast", {
						method: "POST",
						headers: { "Content-Type": "application/json" },
						body: JSON.stringify(broadcastPayload),
					}),
				);
			} catch (broadcastError) {
				logger.error(
					{ error: broadcastError, ticketId: data.ticketId },
					"[SupportChatHandler] Failed to broadcast read receipt",
				);
			}

			return {
				status: 200,
				body: {
					message: m.server_messages_marked_read(),
					data: result,
				},
			};
		});
	}),
});
