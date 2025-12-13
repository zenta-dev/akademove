import { m } from "@repo/i18n";
import type {
	ChatSenderRole,
	ChatUnreadCount,
	InsertOrderChatMessage,
	MarkChatAsRead,
	OrderChatMessage,
	OrderChatMessageListQuery,
	OrderChatReadStatus,
} from "@repo/schema/chat";
import { and, count, desc, eq, gt, lt } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx, WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { OrderChatMessageDatabase } from "@/core/tables/chat";
import { logger } from "@/utils/logger";
import { ChatAuthorizationService, ChatCacheService } from "./services";

interface OrderParticipants {
	userId: string;
	driverUserId?: string;
	merchantUserId?: string;
}

export class ChatRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("orderChatMessage", kv, db);
	}

	/**
	 * Determine the sender's role based on order participants
	 */
	static determineSenderRole(
		senderId: string,
		participants: OrderParticipants,
	): ChatSenderRole {
		if (senderId === participants.userId) {
			return "USER";
		}
		if (
			participants.driverUserId !== undefined &&
			senderId === participants.driverUserId
		) {
			return "DRIVER";
		}
		if (
			participants.merchantUserId !== undefined &&
			senderId === participants.merchantUserId
		) {
			return "MERCHANT";
		}
		// Default fallback - should not happen in normal flow
		return "USER";
	}

	static composeEntity(
		item: OrderChatMessageDatabase & {
			sender: { name: string; image: string | null } | null;
		},
		senderRole?: ChatSenderRole,
	): OrderChatMessage {
		return {
			...item,
			sender: item.sender
				? {
						name: item.sender.name,
						image: item.sender.image ?? undefined,
						role: senderRole ?? "USER",
					}
				: undefined,
		};
	}

	async #getFromDB(
		id: string,
		participants: OrderParticipants,
		opts?: PartialWithTx,
	): Promise<OrderChatMessage | undefined> {
		const result = await (opts?.tx ?? this.db).query.orderChatMessage.findFirst(
			{
				with: {
					sender: { columns: { name: true, image: true } },
				},
				where: (f, op) => op.eq(f.id, id),
			},
		);
		if (!result) return undefined;
		const role = ChatRepository.determineSenderRole(
			result.senderId,
			participants,
		);
		return ChatRepository.composeEntity(result, role);
	}

	/**
	 * Get order participants (userIds) for role determination
	 */
	async #getOrderParticipants(
		orderId: string,
		opts?: PartialWithTx,
	): Promise<OrderParticipants | undefined> {
		const order = await (opts?.tx ?? this.db).query.order.findFirst({
			where: (f, op) => op.eq(f.id, orderId),
			with: {
				driver: { columns: { userId: true } },
				merchant: { columns: { userId: true } },
			},
		});
		if (!order) return undefined;
		return {
			userId: order.userId,
			driverUserId: order.driver?.userId,
			merchantUserId: order.merchant?.userId,
		};
	}

	async listMessages(
		query: OrderChatMessageListQuery & { userId: string },
		opts?: PartialWithTx,
	): Promise<{
		rows: OrderChatMessage[];
		hasMore: boolean;
		nextCursor?: string;
	}> {
		const { orderId, userId, limit = 50, cursor } = query;
		try {
			const tx = opts?.tx ?? this.db;

			// Get order for authorization and participants
			const order = await tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
				with: {
					driver: { columns: { userId: true } },
					merchant: { columns: { userId: true } },
				},
			});

			if (!order) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			// Verify user is authorized to view messages
			await ChatAuthorizationService.requireOrderParticipant(userId, order, {
				getMerchantUserId: async (merchantId: string) => {
					const merchant = await tx.query.merchant.findFirst({
						where: (f, op) => op.eq(f.id, merchantId),
					});
					return merchant?.userId;
				},
				getDriverUserId: async (driverId: string) => {
					const driver = await tx.query.driver.findFirst({
						where: (f, op) => op.eq(f.id, driverId),
					});
					return driver?.userId;
				},
			});

			const participants = {
				userId: order.userId,
				driverUserId: order.driver?.userId,
				merchantUserId: order.merchant?.userId,
			};

			const clauses = [eq(tables.orderChatMessage.orderId, orderId)];

			if (cursor) {
				clauses.push(lt(tables.orderChatMessage.id, cursor));
			}

			const res = await tx.query.orderChatMessage.findMany({
				with: {
					sender: { columns: { name: true, image: true } },
				},
				where: (_f, op) => op.and(...clauses),
				orderBy: [desc(tables.orderChatMessage.sentAt)],
				limit: limit + 1,
			});

			const mapped = res.map((item) => {
				const role = ChatRepository.determineSenderRole(
					item.senderId,
					participants,
				);
				return ChatRepository.composeEntity(item, role);
			});
			const hasMore = mapped.length > limit;
			const rows = hasMore ? mapped.slice(0, limit) : mapped;
			const nextCursor = hasMore ? rows[rows.length - 1].id : undefined;

			return { rows, hasMore, nextCursor };
		} catch (error) {
			logger.error(
				{ error, query },
				"[ChatRepository] Failed to list messages",
			);
			throw this.handleError(error, "list");
		}
	}

	async create(
		params: InsertOrderChatMessage & WithUserId,
		opts: WithTx,
	): Promise<OrderChatMessage> {
		try {
			const now = new Date();

			// Verify order exists and get participants
			const order = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, params.orderId),
				with: {
					driver: { columns: { userId: true } },
					merchant: { columns: { userId: true } },
				},
			});

			if (!order) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const participants: OrderParticipants = {
				userId: order.userId,
				driverUserId: order.driver?.userId,
				merchantUserId: order.merchant?.userId,
			};

			// Verify user is authorized (delegated to service)
			await ChatAuthorizationService.requireOrderParticipant(
				params.userId,
				order,
				{
					getMerchantUserId: async (merchantId: string) => {
						const merchant = await opts.tx.query.merchant.findFirst({
							where: (f, op) => op.eq(f.id, merchantId),
						});
						return merchant?.userId;
					},
					getDriverUserId: async (driverId: string) => {
						const driver = await opts.tx.query.driver.findFirst({
							where: (f, op) => op.eq(f.id, driverId),
						});
						return driver?.userId;
					},
				},
			);

			const [result] = await opts.tx
				.insert(tables.orderChatMessage)
				.values({
					id: v7(),
					orderId: params.orderId,
					senderId: params.userId,
					message: params.message,
					sentAt: now,
					createdAt: now,
					updatedAt: now,
				})
				.returning({ id: tables.orderChatMessage.id });

			const message = await this.#getFromDB(result.id, participants, opts);
			if (!message) {
				throw new RepositoryError(m.error_failed_retrieve_created_message());
			}

			// Invalidate order messages cache
			await this.deleteCache(
				ChatCacheService.generateMessagesCacheKey(params.orderId),
			);

			logger.info(
				{
					messageId: message.id,
					orderId: params.orderId,
					userId: params.userId,
				},
				m.server_message_created(),
			);

			return message;
		} catch (error) {
			logger.error(
				{ error, params },
				"[ChatRepository] Failed to create message - transaction will be rolled back",
			);
			throw this.handleError(error, "create");
		}
	}

	async getMessageCount(
		orderId: string,
		opts?: PartialWithTx,
	): Promise<number> {
		try {
			const cacheKey = ChatCacheService.generateCountCacheKey(orderId);

			const fallback = async () => {
				const [result] = await (opts?.tx ?? this.db)
					.select({ count: count(tables.orderChatMessage.id) })
					.from(tables.orderChatMessage)
					.where(eq(tables.orderChatMessage.orderId, orderId));

				const total = result?.count ?? 0;

				await this.setCache(cacheKey, total, {
					expirationTtl: CACHE_TTLS["5m"],
				});

				return total;
			};

			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			logger.error(
				{ error, orderId },
				"[ChatRepository] Failed to get message count",
			);
			return 0;
		}
	}

	/**
	 * Get the unread message count for a user in an order chat
	 */
	async getUnreadCount(
		params: { orderId: string; userId: string },
		opts?: PartialWithTx,
	): Promise<ChatUnreadCount> {
		try {
			const tx = opts?.tx ?? this.db;
			const { orderId, userId } = params;

			// Get the user's read status for this order
			const readStatus = await tx.query.orderChatReadStatus.findFirst({
				where: (f, op) => op.and(eq(f.orderId, orderId), eq(f.userId, userId)),
			});

			let unreadCount = 0;

			if (readStatus?.lastReadMessageId) {
				// Count messages after the last read message
				const [result] = await tx
					.select({ count: count(tables.orderChatMessage.id) })
					.from(tables.orderChatMessage)
					.where(
						and(
							eq(tables.orderChatMessage.orderId, orderId),
							gt(tables.orderChatMessage.id, readStatus.lastReadMessageId),
						),
					);
				unreadCount = result?.count ?? 0;
			} else {
				// No read status exists - all messages except user's own are unread
				const [result] = await tx
					.select({ count: count(tables.orderChatMessage.id) })
					.from(tables.orderChatMessage)
					.where(
						and(
							eq(tables.orderChatMessage.orderId, orderId),
							// Don't count messages sent by the user themselves
							// Actually, we should count all messages for simplicity
							// Users need to mark as read to reset the count
						),
					);
				unreadCount = result?.count ?? 0;
			}

			return { orderId, unreadCount };
		} catch (error) {
			logger.error(
				{ error, params },
				"[ChatRepository] Failed to get unread count",
			);
			throw this.handleError(error, "get unread count");
		}
	}

	/**
	 * Mark messages as read for a user in an order chat
	 * Updates or creates the read status record
	 */
	async markAsRead(
		params: MarkChatAsRead & WithUserId,
		opts: WithTx,
	): Promise<OrderChatReadStatus> {
		try {
			const now = new Date();
			const { orderId, userId, lastReadMessageId } = params;

			// Get the latest message ID if not provided
			let messageIdToMark = lastReadMessageId;
			if (!messageIdToMark) {
				const latestMessage = await opts.tx.query.orderChatMessage.findFirst({
					where: (f, op) => op.eq(f.orderId, orderId),
					orderBy: [desc(tables.orderChatMessage.sentAt)],
				});
				messageIdToMark = latestMessage?.id;
			}

			// Check if read status already exists
			const existingStatus = await opts.tx.query.orderChatReadStatus.findFirst({
				where: (f, op) => op.and(eq(f.orderId, orderId), eq(f.userId, userId)),
			});

			let result: OrderChatReadStatus;

			if (existingStatus) {
				// Update existing read status
				const [updated] = await opts.tx
					.update(tables.orderChatReadStatus)
					.set({
						lastReadMessageId: messageIdToMark,
						lastReadAt: now,
						updatedAt: now,
					})
					.where(eq(tables.orderChatReadStatus.id, existingStatus.id))
					.returning();

				result = {
					id: updated.id,
					orderId: updated.orderId,
					userId: updated.userId,
					lastReadMessageId: updated.lastReadMessageId,
					lastReadAt: updated.lastReadAt,
					createdAt: updated.createdAt,
					updatedAt: updated.updatedAt,
				};
			} else {
				// Create new read status
				const [created] = await opts.tx
					.insert(tables.orderChatReadStatus)
					.values({
						id: v7(),
						orderId,
						userId,
						lastReadMessageId: messageIdToMark,
						lastReadAt: now,
						createdAt: now,
						updatedAt: now,
					})
					.returning();

				result = {
					id: created.id,
					orderId: created.orderId,
					userId: created.userId,
					lastReadMessageId: created.lastReadMessageId,
					lastReadAt: created.lastReadAt,
					createdAt: created.createdAt,
					updatedAt: created.updatedAt,
				};
			}

			// Invalidate unread count cache
			await this.deleteCache(
				ChatCacheService.generateUnreadCountCacheKey(orderId, userId),
			);

			logger.info(
				{ orderId, userId, lastReadMessageId: messageIdToMark },
				"[ChatRepository] Marked chat as read",
			);

			return result;
		} catch (error) {
			logger.error(
				{ error, params },
				"[ChatRepository] Failed to mark as read",
			);
			throw this.handleError(error, "mark as read");
		}
	}

	/**
	 * Get all participants of an order who should receive unread count updates
	 * Returns array of userIds (customer, driver, merchant)
	 */
	async getOrderParticipantUserIds(
		orderId: string,
		opts?: PartialWithTx,
	): Promise<string[]> {
		const participants = await this.#getOrderParticipants(orderId, opts);
		if (!participants) return [];

		const userIds: string[] = [participants.userId];
		if (participants.driverUserId) {
			userIds.push(participants.driverUserId);
		}
		if (participants.merchantUserId) {
			userIds.push(participants.merchantUserId);
		}

		return userIds;
	}
}
