import alchemy from "alchemy";
import {
	Hyperdrive,
	KVNamespace,
	TanStackStart,
	Worker,
} from "alchemy/cloudflare";
import { config } from "dotenv";

config({ path: "./.env" });

const APP_NAME = "akademove";
const app = await alchemy(APP_NAME);
const NODE_ENV = alchemy.env.NODE_ENV || "development";
const isDev = NODE_ENV === "development";
const zoneId = alchemy.env.ZONE_ID;

const [mainDB, sessionKV] = await Promise.all([
	Hyperdrive(`${APP_NAME}-db-${NODE_ENV}`, {
		name: `${APP_NAME}-db-${NODE_ENV}`,
		origin: alchemy.secret.env.DATABASE_URL,
	}),
	KVNamespace(`${APP_NAME}-session-kv-${NODE_ENV}`, {
		title: `${APP_NAME}-session-kv-${NODE_ENV}`,
	}),
]);

export const [server, web] = await Promise.all([
	Worker(`${APP_NAME}-server-${NODE_ENV}`, {
		name: `${APP_NAME}-server-${NODE_ENV}`,
		cwd: "apps/server",
		entrypoint: "src/index.ts",
		compatibility: "node",
		bundle: { minify: !isDev, sourcemap: isDev },
		bindings: {
			NODE_ENV: alchemy.env.NODE_ENV,
			RUNTIME: alchemy.env.RUNTIME,
			CORS_ORIGIN: alchemy.env.CORS_ORIGIN,
			AUTH_SECRET: alchemy.secret(alchemy.env.AUTH_SECRET),
			AUTH_URL: alchemy.env.AUTH_URL,
			MAIN_DB: mainDB,
			SESSION_KV: sessionKV,
		},
		dev: {
			port: 3000,
		},
		domains: [
			{ domainName: `${APP_NAME}-server-${NODE_ENV}.zenta.dev`, zoneId },
		],
	}),
	TanStackStart(`${APP_NAME}-web-${NODE_ENV}`, {
		name: `${APP_NAME}-web-${NODE_ENV}`,
		cwd: "apps/web",
		bundle: { minify: !isDev, sourcemap: isDev },
		bindings: {
			VITE_NODE_ENV: alchemy.env.NODE_ENV,
			VITE_SERVER_URL: alchemy.env.SERVER_URL,
		},
		dev: {
			command: "bun run dev",
		},
		domains: [{ domainName: `${APP_NAME}-web-${NODE_ENV}.zenta.dev`, zoneId }],
	}),
]);

export type ServerEnv = typeof server.Env;

console.log(`Server -> ${server.url}`);
console.log(`Web    -> ${web.url}`);

await app.finalize();
