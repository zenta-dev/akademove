import { env } from "cloudflare:workers";
import { createLogger } from "@repo/shared/logger.server";
import Decimal from "decimal.js";

export const isDev = env.NODE_ENV !== "production";
export const isCloudflare = env.RUNTIME === "cloudflare";
export const log = createLogger({
	nodeEnv: env.NODE_ENV,
	remote: { sourceToken: env.LOG_SOURCE_TOKEN, endpoint: env.LOG_ENDPOINT },
});
