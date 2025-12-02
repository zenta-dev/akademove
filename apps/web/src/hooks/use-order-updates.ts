import { useQueryClient } from "@tanstack/react-query";
import { useEffect, useRef } from "react";

interface UseOrderUpdatesOptions {
	enabled?: boolean;
	interval?: number;
	onNewOrder?: (order: unknown) => void;
}

interface UseOrderUpdatesReturn {
	isConnected: boolean;
}

/**
 * Hook to subscribe to real-time order updates for merchants
 *
 * Current Implementation: Uses polling with query invalidation
 * Future: Will be upgraded to WebSocket connections (see WEBSOCKET_TODO.md)
 *
 * Features:
 * - Automatic query invalidation for order lists
 * - New order detection for notifications
 * - Configurable polling interval
 *
 * @param options - Configuration options
 * @param options.enabled - Whether to enable real-time updates (default: true)
 * @param options.interval - Polling interval in milliseconds (default: 10000ms = 10s)
 * @param options.onNewOrder - Callback when a new order is detected
 */
export const useOrderUpdates = (
	options: UseOrderUpdatesOptions = {},
): UseOrderUpdatesReturn => {
	const { enabled = true, interval = 10000, onNewOrder } = options;
	const queryClient = useQueryClient();
	const intervalRef = useRef<NodeJS.Timeout | null>(null);
	const previousOrdersRef = useRef<Set<string>>(new Set());

	useEffect(() => {
		if (!enabled) {
			if (intervalRef.current) {
				clearInterval(intervalRef.current);
				intervalRef.current = null;
			}
			return;
		}

		// Poll for order updates by invalidating queries
		intervalRef.current = setInterval(async () => {
			// Get current orders from cache before invalidation
			const currentOrders = queryClient.getQueryData<{
				data?: Array<{ id: string }>;
			}>(["orders"]);

			// Invalidate order list queries to trigger refetch
			await queryClient.invalidateQueries({ queryKey: ["orders"] });
			// Invalidate merchant analytics
			await queryClient.invalidateQueries({
				queryKey: ["merchant", "analytics"],
			});

			// Check for new orders after a short delay to let queries refetch
			if (onNewOrder) {
				setTimeout(() => {
					const updatedOrders = queryClient.getQueryData<{
						data?: Array<{ id: string }>;
					}>(["orders"]);

					if (currentOrders?.data && updatedOrders?.data) {
						const currentIds = new Set(currentOrders.data.map((o) => o.id));
						const newOrders = updatedOrders.data.filter(
							(order) =>
								!currentIds.has(order.id) &&
								!previousOrdersRef.current.has(order.id),
						);

						// Notify about new orders
						for (const order of newOrders) {
							onNewOrder(order);
							previousOrdersRef.current.add(order.id);
						}
					}
				}, 500);
			}
		}, interval);

		return () => {
			if (intervalRef.current) {
				clearInterval(intervalRef.current);
				intervalRef.current = null;
			}
		};
	}, [enabled, interval, queryClient, onNewOrder]);

	// Always return connected as true for polling (no actual connection state)
	return { isConnected: enabled };
};

/**
 * TODO: WebSocket Implementation
 *
 * When WebSocket backend is ready (see apps/server/src/features/merchant/order/WEBSOCKET_TODO.md):
 *
 * 1. Create WebSocket connection to order room:
 *    const ws = new WebSocket(`wss://${host}/ws/order/${orderId}`)
 *
 * 2. Listen for merchant-related events:
 *    - MERCHANT_ACCEPTED
 *    - MERCHANT_REJECTED
 *    - MERCHANT_PREPARING
 *    - MERCHANT_READY
 *    - DRIVER_ACCEPTED (driver assigned to merchant's order)
 *    - COMPLETED (order completed)
 *    - CANCELED (order cancelled)
 *
 * 3. On event received:
 *    - Update query cache with new order data
 *    - Show toast notification
 *    - Play notification sound (optional)
 *
 * 4. Return WebSocket connection state:
 *    return { isConnected: ws.readyState === WebSocket.OPEN }
 *
 * Example:
 * ```ts
 * const ws = useRef<WebSocket | null>(null);
 * const [isConnected, setIsConnected] = useState(false);
 *
 * useEffect(() => {
 *   if (!enabled || !merchantId) return;
 *
 *   ws.current = new WebSocket(`${wsUrl}/ws/merchant/${merchantId}/orders`);
 *
 *   ws.current.onopen = () => setIsConnected(true);
 *   ws.current.onclose = () => setIsConnected(false);
 *
 *   ws.current.onmessage = (event) => {
 *     const envelope = JSON.parse(event.data);
 *     switch (envelope.event) {
 *       case "MERCHANT_ACCEPTED":
 *         queryClient.setQueryData(["order", envelope.payload.orderId], envelope.payload.order);
 *         toast.success("Order accepted successfully");
 *         break;
 *       // ... handle other events
 *     }
 *   };
 *
 *   return () => ws.current?.close();
 * }, [enabled, merchantId]);
 * ```
 */
