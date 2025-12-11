import { useQueryClient } from "@tanstack/react-query";
import { useCallback, useEffect, useRef, useState } from "react";
import { toast } from "sonner";

interface WebSocketEnvelope {
	e?: string; // event (server format)
	event?: string; // event (legacy format)
	p?: {
		orderId?: string;
		order?: unknown;
		merchantId?: string;
		itemCount?: number;
		totalAmount?: number;
		cancelReason?: string;
		driverName?: string;
		newStatus?: string;
		location?: { lat: number; lng: number };
	};
	payload?: {
		orderId?: string;
		order?: unknown;
		location?: { lat: number; lng: number };
	};
}

interface UseOrderUpdatesOptions {
	enabled?: boolean;
	role?: "USER" | "DRIVER" | "MERCHANT";
	orderId?: string;
	merchantId?: string;
	interval?: number;
	onNewOrder?: (order: unknown) => void;
	onOrderUpdate?: (order: unknown) => void;
	onDriverLocation?: (data: {
		orderId: string;
		location: { lat: number; lng: number };
	}) => void;
}

interface UseOrderUpdatesReturn {
	isConnected: boolean;
	error?: string;
}

/**
 * Hook to subscribe to real-time order updates via WebSocket
 *
 * Features:
 * - WebSocket connection for real-time updates
 * - Automatic reconnection on connection loss
 * - Role-based room subscriptions
 * - Order-specific updates
 * - Driver location tracking
 *
 * @param options - Configuration options
 * @param options.enabled - Whether to enable real-time updates (default: true)
 * @param options.role - User role for room subscription
 * @param options.orderId - Specific order ID to track
 * @param options.onNewOrder - Callback when a new order is detected (for merchants)
 * @param options.onOrderUpdate - Callback when order status changes
 * @param options.onDriverLocation - Callback when driver location updates
 */
