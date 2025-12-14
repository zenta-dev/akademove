import { env } from "cloudflare:workers";
import { z } from "zod";
import { BaseDurableObject } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import { logger } from "@/utils/logger";

/**
 * WebSocket envelope schema for driver location updates
 */
const DriverLocationEnvelopeSchema = z.object({
	/** Action type */
	a: z.literal("UPDATE_LOCATION"),
	/** From: client */
	f: z.literal("c"),
	/** To: server */
	t: z.literal("s"),
	/** Payload */
	p: z.object({
		driverId: z.string(),
		x: z.number(), // longitude
		y: z.number(), // latitude
	}),
});

type DriverLocationEnvelope = z.infer<typeof DriverLocationEnvelopeSchema>;

/**
 * DriverLocationRoom - Durable Object for driver location updates when not on an active order
 *
 * This room handles:
 * - Real-time driver location updates via WebSocket
 * - Server-side persistence with deduplication to prevent DB heating
 * - Used by drivers when online but not actively handling an order
 *
 * Note: When a driver accepts an order, they should switch to the order-specific
 * WebSocket room for location updates (which broadcasts to the user).
 */
export class DriverLocationRoom extends BaseDurableObject {
	#svc: ServiceContext;
	#repo: RepositoryContext;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
		this.#repo = getRepositories(this.#svc, getManagers());
	}

	/**
	 * Get WebSocket room stub by driver ID
	 */
	static getRoomStubByName(driverId: string) {
		const stubId = env.DRIVER_LOCATION_ROOM.idFromName(driverId);
		const stub = env.DRIVER_LOCATION_ROOM.get(stubId);
		return stub;
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);

		const userId = this.findUserIdBySocket(ws);
		if (!userId) {
			logger.warn("[DriverLocationRoom] No userId found for WebSocket");
			return;
		}

		try {
			const parsed = JSON.parse(message.toString());
			const { success, data, error } =
				DriverLocationEnvelopeSchema.safeParse(parsed);

			if (!success) {
				logger.warn(
					{ error: error.issues, parsed },
					"[DriverLocationRoom] Invalid message format",
				);
				return;
			}

			if (data.a === "UPDATE_LOCATION") {
				await this.#handleLocationUpdate(data);
			}
		} catch (error) {
			logger.error(
				{ error, userId },
				"[DriverLocationRoom] Failed to process message",
			);
		}
	}

	/**
	 * Handle driver location update with deduplication
	 */
	async #handleLocationUpdate(data: DriverLocationEnvelope) {
		const { driverId, x, y } = data.p;

		try {
			// Get current driver location for deduplication check
			const driver = await this.#repo.driver.main.get(driverId);
			const currentLocation = driver.currentLocation;

			// Skip DB write if location hasn't changed (deduplication to prevent DB heating)
			const isSameLocation =
				currentLocation != null &&
				currentLocation.x === x &&
				currentLocation.y === y;

			if (isSameLocation) {
				logger.debug(
					{ driverId },
					"[DriverLocationRoom] Skipping location persist - same as current",
				);
				return;
			}

			// Persist new location
			await this.#repo.driver.main.updateLocation(driverId, { x, y });

			logger.debug(
				{ driverId, x, y },
				"[DriverLocationRoom] Driver location persisted",
			);
		} catch (error) {
			logger.error(
				{ error, driverId },
				"[DriverLocationRoom] Failed to persist driver location",
			);
		}
	}
}
