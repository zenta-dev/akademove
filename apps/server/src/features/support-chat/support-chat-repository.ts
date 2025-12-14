import type {
	InsertSupportChatMessage,
	InsertSupportTicket,
	SupportChatMessage,
	SupportChatMessageListQuery,
	SupportTicket,
	SupportTicketListQuery,
	UpdateSupportTicket,
} from "@repo/schema/support-chat";
import {
	and,
	count,
	desc,
	eq,
	ilike,
	isNull,
	lt,
	ne,
	type SQL,
} from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx, WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type {
	SupportChatMessageDatabase,
	SupportTicketDatabase,
} from "@/core/tables/support-chat";
import { logger } from "@/utils/logger";

export class SupportChatRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("supportTicket", kv, db);
	}

	static composeTicketEntity(
		item: SupportTicketDatabase & {
			user?: { name: string; image: string | null; email: string } | null;
			assignedTo?: { name: string; image: string | null } | null;
		},
	): SupportTicket {
		return {
			...item,
			assignedToId: item.assignedToId ?? undefined,
			orderId: item.orderId ?? undefined,
			lastMessageAt: item.lastMessageAt ?? undefined,
			resolvedAt: item.resolvedAt ?? undefined,
			user: item.user
				? {
						name: item.user.name,
						image: item.user.image ?? undefined,
						email: item.user.email,
					}
				: undefined,
			assignedTo: item.assignedTo
				? {
						name: item.assignedTo.name,
						image: item.assignedTo.image ?? undefined,
					}
				: undefined,
		};
	}

	static composeMessageEntity(
		item: SupportChatMessageDatabase & {
			sender?: { name: string; image: string | null } | null;
		},
	): SupportChatMessage {
		return {
			...item,
			readAt: item.readAt ?? undefined,
			sender: item.sender
				? {
						name: item.sender.name,
						image: item.sender.image ?? undefined,
					}
				: undefined,
		};
	}

	// ==================== TICKET OPERATIONS ====================

	async listTickets(
		query: SupportTicketListQuery,
		opts?: PartialWithTx,
	): Promise<{
		rows: SupportTicket[];
		hasMore: boolean;
		nextCursor?: string;
	}> {
		const {
			status,
			category,
			priority,
			assignedToId,
			userId,
			search,
			limit = 20,
			cursor,
		} = query;
		try {
			const tx = opts?.tx ?? this.db;

			const clauses: SQL[] = [];

			if (status) {
				clauses.push(eq(tables.supportTicket.status, status));
			}
			if (category) {
				clauses.push(eq(tables.supportTicket.category, category));
			}
			if (priority) {
				clauses.push(eq(tables.supportTicket.priority, priority));
			}
			if (assignedToId) {
				clauses.push(eq(tables.supportTicket.assignedToId, assignedToId));
			}
			if (userId) {
				clauses.push(eq(tables.supportTicket.userId, userId));
			}
			if (search) {
				clauses.push(ilike(tables.supportTicket.subject, `%${search}%`));
			}
			if (cursor) {
				clauses.push(lt(tables.supportTicket.id, cursor));
			}

			const res = await tx.query.supportTicket.findMany({
				with: {
					user: { columns: { name: true, image: true, email: true } },
					assignedTo: { columns: { name: true, image: true } },
				},
				where: clauses.length > 0 ? (_f, op) => op.and(...clauses) : undefined,
				orderBy: [desc(tables.supportTicket.createdAt)],
				limit: limit + 1,
			});

			const mapped = res.map((item) =>
				SupportChatRepository.composeTicketEntity(item),
			);
			const hasMore = mapped.length > limit;
			const rows = hasMore ? mapped.slice(0, limit) : mapped;
			const nextCursor = hasMore ? rows[rows.length - 1].id : undefined;

			return { rows, hasMore, nextCursor };
		} catch (error) {
			logger.error(
				{ error, query },
				"[SupportChatRepository] Failed to list tickets",
			);
			throw this.handleError(error, "list tickets");
		}
	}

	async getTicket(id: string, opts?: PartialWithTx): Promise<SupportTicket> {
		try {
			const tx = opts?.tx ?? this.db;

			const cacheKey = `ticket:${id}`;
			const fallback = async () => {
				const result = await tx.query.supportTicket.findFirst({
					with: {
						user: { columns: { name: true, image: true, email: true } },
						assignedTo: { columns: { name: true, image: true } },
					},
					where: (f, op) => op.eq(f.id, id),
				});

				if (!result) {
					throw new RepositoryError("Support ticket not found", {
						code: "NOT_FOUND",
					});
				}

				await this.setCache(cacheKey, result, {
					expirationTtl: CACHE_TTLS["1h"],
				});
				return SupportChatRepository.composeTicketEntity(result);
			};

			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			logger.error(
				{ error, id },
				"[SupportChatRepository] Failed to get ticket",
			);
			throw this.handleError(error, "get ticket");
		}
	}

	async createTicket(
		params: InsertSupportTicket & WithUserId,
		opts: WithTx,
	): Promise<SupportTicket> {
		const now = new Date();
		try {
			const ticketId = v7();

			// Create ticket
			const [ticket] = await opts.tx
				.insert(tables.supportTicket)
				.values({
					id: ticketId,
					userId: params.userId,
					subject: params.subject,
					category: params.category,
					priority: params.priority,
					status: "OPEN",
					orderId: params.orderId,
					lastMessageAt: now,
					createdAt: now,
					updatedAt: now,
				})
				.returning();

			// Create initial message
			await opts.tx.insert(tables.supportChatMessage).values({
				id: v7(),
				ticketId: ticketId,
				senderId: params.userId,
				message: params.message,
				isFromSupport: false,
				sentAt: now,
				createdAt: now,
				updatedAt: now,
			});

			logger.info(
				{ ticketId, userId: params.userId, category: params.category },
				"[SupportChatRepository] Created support ticket",
			);

			return await this.getTicket(ticket.id, opts);
		} catch (error) {
			logger.error(
				{ error, params },
				"[SupportChatRepository] Failed to create ticket",
			);
			throw this.handleError(error, "create ticket");
		}
	}

	async updateTicket(
		id: string,
		params: UpdateSupportTicket,
		opts: WithTx,
	): Promise<SupportTicket> {
		const now = new Date();
		try {
			const updateData: Record<string, unknown> = {
				updatedAt: now,
			};

			if (params.assignedToId !== undefined) {
				updateData.assignedToId = params.assignedToId;
			}
			if (params.priority !== undefined) {
				updateData.priority = params.priority;
			}
			if (params.status !== undefined) {
				updateData.status = params.status;
				if (params.status === "RESOLVED" || params.status === "CLOSED") {
					updateData.resolvedAt = now;
				}
			}

			const [updated] = await opts.tx
				.update(tables.supportTicket)
				.set(updateData)
				.where(eq(tables.supportTicket.id, id))
				.returning();

			if (!updated) {
				throw new RepositoryError("Support ticket not found", {
					code: "NOT_FOUND",
				});
			}

			// Invalidate cache
			await this.deleteCache(`ticket:${id}`);

			logger.info(
				{ ticketId: id, params },
				"[SupportChatRepository] Updated support ticket",
			);

			return await this.getTicket(id, opts);
		} catch (error) {
			logger.error(
				{ error, id, params },
				"[SupportChatRepository] Failed to update ticket",
			);
			throw this.handleError(error, "update ticket");
		}
	}

	// ==================== MESSAGE OPERATIONS ====================

	async listMessages(
		query: SupportChatMessageListQuery,
		opts?: PartialWithTx,
	): Promise<{
		rows: SupportChatMessage[];
		hasMore: boolean;
		nextCursor?: string;
	}> {
		const { ticketId, limit = 50, cursor } = query;
		try {
			const tx = opts?.tx ?? this.db;

			const clauses = [eq(tables.supportChatMessage.ticketId, ticketId)];

			if (cursor) {
				clauses.push(lt(tables.supportChatMessage.id, cursor));
			}

			const res = await tx.query.supportChatMessage.findMany({
				with: {
					sender: { columns: { name: true, image: true } },
				},
				where: (_f, op) => op.and(...clauses),
				orderBy: [desc(tables.supportChatMessage.sentAt)],
				limit: limit + 1,
			});

			const mapped = res.map((item) =>
				SupportChatRepository.composeMessageEntity(item),
			);
			const hasMore = mapped.length > limit;
			const rows = hasMore ? mapped.slice(0, limit) : mapped;
			const nextCursor = hasMore ? rows[rows.length - 1].id : undefined;

			return { rows, hasMore, nextCursor };
		} catch (error) {
			logger.error(
				{ error, query },
				"[SupportChatRepository] Failed to list messages",
			);
			throw this.handleError(error, "list messages");
		}
	}

	async createMessage(
		params: InsertSupportChatMessage & WithUserId & { isFromSupport?: boolean },
		opts: WithTx,
	): Promise<SupportChatMessage> {
		const now = new Date();
		try {
			// Verify ticket exists
			const ticket = await opts.tx.query.supportTicket.findFirst({
				where: (f, op) => op.eq(f.id, params.ticketId),
			});

			if (!ticket) {
				throw new RepositoryError("Support ticket not found", {
					code: "NOT_FOUND",
				});
			}

			const messageId = v7();

			// Create message
			const [message] = await opts.tx
				.insert(tables.supportChatMessage)
				.values({
					id: messageId,
					ticketId: params.ticketId,
					senderId: params.userId,
					message: params.message,
					isFromSupport: params.isFromSupport ?? false,
					sentAt: now,
					createdAt: now,
					updatedAt: now,
				})
				.returning();

			// Update ticket's lastMessageAt
			await opts.tx
				.update(tables.supportTicket)
				.set({
					lastMessageAt: now,
					updatedAt: now,
					// If support replied, set status to WAITING_USER
					...(params.isFromSupport && ticket.status === "IN_PROGRESS"
						? { status: "WAITING_USER" }
						: {}),
					// If user replied while waiting, set status to IN_PROGRESS
					...(!params.isFromSupport && ticket.status === "WAITING_USER"
						? { status: "IN_PROGRESS" }
						: {}),
				})
				.where(eq(tables.supportTicket.id, params.ticketId));

			// Invalidate ticket cache
			await this.deleteCache(`ticket:${params.ticketId}`);

			logger.info(
				{
					messageId,
					ticketId: params.ticketId,
					userId: params.userId,
					isFromSupport: params.isFromSupport,
				},
				"[SupportChatRepository] Created support chat message",
			);

			// Fetch with sender info
			const result = await opts.tx.query.supportChatMessage.findFirst({
				with: {
					sender: { columns: { name: true, image: true } },
				},
				where: (f, op) => op.eq(f.id, message.id),
			});

			if (!result) {
				throw new RepositoryError("Failed to retrieve created message");
			}

			return SupportChatRepository.composeMessageEntity(result);
		} catch (error) {
			logger.error(
				{ error, params },
				"[SupportChatRepository] Failed to create message",
			);
			throw this.handleError(error, "create message");
		}
	}

	async markMessagesAsRead(
		ticketId: string,
		userId: string,
		opts: WithTx,
	): Promise<{ count: number }> {
		const now = new Date();
		try {
			// Mark all unread messages from OTHER users as read
			const result = await opts.tx
				.update(tables.supportChatMessage)
				.set({ readAt: now, updatedAt: now })
				.where(
					and(
						eq(tables.supportChatMessage.ticketId, ticketId),
						isNull(tables.supportChatMessage.readAt),
						// Only mark messages from OTHER users (not own messages)
						ne(tables.supportChatMessage.senderId, userId),
					),
				)
				.returning();

			logger.info(
				{ ticketId, userId, count: result.length },
				"[SupportChatRepository] Marked messages as read",
			);

			return { count: result.length };
		} catch (error) {
			logger.error(
				{ error, ticketId, userId },
				"[SupportChatRepository] Failed to mark as read",
			);
			throw this.handleError(error, "mark as read");
		}
	}

	async getUnreadCount(
		ticketId: string,
		userId: string,
		opts?: PartialWithTx,
	): Promise<{ unreadCount: number }> {
		try {
			const tx = opts?.tx ?? this.db;

			// Count messages NOT sent by this user and NOT read yet
			const [result] = await tx
				.select({ count: count(tables.supportChatMessage.id) })
				.from(tables.supportChatMessage)
				.where(
					and(
						eq(tables.supportChatMessage.ticketId, ticketId),
						isNull(tables.supportChatMessage.readAt),
						// Only count messages from OTHER users
						ne(tables.supportChatMessage.senderId, userId),
					),
				);

			return { unreadCount: result?.count ?? 0 };
		} catch (error) {
			logger.error(
				{ error, ticketId, userId },
				"[SupportChatRepository] Failed to get unread count",
			);
			return { unreadCount: 0 };
		}
	}

	/**
	 * Check if user is participant in the ticket (either creator or assigned support)
	 */
	async isTicketParticipant(
		ticketId: string,
		userId: string,
		opts?: PartialWithTx,
	): Promise<boolean> {
		try {
			const ticket = await this.getTicket(ticketId, opts);
			return ticket.userId === userId || ticket.assignedToId === userId;
		} catch {
			return false;
		}
	}
}