export const useOrderUpdates = (
	options: UseOrderUpdatesOptions = {},
): UseOrderUpdatesReturn => {
	const {
		enabled = true,
		role = "USER",
		orderId,
		merchantId,
		onNewOrder,
		onOrderUpdate,
		onDriverLocation,
	} = options;

	const queryClient = useQueryClient();
	const wsRef = useRef<WebSocket | null>(null);
	const reconnectTimeoutRef = useRef<NodeJS.Timeout | null>(null);
	const [isConnected, setIsConnected] = useState(false);
	const [error, setError] = useState<string | undefined>();

	// Store callbacks in refs to avoid recreating connect/disconnect
	const onNewOrderRef = useRef(onNewOrder);
	const onOrderUpdateRef = useRef(onOrderUpdate);
	const onDriverLocationRef = useRef(onDriverLocation);

	// Update refs when callbacks change
	useEffect(() => {
		onNewOrderRef.current = onNewOrder;
	}, [onNewOrder]);

	useEffect(() => {
		onOrderUpdateRef.current = onOrderUpdate;
	}, [onOrderUpdate]);

	useEffect(() => {
		onDriverLocationRef.current = onDriverLocation;
	}, [onDriverLocation]);

	const getWebSocketUrl = useCallback(() => {
		const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
		const host = window.location.host;

		if (orderId) {
			// Connect to specific order room
			return `${protocol}//${host}/ws/order/${orderId}`;
		}
		if (role === "MERCHANT" && merchantId) {
			// Connect to merchant-specific room for incoming order notifications
			return `${protocol}//${host}/ws/merchant/${merchantId}/orders`;
		}
		if (role === "DRIVER") {
			// Connect to driver pool for order assignments
			return `${protocol}//${host}/ws/driver-pool`;
		}
		// Default to payment room for general updates
		return `${protocol}//${host}/ws/payment/general`;
	}, [orderId, role, merchantId]);

	const handleMessage = useCallback(
		(envelope: WebSocketEnvelope) => {
			// Support both server format (e) and legacy format (event)
			const event = envelope.e ?? envelope.event;
			// Support both server format (p) and legacy format (payload)
			const payload = envelope.p ?? envelope.payload;

			switch (event) {
				case "NEW_ORDER":
					if (onNewOrderRef.current) {
						onNewOrderRef.current(payload);
						// Invalidate order list queries
						queryClient.invalidateQueries({ queryKey: ["orders"] });
						queryClient.invalidateQueries({ queryKey: ["merchant", "orders"] });
					}
					break;

				case "ORDER_UPDATE":
				case "ORDER_STATUS_CHANGED":
					if (onOrderUpdateRef.current) {
						onOrderUpdateRef.current(payload);
					}
					// Update specific order in cache
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					// Invalidate order list queries
					queryClient.invalidateQueries({ queryKey: ["orders"] });
					queryClient.invalidateQueries({ queryKey: ["merchant", "orders"] });
					break;

				case "DRIVER_LOCATION":
				case "DRIVER_LOCATION_UPDATE":
					if (
						onDriverLocationRef.current &&
						payload?.orderId &&
						payload?.location
					) {
						onDriverLocationRef.current({
							orderId: payload.orderId,
							location: payload.location,
						});
					}
					break;

				case "ORDER_ACCEPTED":
				case "DRIVER_ACCEPTED":
					toast.success("Order has been accepted by a driver");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					queryClient.invalidateQueries({ queryKey: ["orders"] });
					queryClient.invalidateQueries({ queryKey: ["merchant", "orders"] });
					break;

				case "ORDER_CANCELLED":
				case "CANCELED":
					toast.error("Order has been cancelled");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					queryClient.invalidateQueries({ queryKey: ["orders"] });
					queryClient.invalidateQueries({ queryKey: ["merchant", "orders"] });
					break;

				case "DRIVER_ARRIVED":
					toast.info("Driver has arrived at pickup location");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					break;

				case "ORDER_COMPLETED":
				case "COMPLETED":
					toast.success("Order has been completed");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					queryClient.invalidateQueries({ queryKey: ["orders"] });
					queryClient.invalidateQueries({ queryKey: ["merchant", "orders"] });
					break;

				case "MERCHANT_ACCEPTED":
					toast.success("Merchant has accepted your order");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					queryClient.invalidateQueries({ queryKey: ["orders"] });
					break;

				case "MERCHANT_READY":
					toast.info("Your order is ready for pickup");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					break;

				case "DRIVER_ASSIGNED":
					toast.info("A driver has been assigned to your order");
					if (payload?.orderId) {
						queryClient.setQueryData(["order", payload.orderId], payload.order);
					}
					queryClient.invalidateQueries({ queryKey: ["orders"] });
					queryClient.invalidateQueries({ queryKey: ["merchant", "orders"] });
					break;

				default:
					console.log("Unknown WebSocket event:", event);
			}
		},
		[queryClient],
	);

	const disconnect = useCallback(() => {
		if (reconnectTimeoutRef.current) {
			clearTimeout(reconnectTimeoutRef.current);
			reconnectTimeoutRef.current = null;
		}

		if (wsRef.current) {
			wsRef.current.close(1000, "Component unmounted");
			wsRef.current = null;
		}

		setIsConnected(false);
	}, []);

	const connect = useCallback(() => {
		if (wsRef.current?.readyState === WebSocket.OPEN) {
			return;
		}

		try {
			const wsUrl = getWebSocketUrl();
			wsRef.current = new WebSocket(wsUrl);

			wsRef.current.onopen = () => {
				setIsConnected(true);
				setError(undefined);
				console.log(`WebSocket connected to ${wsUrl}`);
			};

			wsRef.current.onclose = (event) => {
				setIsConnected(false);
				console.log(`WebSocket disconnected: ${event.code} ${event.reason}`);

				// Attempt reconnection after delay
				if (event.code !== 1000) {
					reconnectTimeoutRef.current = setTimeout(() => {
						console.log("Attempting to reconnect WebSocket...");
						connect();
					}, 3000);
				}
			};

			wsRef.current.onerror = (event) => {
				console.error("WebSocket error:", event);
				setError("Connection error");
			};

			wsRef.current.onmessage = (event) => {
				try {
					const envelope = JSON.parse(event.data) as WebSocketEnvelope;
					handleMessage(envelope);
				} catch (err) {
					console.error("Failed to parse WebSocket message:", err);
				}
			};
		} catch (err) {
			console.error("Failed to create WebSocket connection:", err);
			setError("Failed to connect");
		}
	}, [getWebSocketUrl, handleMessage]);

	useEffect(() => {
		if (enabled) {
			connect();
		} else {
			disconnect();
		}

		return () => {
			disconnect();
		};
	}, [enabled, connect, disconnect]);

	return { isConnected, error };
};

/**
 * Fallback polling implementation for environments without WebSocket support
 * This can be used as a backup when WebSocket connections fail
 */
export const useOrderUpdatesPolling = (
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
