import "./polyfill";

import { setupHonoRouter } from "@/core/router/hono";
import { setupOrpcRouter } from "./core/router/orpc";
import { handleAutoOfflineCron } from "./features/driver/cron/auto-offline-handler";
import { setupWebsocketRouter } from "./features/ws";
import { log } from "./utils";

const app = setupHonoRouter();
setupOrpcRouter(app);
setupWebsocketRouter(app);

export default {
	fetch: app.fetch,
	async scheduled(event: ScheduledEvent, _env: Env, ctx: ExecutionContext) {
		log.info({ cron: event.cron }, "[Cron] Triggered scheduled event");

		// Auto-offline driver based on schedule
		ctx.waitUntil(
			handleAutoOfflineCron().catch((error) => {
				log.error({ error }, "[Cron] Auto-offline handler failed");
			}),
		);
	},
};
export * from "./features/ws";
