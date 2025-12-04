import { m } from "@repo/i18n";
import type {
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
import { log } from "@/utils";

export class ChatRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("orderChatMessage", kv, db);
	}

	static composeEntity(
		item: OrderChatMessageDatabase & {
			sender: { name: string; image: string | null } | null;
		},
	): OrderChatMessage {
		return {
			...item,
			sender: item.sender
				? {
						name: item.sender.name,
						image: item.sender.image ?? undefined,
					}
				: undefined,
		};
	}

	async #getFromDB(
		id: string,
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
		return result ? ChatRepository.composeEntity(result) : undefined;
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

			const mapped = res.map((item) => ChatRepository.composeEntity(item));
			const hasMore = mapped.length > limit;
			const rows = hasMore ? mapped.slice(0, limit) : mapped;
			const nextCursor = hasMore ? rows[rows.length - 1].id : undefined;

			return { rows, hasMore, nextCursor };
		} catch (error) {
			log.error({ error, query }, "[ChatRepository] Failed to list messages");
			throw this.handleError(error, "list");
		}
	}

	async create(
		params: InsertOrderChatMessage & WithUserId,
		opts: WithTx,
	): Promise<OrderChatMessage> {
		try {
			const now = new Date();

			// Verify order exists
			const order = await opts.tx.query.order.findFirst({
				where: (f, op) => op.eq(f.id, params.orderId),
			});

			if (!order) {
				throw new RepositoryError(m.error_order_not_found(), {
					code: "NOT_FOUND",
				});
			}

			// Verify user is part of the order (either user, driver, or merchant)
			const isUser = order.userId === params.userId;
			const isDriver = order.driverId === params.userId;
			// For merchant, we need to check if userId matches merchant's userId
			let isMerchant = false;
			const merchantId = order.merchantId;
			if (merchantId) {
				const merchant = await opts.tx.query.merchant.findFirst({
					where: (f, op) => op.eq(f.id, merchantId),
				});
				isMerchant = merchant?.userId === params.userId;
			}

			if (!isUser && !isDriver && !isMerchant) {
				throw new RepositoryError(
					"User is not authorized to send messages in this order",
					{ code: "FORBIDDEN" },
				);
			}

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

			const message = await this.#getFromDB(result.id, opts);
			if (!message) {
				throw new RepositoryError(m.error_failed_retrieve_created_message());
			}

			// Invalidate order messages cache
			await this.deleteCache(`order:${params.orderId}:messages`);

			log.info(
				{
					messageId: message.id,
					orderId: params.orderId,
					userId: params.userId,
				},
				m.server_message_created(),
			);

			return message;
		} catch (error) {
			log.error(
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
			const cacheKey = `order:${orderId}:count`;

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
			log.error(
				{ error, orderId },
				"[ChatRepository] Failed to get message count",
			);
			return 0;
		}
	}
}
