import "./polyfill";

import type { QueueMessage } from "@repo/schema/queue";
import { setupHonoRouter } from "@/core/router/hono";
import { setupOrpcRouter } from "./core/router/orpc";
import { handleAutoOfflineCron } from "./features/driver/cron/auto-offline-handler";
import { handleLeaderboardCron } from "./features/leaderboard/leaderboard-cron";
import { handleOrderCheckerCron } from "./features/order/order-checker-cron";
import { handleScheduledOrderCron } from "./features/order/scheduled-order-cron";
import { handleQueue } from "./features/queue/queue-handler";
import { setupWebsocketRouter } from "./features/ws";
import { logger } from "./utils/logger";

const app = setupHonoRouter();
setupOrpcRouter(app);
setupWebsocketRouter(app);

/**
 * Cron schedule patterns:
 * - "* * * * *"      = Every minute (auto-offline, scheduled orders)
 * - "*/5 * * * *"    = Every 5 minutes (order checker)
 * - "*/15 * * * *"   = Every 15 minutes (leaderboard)
 */
export default {
	fetch: app.fetch,
	async scheduled(event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
		logger.info({ cron: event.cron }, "[Cron] Triggered scheduled event");

		// Every minute: Auto-offline driver based on class schedule
		// Needs minute precision to set drivers offline when class starts
		if (event.cron === "* * * * *") {
			ctx.waitUntil(
				handleAutoOfflineCron().catch((error) => {
					logger.error({ error }, "[Cron] Auto-offline handler failed");
				}),
			);

			// Every minute: Process scheduled orders ready for matching
			// Needs minute precision as matching starts 15min before scheduled time
			ctx.waitUntil(
				handleScheduledOrderCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Scheduled order handler failed");
				}),
			);
		}

		// Every 5 minutes: Check and clean up orders (timeouts, no-shows, etc.)
		// Handles 10min MATCHING timeout, 30min NO_SHOW, 60min completion - 5min intervals sufficient
		if (event.cron === "*/5 * * * *") {
			ctx.waitUntil(
				handleOrderCheckerCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Order checker handler failed");
				}),
			);
		}

		// Every 15 minutes: Calculate leaderboards
		// Rankings don't need real-time updates, 15min refresh is adequate
		if (event.cron === "*/15 * * * *") {
			ctx.waitUntil(
				handleLeaderboardCron(env, ctx).catch((error) => {
					logger.error(
						{ error },
						"[Cron] Leaderboard calculation handler failed",
					);
				}),
			);
		}

		const logAsync = async () => {
			logger.info("[Cron] Scheduled event processing completed");
			console.log(
				`[Cron] Scheduled event ${event.cron} processed at ${new Date().toISOString()}`,
			);
		};
		ctx.waitUntil(logAsync());
	},
	async queue(
		batch: MessageBatch<QueueMessage>,
		env: Env,
		ctx: ExecutionContext,
	) {
		await handleQueue(batch, env, ctx);
	},
};
export * from "./features/ws";
