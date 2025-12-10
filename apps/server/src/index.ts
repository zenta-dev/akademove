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

export default {
	fetch: app.fetch,
	async scheduled(event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
		logger.info({ cron: event.cron }, "[Cron] Triggered scheduled event");

		// Auto-offline driver based on schedule
		ctx.waitUntil(
			handleAutoOfflineCron().catch((error) => {
				logger.error({ error }, "[Cron] Auto-offline handler failed");
			}),
		);

		// Calculate leaderboards
		ctx.waitUntil(
			handleLeaderboardCron(env, ctx).catch((error) => {
				logger.error(
					{ error },
					"[Cron] Leaderboard calculation handler failed",
				);
			}),
		);

		// Check and clean up orders
		ctx.waitUntil(
			handleOrderCheckerCron(env, ctx).catch((error) => {
				logger.error({ error }, "[Cron] Order checker handler failed");
			}),
		);

		// Process scheduled orders ready for matching
		ctx.waitUntil(
			handleScheduledOrderCron(env, ctx).catch((error) => {
				logger.error({ error }, "[Cron] Scheduled order handler failed");
			}),
		);

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
