import "./polyfill";

import type { QueueMessage } from "@repo/schema/queue";
import { logger } from "./utils/logger";

// Lazy-loaded app instance to avoid CPU timeout during startup
let _app: Awaited<ReturnType<typeof initApp>> | null = null;

async function initApp() {
	const { setupHonoRouter } = await import("@/core/router/hono");
	const { setupOrpcRouter } = await import("./core/router/orpc");
	const { setupWebsocketRouter } = await import("./features/ws");

	const app = setupHonoRouter();
	setupOrpcRouter(app);
	setupWebsocketRouter(app);
	return app;
}

async function getApp() {
	if (!_app) {
		_app = await initApp();
	}
	return _app;
}

export default {
	async fetch(request: Request, env: Env, ctx: ExecutionContext) {
		const app = await getApp();
		return app.fetch(request, env, ctx);
	},
	async scheduled(event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
		logger.info({ cron: event.cron }, "[Cron] Triggered scheduled event");

		// Every minute: Auto-offline driver based on class schedule
		// Needs minute precision to set drivers offline when class starts
		if (event.cron === "* * * * *") {
			ctx.waitUntil(
				import("./features/driver/cron/auto-offline-handler").then((m) =>
					m.handleAutoOfflineCron().catch((error: unknown) => {
						logger.error({ error }, "[Cron] Auto-offline handler failed");
					}),
				),
			);

			// Every minute: Process scheduled orders ready for matching
			// Needs minute precision as matching starts 15min before scheduled time
			ctx.waitUntil(
				import("./features/order/scheduled-order-cron").then((m) =>
					m.handleScheduledOrderCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Scheduled order handler failed");
					}),
				),
			);

			// Every minute: Rebroadcast active order states for clients that may have missed updates
			// Ensures clients stay in sync with server state even if WebSocket messages were missed
			ctx.waitUntil(
				import("./features/order/order-rebroadcast-cron").then((m) =>
					m.handleOrderRebroadcastCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Order rebroadcast handler failed");
					}),
				),
			);
		}

		// Every 2 minutes: Rebroadcast orders to driver pool if no driver accepted
		// Handles cases where first broadcast had no drivers or all drivers ignored the order
		if (event.cron === "*/2 * * * *") {
			ctx.waitUntil(
				import("./features/order/driver-rebroadcast-cron").then((m) =>
					m.handleDriverRebroadcastCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Driver rebroadcast handler failed");
					}),
				),
			);
		}

		// Every 5 minutes: Check and clean up orders (timeouts, no-shows, etc.)
		// Handles 10min MATCHING timeout, 30min NO_SHOW, 60min completion - 5min intervals sufficient
		if (event.cron === "*/5 * * * *") {
			ctx.waitUntil(
				import("./features/order/order-checker-cron").then((m) =>
					m.handleOrderCheckerCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Order checker handler failed");
					}),
				),
			);

			// Every 5 minutes: Mark drivers as offline if their location hasn't been updated in 15 minutes
			ctx.waitUntil(
				import("./features/driver/cron/stale-location-handler").then((m) =>
					m.handleStaleLocationCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Stale location handler failed");
					}),
				),
			);
		}

		// Every 15 minutes: Calculate leaderboards
		// Rankings don't need real-time updates, 15min refresh is adequate
		if (event.cron === "*/15 * * * *") {
			ctx.waitUntil(
				import("./features/leaderboard/leaderboard-cron").then((m) =>
					m.handleLeaderboardCron(env, ctx).catch((error: unknown) => {
						logger.error(
							{ error },
							"[Cron] Leaderboard calculation handler failed",
						);
					}),
				),
			);
		}

		// Hourly: Ban expiry, Payment expiry, Report escalation, DLQ monitor
		if (event.cron === "0 * * * *") {
			// Clear expired user bans
			ctx.waitUntil(
				import("./features/user/cron/ban-expiry-handler").then((m) =>
					m.handleBanExpiryCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Ban expiry handler failed");
					}),
				),
			);

			// Mark expired payments as EXPIRED
			ctx.waitUntil(
				import("./features/payment/cron/payment-expiry-handler").then((m) =>
					m.handlePaymentExpiryCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Payment expiry handler failed");
					}),
				),
			);

			// Escalate stale PENDING reports to INVESTIGATING
			ctx.waitUntil(
				import("./features/report/cron/report-escalation-handler").then((m) =>
					m.handleReportEscalationCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Report escalation handler failed");
					}),
				),
			);

			// Alert admins if DLQ has messages
			ctx.waitUntil(
				import("./features/queue/cron/dlq-monitor-handler").then((m) =>
					m.handleDlqMonitorCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] DLQ monitor handler failed");
					}),
				),
			);
		}

		// Daily at midnight: Coupon expiry, Banner expiry
		if (event.cron === "0 0 * * *") {
			// Deactivate expired coupons
			ctx.waitUntil(
				import("./features/coupon/cron/coupon-expiry-handler").then((m) =>
					m.handleCouponExpiryCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Coupon expiry handler failed");
					}),
				),
			);

			// Deactivate expired banners
			ctx.waitUntil(
				import("./features/banner/cron/banner-expiry-handler").then((m) =>
					m.handleBannerExpiryCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] Banner expiry handler failed");
					}),
				),
			);
		}

		// Daily at 2 AM: Account deletion processing
		if (event.cron === "0 2 * * *") {
			ctx.waitUntil(
				import("./features/account-deletion/cron/account-deletion-cron").then(
					(m) =>
						m.handleAccountDeletionCron(env, ctx).catch((error: unknown) => {
							logger.error({ error }, "[Cron] Account deletion handler failed");
						}),
				),
			);
		}

		// Weekly on Sunday at 4 AM: FCM token cleanup
		if (event.cron === "0 4 * * SUN") {
			ctx.waitUntil(
				import("./features/notification/cron/fcm-cleanup-handler").then((m) =>
					m.handleFcmCleanupCron(env, ctx).catch((error: unknown) => {
						logger.error({ error }, "[Cron] FCM cleanup handler failed");
					}),
				),
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
		const { handleQueue } = await import("./features/queue/queue-handler");
		await handleQueue(batch, env, ctx);
	},
};
export * from "./features/ws";
