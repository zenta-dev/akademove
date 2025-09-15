import { env } from "cloudflare:workers";
import { scryptSync } from "node:crypto";
import { AUTH_CONSTANTS } from "@repo/schema/constants";
import { BetterAuthError, betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { bearer, jwt, openAPI } from "better-auth/plugins";
import * as schema from "@/core/tables/auth";
import { isDev } from "@/utils";
import { TRUSTED_ORIGINS } from "../constants";
import type { DatabaseInstance } from "./db";
import type { KeyValueService } from "./kv";

export const getAuth = (db: DatabaseInstance, kv: KeyValueService) =>
	betterAuth({
		secret: env.AUTH_SECRET,
		baseURL: env.AUTH_URL,
		basePath: "/auth",
		trustedOrigins: TRUSTED_ORIGINS,
		telemetry: { enabled: false },
		database: drizzleAdapter(db, {
			provider: "pg",
			schema: schema,
		}),
		secondaryStorage: {
			get: async (key) => await kv.get(key),
			set: async (key, value, ttl) => {
				if (ttl) await kv.put(key, value, { expirationTtl: ttl });
				else await kv.put(key, value);
			},
			delete: async (key) => await kv.delete(key),
		},
		rateLimit: {
			enabled: true,
			storage: "secondary-storage",
		},
		emailAndPassword: {
			enabled: true,
			password: {
				hash: async (password) => {
					const salt = crypto.getRandomValues(new Uint8Array(16));
					const saltHex = Array.from(salt)
						.map((b) => b.toString(16).padStart(2, "0"))
						.join("");

					const key = scryptSync(password.normalize("NFKC"), saltHex, 64, {
						N: 16384,
						r: 16,
						p: 1,
						maxmem: 128 * 16384 * 16 * 2,
					});

					const keyHex = Array.from(key)
						.map((b) => b.toString(16).padStart(2, "0"))
						.join("");
					return `${saltHex}:${keyHex}`;
				},
				verify: async ({ hash, password }) => {
					const [saltHex, keyHex] = hash.split(":");
					if (!saltHex || !keyHex) {
						throw new BetterAuthError("Invalid password hash");
					}
					const targetKey = scryptSync(
						password.normalize("NFKC"),
						saltHex,
						64,
						{
							N: 16384,
							r: 16,
							p: 1,
							maxmem: 128 * 16384 * 16 * 2,
						},
					);

					const targetKeyHex = Array.from(targetKey)
						.map((b) => b.toString(16).padStart(2, "0"))
						.join("");
					return targetKeyHex === keyHex;
				},
			},
		},
		advanced: {
			cookiePrefix: isDev ? "" : "__Secure-",
			cookies: {
				session_token: { name: AUTH_CONSTANTS.SESSION_TOKEN },
				session_data: { name: AUTH_CONSTANTS.SESSION_DATA },
				dont_remember: { name: AUTH_CONSTANTS.SESSION_DONT_REMEMBER },
			},
			defaultCookieAttributes: {
				sameSite: "none",
				secure: true,
				httpOnly: true,
			},
		},
		plugins: [openAPI(), jwt(), bearer()],
	});

export type AuthInstance = ReturnType<typeof getAuth>;
