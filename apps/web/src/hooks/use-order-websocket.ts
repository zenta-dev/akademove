import type {
	OrderEnvelope,
	OrderEnvelopeActionSchema,
	OrderEnvelopeEventSchema,
} from "@repo/schema/ws";
import { useQueryClient } from "@tanstack/react-query";
import { useCallback, useEffect, useRef, useState } from "react";
import type { z } from "zod";

type OrderEvent = z.infer<typeof OrderEnvelopeEventSchema>;
type OrderAction = z.infer<typeof OrderEnvelopeActionSchema>;

interface UseOrderWebSocketOptions {
	orderId: string | null | undefined;
	enabled?: boolean;
	onEvent?: (event: OrderEvent, envelope: OrderEnvelope) => void;
	onConnectionChange?: (connected: boolean) => void;
}

interface UseOrderWebSocketReturn {
	isConnected: boolean;
	sendAction: (action: OrderAction, payload?: OrderEnvelope["p"]) => void;
	lastEvent: OrderEvent | null;
	lastEnvelope: OrderEnvelope | null;
	reconnect: () => void;
}

/**
 * Hook for WebSocket connection to order tracking room
 *
 * Features:
 * - Auto-reconnect with exponential backoff
 * - Heartbeat/ping-pong for connection health
 * - Automatic query invalidation on events
 * - Type-safe event handling
 *
 * @example
 * ```tsx
 * const { isConnected, lastEnvelope } = useOrderWebSocket({
 *   orderId: order.id,
 *   onEvent: (event, envelope) => {
 *     if (event === "DRIVER_LOCATION_UPDATE") {
 *       // Update map with driver location
 *     }
 *   }
 * });
 * ```
 */
export const useOrderWebSocket = (
	options: UseOrderWebSocketOptions,
): UseOrderWebSocketReturn => {
	const { orderId, enabled = true, onEvent, onConnectionChange } = options;
	const queryClient = useQueryClient();

	const [isConnected, setIsConnected] = useState(false);
	const [lastEvent, setLastEvent] = useState<OrderEvent | null>(null);
	const [lastEnvelope, setLastEnvelope] = useState<OrderEnvelope | null>(null);

	const wsRef = useRef<WebSocket | null>(null);
	const reconnectTimeoutRef = useRef<NodeJS.Timeout | null>(null);
	const reconnectAttemptsRef = useRef(0);
	const heartbeatIntervalRef = useRef<NodeJS.Timeout | null>(null);

	const getWebSocketUrl = useCallback(() => {
		if (!orderId) return null;

		const serverUrl = import.meta.env.VITE_SERVER_URL || "";
		const wsProtocol = serverUrl.startsWith("https") ? "wss" : "ws";
		const wsHost = serverUrl.replace(/^https?:\/\//, "");

		return `${wsProtocol}://${wsHost}/ws/order/${orderId}`;
	}, [orderId]);

	const cleanup = useCallback(() => {
		if (wsRef.current) {
			wsRef.current.close();
			wsRef.current = null;
		}
		if (reconnectTimeoutRef.current) {
			clearTimeout(reconnectTimeoutRef.current);
			reconnectTimeoutRef.current = null;
		}
		if (heartbeatIntervalRef.current) {
			clearInterval(heartbeatIntervalRef.current);
			heartbeatIntervalRef.current = null;
		}
		setIsConnected(false);
		onConnectionChange?.(false);
		console.log("[OrderWebSocket] Cleaned up connection");
	}, [onConnectionChange]);

	const startHeartbeat = useCallback(() => {
		// Send ping every 30 seconds to keep connection alive
		heartbeatIntervalRef.current = setInterval(() => {
			if (wsRef.current?.readyState === WebSocket.OPEN) {
				wsRef.current.send(JSON.stringify({ type: "ping" }));
			}
		}, 30000);
	}, []);

	const connect = useCallback(() => {
		if (!enabled || !orderId) {
			cleanup();
			return;
		}

		const wsUrl = getWebSocketUrl();
		if (!wsUrl) return;

		try {
			const ws = new WebSocket(wsUrl);
			wsRef.current = ws;

			ws.onopen = () => {
				setIsConnected(true);
				onConnectionChange?.(true);
				reconnectAttemptsRef.current = 0;
				startHeartbeat();
			};

			ws.onclose = () => {
				setIsConnected(false);
				onConnectionChange?.(false);
				if (heartbeatIntervalRef.current) {
					clearInterval(heartbeatIntervalRef.current);
					heartbeatIntervalRef.current = null;
				}

				// Auto-reconnect with exponential backoff (max 5 attempts)
				if (enabled && reconnectAttemptsRef.current < 5) {
					const delay = Math.min(
						1000 * 2 ** reconnectAttemptsRef.current,
						30000,
					);
					reconnectAttemptsRef.current++;
					reconnectTimeoutRef.current = setTimeout(() => {
						connect();
					}, delay);
				}
			};

			ws.onerror = (error) => {
				console.error("[OrderWebSocket] Error:", error);
			};

			ws.onmessage = (event) => {
				try {
					const envelope = JSON.parse(event.data) as OrderEnvelope;

					// Handle pong response (server acknowledges ping)
					if ("type" in envelope && envelope.type === "pong") {
						return;
					}

					// Only process events from server (f: "s")
					if (envelope.f !== "s" || !envelope.e) return;

					const eventType = envelope.e;
					setLastEvent(eventType);
					setLastEnvelope(envelope);

					// Call custom event handler
					onEvent?.(eventType, envelope);

					// Invalidate relevant queries based on event
					switch (eventType) {
						case "DRIVER_ACCEPTED":
							queryClient.invalidateQueries();
							break;

						case "DRIVER_LOCATION_UPDATE":
							queryClient.invalidateQueries();
							break;

						case "COMPLETED":
						case "CANCELED":
							queryClient.invalidateQueries();
							break;

						case "MATCHING":
						case "OFFER":
						case "UNAVAILABLE":
							queryClient.invalidateQueries();
							break;

						case "CHAT_MESSAGE":
							queryClient.invalidateQueries();
							break;
					}
				} catch (error) {
					console.error("[OrderWebSocket] Failed to parse message:", error);
				}
			};
		} catch (error) {
			console.error("[OrderWebSocket] Failed to connect:", error);
		}
	}, [
		enabled,
		orderId,
		getWebSocketUrl,
		cleanup,
		startHeartbeat,
		onConnectionChange,
		onEvent,
		queryClient,
	]);

	const sendAction = useCallback(
		(action: OrderAction, payload?: OrderEnvelope["p"]) => {
			if (!wsRef.current || wsRef.current.readyState !== WebSocket.OPEN) {
				console.warn("[OrderWebSocket] Cannot send action: not connected");
				return;
			}

			const envelope: OrderEnvelope = {
				a: action,
				f: "c",
				t: "s",
				p: payload || {},
			};

			wsRef.current.send(JSON.stringify(envelope));
		},
		[],
	);

	const reconnect = useCallback(() => {
		cleanup();
		reconnectAttemptsRef.current = 0;
		connect();
	}, [cleanup, connect]);

	useEffect(() => {
		connect();
		return cleanup;
	}, [connect, cleanup]);

	return {
		isConnected,
		sendAction,
		lastEvent,
		lastEnvelope,
		reconnect,
	};
};
