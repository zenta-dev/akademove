import type {
	AddToCartRequest,
	Cart,
	CartItem,
	CartResponse,
	UpdateCartItemRequest,
} from "@repo/schema/cart";
import { eq } from "drizzle-orm";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { KeyValueService, PutCacheOptions } from "@/core/services/kv";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

interface StockWarning {
	menuId: string;
	menuName: string;
	requestedQuantity: number;
	availableStock: number;
}

interface MenuWithMerchant {
	id: string;
	merchantId: string;
	name: string;
	price: number;
	stock: number;
	soldStock: number;
	image: string | undefined;
	category: string | undefined;
	merchantName: string;
	merchantCategory: string;
}

/**
 * CartRepository - Manages user shopping cart in KV storage
 *
 * Cart is stored per-user in KV with the key format: cart:{userId}
 * Each user can only have items from one merchant at a time.
 */
export class CartRepository {
	readonly #kv: KeyValueService;
	readonly #db: DatabaseService;

	constructor(kv: KeyValueService, db: DatabaseService) {
		this.#kv = kv;
		this.#db = db;
	}

	#composeCacheKey(userId: string): string {
		return `cart:${userId}`;
	}

	/**
	 * Get cart from KV storage
	 */
	async #getCart(userId: string): Promise<Cart | null> {
		try {
			const cart = await this.#kv.get<Cart>(this.#composeCacheKey(userId));
			return cart ?? null;
		} catch {
			return null;
		}
	}

	/**
	 * Save cart to KV storage
	 */
	async #saveCart(
		userId: string,
		cart: Cart,
		opts?: PutCacheOptions,
	): Promise<void> {
		await this.#kv.put(this.#composeCacheKey(userId), cart, {
			expirationTtl: opts?.expirationTtl ?? CACHE_TTLS["24h"],
		});
	}

	/**
	 * Delete cart from KV storage
	 */
	async #deleteCart(userId: string): Promise<void> {
		await this.#kv.delete(this.#composeCacheKey(userId));
	}

	/**
	 * Get menu from database with stock info and merchant details
	 */
	async #getMenuWithStock(
		menuId: string,
		opts?: PartialWithTx,
	): Promise<MenuWithMerchant> {
		const db = opts?.tx ?? this.#db;

		// Get menu
		const menu = await db.query.merchantMenu.findFirst({
			where: eq(tables.merchantMenu.id, menuId),
		});

		if (!menu) {
			throw new RepositoryError("Menu not found", { code: "NOT_FOUND" });
		}

		// Get merchant
		const merchant = await db.query.merchant.findFirst({
			where: eq(tables.merchant.id, menu.merchantId),
		});

		if (!merchant) {
			throw new RepositoryError("Merchant not found", { code: "NOT_FOUND" });
		}

		const imageUrl = menu.image ?? undefined;

		return {
			id: menu.id,
			merchantId: menu.merchantId,
			name: menu.name,
			price: toNumberSafe(menu.price),
			stock: menu.stock,
			soldStock: menu.soldStock,
			image: imageUrl,
			category: menu.category ?? undefined,
			merchantName: merchant.name,
			merchantCategory: merchant.categories?.[0] ?? "Food",
		};
	}

	/**
	 * Validate stock for all items in cart and return warnings
	 */
	async #validateCartStock(
		cart: Cart,
		opts?: PartialWithTx,
	): Promise<{ updatedCart: Cart; stockWarnings: StockWarning[] }> {
		const stockWarnings: StockWarning[] = [];
		const updatedItems: CartItem[] = [];

		for (const item of cart.items) {
			try {
				const menu = await this.#getMenuWithStock(item.menuId, opts);
				const currentStock = menu.stock;

				// Update item with current stock
				const updatedItem: CartItem = {
					...item,
					stock: currentStock,
					unitPrice: menu.price,
				};

				// Check if quantity exceeds stock
				if (item.quantity > currentStock) {
					stockWarnings.push({
						menuId: item.menuId,
						menuName: item.menuName,
						requestedQuantity: item.quantity,
						availableStock: currentStock,
					});

					// Adjust quantity to available stock (minimum 1)
					if (currentStock > 0) {
						updatedItem.quantity = currentStock;
						updatedItems.push(updatedItem);
					}
					// If stock is 0, item will be removed from cart
				} else {
					updatedItems.push(updatedItem);
				}
			} catch (error) {
				// Menu not found - add warning and skip item
				logger.warn(
					{ menuId: item.menuId, error },
					"[CartRepository] Menu not found during stock validation",
				);
				stockWarnings.push({
					menuId: item.menuId,
					menuName: item.menuName,
					requestedQuantity: item.quantity,
					availableStock: 0,
				});
			}
		}

		// Recalculate totals
		const totalItems = updatedItems.reduce(
			(sum, item) => sum + item.quantity,
			0,
		);
		const subtotal = updatedItems.reduce(
			(sum, item) => sum + item.unitPrice * item.quantity,
			0,
		);

		const updatedCart: Cart = {
			...cart,
			items: updatedItems,
			totalItems,
			subtotal,
			lastUpdated: new Date(),
		};

		return { updatedCart, stockWarnings };
	}

	/**
	 * Get current user's cart with stock validation
	 */
	async get(userId: string, opts?: PartialWithTx): Promise<CartResponse> {
		try {
			const cart = await this.#getCart(userId);

			if (!cart || cart.items.length === 0) {
				return { cart: null };
			}

			// Validate stock and update cart
			const { updatedCart, stockWarnings } = await this.#validateCartStock(
				cart,
				opts,
			);

			// If cart is now empty after stock validation, clear it
			if (updatedCart.items.length === 0) {
				await this.#deleteCart(userId);
				return {
					cart: null,
					stockWarnings: stockWarnings.length > 0 ? stockWarnings : undefined,
				};
			}

			// Save updated cart with validated stock
			await this.#saveCart(userId, updatedCart);

			return {
				cart: updatedCart,
				stockWarnings: stockWarnings.length > 0 ? stockWarnings : undefined,
			};
		} catch (error) {
			logger.error({ userId, error }, "[CartRepository] get failed");
			throw error instanceof RepositoryError
				? error
				: new RepositoryError("Failed to get cart");
		}
	}

	/**
	 * Add item to cart
	 * - If cart empty: create new cart with item
	 * - If same merchant: add/update item
	 * - If different merchant AND replaceIfConflict: clear and add
	 * - If different merchant AND NOT replaceIfConflict: throw conflict error
	 */
	async addItem(
		userId: string,
		input: AddToCartRequest,
		opts?: PartialWithTx,
	): Promise<CartResponse> {
		try {
			const { menuId, quantity, notes, replaceIfConflict } = input;

			// Get menu details with stock
			const menu = await this.#getMenuWithStock(menuId, opts);

			// Validate stock
			if (menu.stock <= 0) {
				throw new RepositoryError("Item is out of stock", {
					code: "BAD_REQUEST",
				});
			}

			if (quantity > menu.stock) {
				throw new RepositoryError(
					`Only ${menu.stock} items available in stock`,
					{ code: "BAD_REQUEST" },
				);
			}

			const currentCart = await this.#getCart(userId);

			// Create cart item
			const cartItem: CartItem = {
				menuId: menu.id,
				merchantId: menu.merchantId,
				merchantName: menu.merchantName,
				menuName: menu.name,
				menuImage: menu.image ?? null,
				unitPrice: menu.price,
				quantity,
				notes: notes ?? null,
				stock: menu.stock,
			};

			let newCart: Cart;

			if (!currentCart || currentCart.items.length === 0) {
				// Create new cart
				newCart = {
					merchantId: menu.merchantId,
					merchantName: menu.merchantName,
					merchantCategory: menu.merchantCategory as
						| "Food"
						| "ATK"
						| "Printing"
						| undefined,
					items: [cartItem],
					totalItems: quantity,
					subtotal: menu.price * quantity,
					lastUpdated: new Date(),
				};
			} else if (currentCart.merchantId !== menu.merchantId) {
				// Different merchant
				if (replaceIfConflict) {
					// Replace cart with new merchant
					newCart = {
						merchantId: menu.merchantId,
						merchantName: menu.merchantName,
						merchantCategory: menu.merchantCategory as
							| "Food"
							| "ATK"
							| "Printing"
							| undefined,
						items: [cartItem],
						totalItems: quantity,
						subtotal: menu.price * quantity,
						lastUpdated: new Date(),
					};
				} else {
					// Throw conflict error
					throw new RepositoryError(
						`Cart contains items from ${currentCart.merchantName}. ` +
							`Clear cart or set replaceIfConflict to add items from ${menu.merchantName}.`,
						{ code: "CONFLICT" },
					);
				}
			} else {
				// Same merchant - add or update item
				const existingIndex = currentCart.items.findIndex(
					(item) => item.menuId === menuId,
				);

				let updatedItems: CartItem[];

				if (existingIndex >= 0) {
					// Update existing item
					updatedItems = [...currentCart.items];
					const existing = updatedItems[existingIndex];
					const newQuantity = existing.quantity + quantity;

					// Validate total quantity against stock
					if (newQuantity > menu.stock) {
						throw new RepositoryError(
							`Cannot add ${quantity} items. Only ${menu.stock - existing.quantity} more available.`,
							{ code: "BAD_REQUEST" },
						);
					}

					updatedItems[existingIndex] = {
						...existing,
						quantity: newQuantity,
						notes: notes ?? existing.notes,
						stock: menu.stock,
					};
				} else {
					// Add new item
					updatedItems = [...currentCart.items, cartItem];
				}

				// Recalculate totals
				const totalItems = updatedItems.reduce(
					(sum, item) => sum + item.quantity,
					0,
				);
				const subtotal = updatedItems.reduce(
					(sum, item) => sum + item.unitPrice * item.quantity,
					0,
				);

				newCart = {
					...currentCart,
					items: updatedItems,
					totalItems,
					subtotal,
					lastUpdated: new Date(),
				};
			}

			await this.#saveCart(userId, newCart);

			return { cart: newCart };
		} catch (error) {
			logger.error({ userId, input, error }, "[CartRepository] addItem failed");
			throw error instanceof RepositoryError
				? error
				: new RepositoryError("Failed to add item to cart");
		}
	}

	/**
	 * Update item quantity by delta
	 * Removes item if resulting quantity <= 0
	 */
	async updateItem(
		userId: string,
		input: UpdateCartItemRequest,
		opts?: PartialWithTx,
	): Promise<CartResponse> {
		try {
			const { menuId, delta } = input;

			const currentCart = await this.#getCart(userId);
			if (!currentCart || currentCart.items.length === 0) {
				throw new RepositoryError("Cart is empty", { code: "NOT_FOUND" });
			}

			const itemIndex = currentCart.items.findIndex(
				(item) => item.menuId === menuId,
			);

			if (itemIndex < 0) {
				throw new RepositoryError("Item not found in cart", {
					code: "NOT_FOUND",
				});
			}

			const currentItem = currentCart.items[itemIndex];
			const newQuantity = currentItem.quantity + delta;

			let updatedItems: CartItem[];
			const stockWarnings: StockWarning[] = [];

			if (newQuantity <= 0) {
				// Remove item
				updatedItems = currentCart.items.filter(
					(item) => item.menuId !== menuId,
				);
			} else {
				// Validate stock for increments
				if (delta > 0) {
					const menu = await this.#getMenuWithStock(menuId, opts);
					if (newQuantity > menu.stock) {
						throw new RepositoryError(
							`Only ${menu.stock} items available in stock`,
							{ code: "BAD_REQUEST" },
						);
					}

					// Update stock info
					updatedItems = [...currentCart.items];
					updatedItems[itemIndex] = {
						...currentItem,
						quantity: newQuantity,
						stock: menu.stock,
						unitPrice: menu.price,
					};
				} else {
					// Decrement - no stock validation needed
					updatedItems = [...currentCart.items];
					updatedItems[itemIndex] = {
						...currentItem,
						quantity: newQuantity,
					};
				}
			}

			// If cart is empty after update, clear it
			if (updatedItems.length === 0) {
				await this.#deleteCart(userId);
				return { cart: null };
			}

			// Recalculate totals
			const totalItems = updatedItems.reduce(
				(sum, item) => sum + item.quantity,
				0,
			);
			const subtotal = updatedItems.reduce(
				(sum, item) => sum + item.unitPrice * item.quantity,
				0,
			);

			const updatedCart: Cart = {
				...currentCart,
				items: updatedItems,
				totalItems,
				subtotal,
				lastUpdated: new Date(),
			};

			await this.#saveCart(userId, updatedCart);

			return {
				cart: updatedCart,
				stockWarnings: stockWarnings.length > 0 ? stockWarnings : undefined,
			};
		} catch (error) {
			logger.error(
				{ userId, input, error },
				"[CartRepository] updateItem failed",
			);
			throw error instanceof RepositoryError
				? error
				: new RepositoryError("Failed to update cart item");
		}
	}

	/**
	 * Remove item from cart
	 */
	async removeItem(userId: string, menuId: string): Promise<CartResponse> {
		try {
			const currentCart = await this.#getCart(userId);
			if (!currentCart || currentCart.items.length === 0) {
				throw new RepositoryError("Cart is empty", { code: "NOT_FOUND" });
			}

			const updatedItems = currentCart.items.filter(
				(item) => item.menuId !== menuId,
			);

			// If cart is empty after removal, clear it
			if (updatedItems.length === 0) {
				await this.#deleteCart(userId);
				return { cart: null };
			}

			// Recalculate totals
			const totalItems = updatedItems.reduce(
				(sum, item) => sum + item.quantity,
				0,
			);
			const subtotal = updatedItems.reduce(
				(sum, item) => sum + item.unitPrice * item.quantity,
				0,
			);

			const updatedCart: Cart = {
				...currentCart,
				items: updatedItems,
				totalItems,
				subtotal,
				lastUpdated: new Date(),
			};

			await this.#saveCart(userId, updatedCart);

			return { cart: updatedCart };
		} catch (error) {
			logger.error(
				{ userId, menuId, error },
				"[CartRepository] removeItem failed",
			);
			throw error instanceof RepositoryError
				? error
				: new RepositoryError("Failed to remove item from cart");
		}
	}

	/**
	 * Clear entire cart
	 */
	async clear(userId: string): Promise<void> {
		try {
			await this.#deleteCart(userId);
		} catch (error) {
			logger.error({ userId, error }, "[CartRepository] clear failed");
			throw new RepositoryError("Failed to clear cart");
		}
	}
}
