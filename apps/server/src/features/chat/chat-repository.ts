import { m } from "@repo/i18n";
import type {
	ChatSenderRole,
	InsertOrderChatMessage,
	OrderChatMessage,
	OrderChatMessageListQuery,
} from "@repo/schema/chat";
import { count, desc, eq, lt } from "drizzle-orm";
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
		query: OrderChatMessageListQuery,
		opts?: PartialWithTx,
	): Promise<{
		rows: OrderChatMessage[];
		hasMore: boolean;
		nextCursor?: string;
	}> {
		const { orderId, limit = 50, cursor } = query;
		try {
			const tx = opts?.tx ?? this.db;

			// Get order participants for role determination
			const participants = await this.#getOrderParticipants(orderId, opts);
			if (!participants) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

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
}
