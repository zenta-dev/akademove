import { env } from "cloudflare:workers";
import { scryptSync } from "node:crypto";
import { BetterAuthError, betterAuth } from "better-auth";
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
