import { env } from "cloudflare:workers";
import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import * as schema from "@/tables/auth";
import type { DatabaseInstance } from "./db";

export const getAuth = (db: DatabaseInstance) =>
	betterAuth({
		database: drizzleAdapter(db, {
			provider: "pg",
			schema: schema,
		}),
		trustedOrigins: [env.CORS_ORIGIN],
		emailAndPassword: {
			enabled: true,
		},
		secret: env.AUTH_SECRET,
		baseURL: env.AUTH_URL,
		basePath: "/auth",
		advanced: {
			defaultCookieAttributes: {
				sameSite: "none",
				secure: true,
				httpOnly: true,
			},
		},
	});

export type AuthInstance = ReturnType<typeof getAuth>;
