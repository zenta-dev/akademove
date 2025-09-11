import { env } from "cloudflare:workers";

export const isDev = env.NODE_ENV !== "production";
