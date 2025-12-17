import { env } from "cloudflare:workers";

export const TRUSTED_ORIGINS = [env.AUTH_URL, env.CORS_ORIGIN];
