import { env } from "cloudflare:workers";
import { createLogger } from "@repo/shared";

export const isDev = env.NODE_ENV !== "production";
export const isCloudflare = env.RUNTIME === "cloudflare";
export const log = createLogger({ nodeEnv: env.NODE_ENV });
