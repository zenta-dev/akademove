import { useQueryClient } from "@tanstack/react-query";
import { useEffect, useRef, useState } from "react";
import { toast } from "sonner";

interface UseOrderUpdatesOptions {
	enabled?: boolean;
	role?: "USER" | "DRIVER" | "MERCHANT";
	orderId?: string;
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
		onNewOrder,
		onOrderUpdate,
		onDriverLocation,
	} = options;

	const queryClient = useQueryClient();
	const wsRef = useRef<WebSocket | null>(null);
	const reconnectTimeoutRef = useRef<NodeJS.Timeout | null>(null);
	const [isConnected, setIsConnected] = useState(false);
	const [error, setError] = useState<string | undefined>();

	const getWebSocketUrl = () => {
		const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
		const host = window.location.host;

		if (orderId) {
			// Connect to specific order room
			return `${protocol}//${host}/ws/order/${orderId}`;
		}
		if (role === "DRIVER") {
			// Connect to driver pool for order assignments
			return `${protocol}//${host}/ws/driver-pool`;
		}
		// Default to payment room for general updates
		return `${protocol}//${host}/ws/payment/general`;
	};

	const connect = () => {
		if (!enabled || wsRef.current?.readyState === WebSocket.OPEN) {
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
				if (enabled && event.code !== 1000) {
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
					const envelope = JSON.parse(event.data);
					handleMessage(envelope);
				} catch (err) {
					console.error("Failed to parse WebSocket message:", err);
				}
			};
		} catch (err) {
			console.error("Failed to create WebSocket connection:", err);
			setError("Failed to connect");
		}
	};

	const handleMessage = (envelope: any) => {
		switch (envelope.event) {
			case "NEW_ORDER":
				if (onNewOrder) {
					onNewOrder(envelope.payload);
					// Invalidate order list queries
					queryClient.invalidateQueries({ queryKey: ["orders"] });
				}
				break;

			case "ORDER_UPDATE":
				if (onOrderUpdate) {
					onOrderUpdate(envelope.payload);
				}
				// Update specific order in cache
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				// Invalidate order list queries
				queryClient.invalidateQueries({ queryKey: ["orders"] });
				break;

			case "DRIVER_LOCATION":
				if (
					onDriverLocation &&
					envelope.payload?.orderId &&
					envelope.payload?.location
				) {
					onDriverLocation({
						orderId: envelope.payload.orderId,
						location: envelope.payload.location,
					});
				}
				break;

			case "ORDER_ACCEPTED":
				toast.success("Order has been accepted by a driver");
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				queryClient.invalidateQueries({ queryKey: ["orders"] });
				break;

			case "ORDER_CANCELLED":
				toast.error("Order has been cancelled");
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				queryClient.invalidateQueries({ queryKey: ["orders"] });
				break;

			case "DRIVER_ARRIVED":
				toast.info("Driver has arrived at pickup location");
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				break;

			case "ORDER_COMPLETED":
				toast.success("Order has been completed");
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				queryClient.invalidateQueries({ queryKey: ["orders"] });
				break;

			case "MERCHANT_ACCEPTED":
				toast.success("Merchant has accepted your order");
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				queryClient.invalidateQueries({ queryKey: ["orders"] });
				break;

			case "MERCHANT_READY":
				toast.info("Your order is ready for pickup");
				if (envelope.payload?.orderId) {
					queryClient.setQueryData(
						["order", envelope.payload.orderId],
						envelope.payload.order,
					);
				}
				break;

			default:
				console.log("Unknown WebSocket event:", envelope.event);
		}
	};

	const disconnect = () => {
		if (reconnectTimeoutRef.current) {
			clearTimeout(reconnectTimeoutRef.current);
			reconnectTimeoutRef.current = null;
		}

		if (wsRef.current) {
			wsRef.current.close(1000, "Component unmounted");
			wsRef.current = null;
		}

		setIsConnected(false);
	};

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
