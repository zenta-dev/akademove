import { env } from "cloudflare:workers";
import {
	type SupportChatEnvelope,
	SupportChatEnvelopeSchema,
} from "@repo/schema/support-chat";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import type { DatabaseTransaction } from "@/core/services/db";
import { logger } from "@/utils/logger";

export class SupportChatRoom extends BaseDurableObject {
	#svc: ServiceContext;
	#repo: RepositoryContext;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
		this.#repo = getRepositories(this.#svc, getManagers());
	}

	/**
	 * Get the Durable Object stub by ticket ID
	 */
	static getRoomStubByName(ticketId: string) {
		const id = env.SUPPORT_CHAT.idFromName(ticketId);
		return env.SUPPORT_CHAT.get(id);
	}

	broadcast(message: SupportChatEnvelope, opts?: BroadcastOptions): void {
		const parse = SupportChatEnvelopeSchema.safeParse(message);
		if (!parse.success) {
			logger.warn(parse, "[SupportChatRoom] Invalid WS message");
			return;
		}
		super.broadcast(parse.data, opts);
	}

	/**
	 * Handle HTTP requests and WebSocket upgrades
	 * Supports POST /broadcast for REST API to trigger WebSocket broadcasts
	 */
	async fetch(request: Request): Promise<Response> {
		const url = new URL(request.url);

		// Handle broadcast requests from REST API handlers
		if (request.method === "POST" && url.pathname.endsWith("/broadcast")) {
			try {
				const body = (await request.json()) as SupportChatEnvelope;
				this.broadcast(body);
				return new Response(JSON.stringify({ success: true }), {
					status: 200,
					headers: { "Content-Type": "application/json" },
				});
			} catch (error) {
				logger.error(
					{ error },
					"[SupportChatRoom] Failed to broadcast message",
				);
				return new Response(
					JSON.stringify({ success: false, error: "Failed to broadcast" }),
					{ status: 500, headers: { "Content-Type": "application/json" } },
				);
			}
		}

		// Default: handle WebSocket upgrade
		return super.fetch(request);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);
		const session = this.findUserIdBySocket(ws);
		if (!session) throw new Error("Session not found");

		const { success, data } = await SupportChatEnvelopeSchema.safeParseAsync(
			JSON.parse(message.toString()),
		);
		if (!success) {
			logger.warn(data, "[SupportChatRoom] Invalid WS message format");
			return;
		}

		if (data.t === "s" && data.a !== undefined) {
			try {
				if (data.a === "SEND_MESSAGE") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleSendMessage(ws, data, tx),
					);
				}
				if (data.a === "MARK_READ") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleMarkRead(ws, data, tx),
					);
				}
				if (data.a === "START_TYPING") {
					this.#handleTyping(ws, data, true);
				}
				if (data.a === "STOP_TYPING") {
					this.#handleTyping(ws, data, false);
				}
			} catch (error) {
				logger.error(
					{ error, action: data.a, userId: session },
					"[SupportChatRoom] WebSocket message handler failed - transaction rolled back",
				);
				ws.close(1011, "An error occurred while processing your request");
			}
		}
	}

	async #handleSendMessage(
		ws: WebSocket,
		data: SupportChatEnvelope,
		tx: DatabaseTransaction,
	) {
		const userId = this.findUserIdBySocket(ws);
		if (!userId) {
			logger.warn("[SupportChatRoom] No userId found for message sender");
			return;
		}

		const ticketId = data.p.ticketId;
		const messageContent = data.p.message?.message;

		if (!ticketId || !messageContent) {
			logger.warn(data, "[SupportChatRoom] Invalid send message payload");
			return;
		}

		const opts = { tx };

		try {
			// Check if user is a support agent (admin/operator)
			const user = await tx.query.user.findFirst({
				where: (f, op) => op.eq(f.id, userId),
			});

			const isSupport = user?.role === "ADMIN" || user?.role === "OPERATOR";

			// Create the chat message in the database
			const chatMessage = await this.#repo.supportChat.createMessage(
				{
					ticketId,
					message: messageContent,
					userId,
					isFromSupport: isSupport,
				},
				opts,
			);

			logger.info(
				{
					messageId: chatMessage.id,
					ticketId,
					userId,
					isFromSupport: isSupport,
				},
				"[SupportChatRoom] Chat message created",
			);

			// Broadcast the message to all participants except the sender
			const broadcastPayload: SupportChatEnvelope = {
				e: "NEW_MESSAGE",
				f: "s",
				t: "c",
				p: {
					message: chatMessage,
					ticketId,
				},
			};

			this.broadcast(broadcastPayload, { excludes: [ws] });

			// Send notification to the other participant
			const ticket = await this.#repo.supportChat.getTicket(ticketId, opts);
			const notifyUserId = isSupport ? ticket.userId : ticket.assignedToId;

			if (notifyUserId) {
				await this.#repo.notification.sendNotificationToUserId({
					fromUserId: userId,
					toUserId: notifyUserId,
					title: isSupport ? "Support Reply" : "New Support Message",
					body: messageContent.slice(0, 100),
					data: {
						type: "SUPPORT_CHAT",
						ticketId,
						deeplink: `akademove://support/ticket/${ticketId}`,
					},
				});
			}
		} catch (error) {
			logger.error(
				{ error, userId, ticketId },
				"[SupportChatRoom] Failed to handle send message",
			);
			throw error;
		}
	}

	async #handleMarkRead(
		ws: WebSocket,
		data: SupportChatEnvelope,
		tx: DatabaseTransaction,
	) {
		const userId = this.findUserIdBySocket(ws);
		if (!userId) {
			logger.warn("[SupportChatRoom] No userId found for mark read");
			return;
		}

		const ticketId = data.p.ticketId;
		if (!ticketId) {
			logger.warn(data, "[SupportChatRoom] Invalid mark read payload");
			return;
		}

		const opts = { tx };

		try {
			await this.#repo.supportChat.markMessagesAsRead(ticketId, userId, opts);

			// Broadcast read receipt to other participants
			const readPayload: SupportChatEnvelope = {
				e: "MESSAGE_READ",
				f: "s",
				t: "c",
				p: {
					ticketId,
					userId,
				},
			};

			this.broadcast(readPayload, { excludes: [ws] });

			logger.info(
				{ ticketId, userId },
				"[SupportChatRoom] Messages marked as read",
			);
		} catch (error) {
			logger.error(
				{ error, userId, ticketId },
				"[SupportChatRoom] Failed to handle mark read",
			);
			throw error;
		}
	}

	#handleTyping(ws: WebSocket, data: SupportChatEnvelope, isTyping: boolean) {
		const userId = this.findUserIdBySocket(ws);
		if (!userId) return;

		const ticketId = data.p.ticketId;
		if (!ticketId) return;

		// Broadcast typing indicator to other participants
		const typingPayload: SupportChatEnvelope = {
			e: "TYPING",
			f: "s",
			t: "c",
			p: {
				ticketId,
				userId,
				isTyping,
			},
		};

		this.broadcast(typingPayload, { excludes: [ws] });
	}
}
