import type { PricingConfiguration } from "@repo/schema/configuration";
import type {
	EstimateOrder,
	Order,
	OrderStatusHistory,
	OrderSummary,
	PlaceOrder,
	PlaceOrderResponse,
	PlaceScheduledOrder,
	PlaceScheduledOrderResponse,
	UpdateOrder,
	UpdateScheduledOrder,
} from "@repo/schema/order";
import type { UserRole } from "@repo/schema/user";
import type { UnifiedListResult, WithTx, WithUserId } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { PaymentRepository } from "../payment/payment-repository";
import type { OrderListQuery } from "./order-spec";
import {
	OrderBaseRepository,
	OrderCancellationRepository,
	OrderPlacementRepository,
	OrderReadRepository,
	OrderWriteRepository,
	ScheduledOrderRepository,
} from "./repositories";
import type {
	DeliveryProofService,
	OrderMatchingService,
	OrderPricingService,
	OrderStateService,
} from "./services";

/**
 * OrderRepository - Facade for all order operations
 *
 * This class delegates to specialized repositories:
 * - OrderReadRepository: get, list, estimate
 * - OrderWriteRepository: update, remove
 * - OrderPlacementRepository: placeOrder
 * - OrderCancellationRepository: cancelOrder
 * - ScheduledOrderRepository: scheduled order operations
 *
 * Benefits:
 * - Single entry point for all order operations (backward compatible)
 * - Each sub-repository is focused and testable
 * - Reduced file size and improved maintainability
 */
export class OrderRepository {
	readonly #readRepo: OrderReadRepository;
	readonly #writeRepo: OrderWriteRepository;
	readonly #placementRepo: OrderPlacementRepository;
	readonly #cancellationRepo: OrderCancellationRepository;
	readonly #scheduledRepo: ScheduledOrderRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		_map: unknown, // Kept for backward compatibility, no longer used
		paymentRepo: PaymentRepository,
		pricingService: OrderPricingService,
		_matchingService: OrderMatchingService,
		stateService: OrderStateService,
		deliveryProofService: DeliveryProofService,
	) {
		// Initialize read repository
		this.#readRepo = new OrderReadRepository(db, kv, pricingService);

		// Initialize write repository
		this.#writeRepo = new OrderWriteRepository(
			db,
			kv,
			stateService,
			deliveryProofService,
		);

		// Initialize placement repository
		this.#placementRepo = new OrderPlacementRepository(
			db,
			kv,
			paymentRepo,
			this.#readRepo,
			this.#writeRepo,
		);

		// Initialize cancellation repository
		this.#cancellationRepo = new OrderCancellationRepository(
			db,
			kv,
			stateService,
			this.#writeRepo,
		);

		// Initialize scheduled order repository
		this.#scheduledRepo = new ScheduledOrderRepository(
			db,
			kv,
			paymentRepo,
			this.#readRepo,
		);
	}

	// ============================================================
	// Static methods - delegated to OrderBaseRepository
	// ============================================================

	/**
	 * Get WebSocket room stub by name for broadcasting order updates
	 */
	static getRoomStubByName(name: string) {
		return OrderBaseRepository.getRoomStubByName(name);
	}

	/**
	 * Compose an Order entity from database row with related entities
	 */
	static composeEntity = OrderBaseRepository.composeEntity;

	// ============================================================
	// Read operations - delegated to OrderReadRepository
	// ============================================================

	/**
	 * Get order by ID
	 */
	async get(id: string, opts?: WithTx): Promise<Order> {
		return this.#readRepo.get(id, opts);
	}

	/**
	 * List orders with pagination and filtering
	 */
	async list(
		query?: OrderListQuery & {
			id?: string;
			role: UserRole;
		},
		opts?: WithTx,
	): Promise<UnifiedListResult<Order>> {
		return this.#readRepo.list(query, opts);
	}

	/**
	 * Estimate order pricing
	 */
	async estimate(
		params: EstimateOrder,
		opts?: WithTx,
	): Promise<OrderSummary & { config: PricingConfiguration }> {
		return this.#readRepo.estimate(params, opts);
	}

	// ============================================================
	// Write operations - delegated to OrderWriteRepository
	// ============================================================

	/**
	 * Update an order
	 */
	async update(id: string, item: UpdateOrder, opts: WithTx): Promise<Order> {
		return this.#writeRepo.update(id, item, opts);
	}

	/**
	 * Remove an order
	 */
	async remove(id: string, opts: WithTx): Promise<void> {
		return this.#writeRepo.remove(id, opts);
	}

	// ============================================================
	// Placement operations - delegated to OrderPlacementRepository
	// ============================================================

	/**
	 * Place a new order
	 */
	async placeOrder(
		params: PlaceOrder & WithUserId,
		opts: WithTx,
	): Promise<PlaceOrderResponse> {
		return this.#placementRepo.placeOrder(params, opts);
	}

	// ============================================================
	// Cancellation operations - delegated to OrderCancellationRepository
	// ============================================================

	/**
	 * Cancel an order with penalty logic
	 */
	async cancelOrder(
		orderId: string,
		userId: string,
		userRole: UserRole,
		reason?: string,
		opts?: WithTx,
	): Promise<Order> {
		return this.#cancellationRepo.cancelOrder(
			orderId,
			userId,
			userRole,
			reason,
			opts,
		);
	}

	// ============================================================
	// Scheduled order operations - delegated to ScheduledOrderRepository
	// ============================================================

	/**
	 * Place a scheduled order
	 */
	async placeScheduledOrder(
		params: PlaceScheduledOrder & WithUserId,
		opts: WithTx,
	): Promise<PlaceScheduledOrderResponse> {
		return this.#scheduledRepo.placeScheduledOrder(params, opts);
	}

	/**
	 * List scheduled orders for a user
	 */
	async listScheduledOrders(
		query: OrderListQuery & { userId: string },
		opts?: WithTx,
	): Promise<UnifiedListResult<Order>> {
		return this.#scheduledRepo.listScheduledOrders(query, opts);
	}

	/**
	 * Update a scheduled order (reschedule)
	 */
	async updateScheduledOrder(
		id: string,
		item: UpdateScheduledOrder,
		opts: WithTx,
	): Promise<Order> {
		return this.#scheduledRepo.updateScheduledOrder(id, item, opts);
	}

	/**
	 * Cancel a scheduled order
	 */
	async cancelScheduledOrder(
		orderId: string,
		userId: string,
		reason?: string,
		opts?: WithTx,
	): Promise<Order> {
		return this.#scheduledRepo.cancelScheduledOrder(
			orderId,
			userId,
			reason,
			opts,
		);
	}

	// ============================================================
	// Audit trail operations - delegated to OrderReadRepository
	// ============================================================

	/**
	 * Get order status history (audit trail)
	 */
	async getStatusHistory(
		orderId: string,
		opts?: WithTx,
	): Promise<OrderStatusHistory[]> {
		return this.#readRepo.getStatusHistory(orderId, opts);
	}
}
