import { env } from "cloudflare:workers";
import { createLogger } from "@repo/shared";

export const log = createLogger({
	nodeEnv: env.NODE_ENV,
});
