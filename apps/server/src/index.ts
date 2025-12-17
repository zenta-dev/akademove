import "./polyfill";

import type { QueueMessage } from "@repo/schema/queue";
import { setupHonoRouter } from "@/core/router/hono";
import { setupOrpcRouter } from "./core/router/orpc";
import { handleAccountDeletionCron } from "./features/account-deletion/cron/account-deletion-cron";
import { handleBannerExpiryCron } from "./features/banner/cron/banner-expiry-handler";
import { handleCouponExpiryCron } from "./features/coupon/cron/coupon-expiry-handler";
import { handleAutoOfflineCron } from "./features/driver/cron/auto-offline-handler";
import { handleStaleLocationCron } from "./features/driver/cron/stale-location-handler";
import { handleLeaderboardCron } from "./features/leaderboard/leaderboard-cron";
import { handleFcmCleanupCron } from "./features/notification/cron/fcm-cleanup-handler";
import { handleDriverRebroadcastCron } from "./features/order/driver-rebroadcast-cron";
import { handleOrderCheckerCron } from "./features/order/order-checker-cron";
import { handleOrderRebroadcastCron } from "./features/order/order-rebroadcast-cron";
import { handleScheduledOrderCron } from "./features/order/scheduled-order-cron";
import { handlePaymentExpiryCron } from "./features/payment/cron/payment-expiry-handler";
import { handleDlqMonitorCron } from "./features/queue/cron/dlq-monitor-handler";
import { handleQueue } from "./features/queue/queue-handler";
import { handleReportEscalationCron } from "./features/report/cron/report-escalation-handler";
import { handleBanExpiryCron } from "./features/user/cron/ban-expiry-handler";
import { setupWebsocketRouter } from "./features/ws";
import { logger } from "./utils/logger";

const app = setupHonoRouter();
setupOrpcRouter(app);
setupWebsocketRouter(app);

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

			// Every minute: Rebroadcast active order states for clients that may have missed updates
			// Ensures clients stay in sync with server state even if WebSocket messages were missed
			ctx.waitUntil(
				handleOrderRebroadcastCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Order rebroadcast handler failed");
				}),
			);
		}

		// Every 2 minutes: Rebroadcast orders to driver pool if no driver accepted
		// Handles cases where first broadcast had no drivers or all drivers ignored the order
		if (event.cron === "*/2 * * * *") {
			ctx.waitUntil(
				handleDriverRebroadcastCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Driver rebroadcast handler failed");
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

			// Every 5 minutes: Mark drivers as offline if their location hasn't been updated in 15 minutes
			ctx.waitUntil(
				handleStaleLocationCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Stale location handler failed");
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

		// Hourly: Ban expiry, Payment expiry, Report escalation, DLQ monitor
		if (event.cron === "0 * * * *") {
			// Clear expired user bans
			ctx.waitUntil(
				handleBanExpiryCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Ban expiry handler failed");
				}),
			);

			// Mark expired payments as EXPIRED
			ctx.waitUntil(
				handlePaymentExpiryCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Payment expiry handler failed");
				}),
			);

			// Escalate stale PENDING reports to INVESTIGATING
			ctx.waitUntil(
				handleReportEscalationCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Report escalation handler failed");
				}),
			);

			// Alert admins if DLQ has messages
			ctx.waitUntil(
				handleDlqMonitorCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] DLQ monitor handler failed");
				}),
			);
		}

		// Daily at midnight: Coupon expiry, Banner expiry
		if (event.cron === "0 0 * * *") {
			// Deactivate expired coupons
			ctx.waitUntil(
				handleCouponExpiryCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Coupon expiry handler failed");
				}),
			);

			// Deactivate expired banners
			ctx.waitUntil(
				handleBannerExpiryCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Banner expiry handler failed");
				}),
			);
		}

		// Daily at 2 AM: Account deletion processing
		if (event.cron === "0 2 * * *") {
			ctx.waitUntil(
				handleAccountDeletionCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] Account deletion handler failed");
				}),
			);
		}

		// Weekly on Sunday at 4 AM: FCM token cleanup
		if (event.cron === "0 4 * * SUN") {
			ctx.waitUntil(
				handleFcmCleanupCron(env, ctx).catch((error) => {
					logger.error({ error }, "[Cron] FCM cleanup handler failed");
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
