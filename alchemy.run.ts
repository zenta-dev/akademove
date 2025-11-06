import alchemy from "alchemy";
import {
	DurableObjectNamespace,
	Hyperdrive,
	KVNamespace,
	TanStackStart,
	Worker,
} from "alchemy/cloudflare";
import { config } from "dotenv";

const isDev =
	process.argv.includes("dev") ||
	process.argv.includes("development") ||
	process.argv.includes("--dev") ||
	process.argv.includes("--development") ||
	(!process.argv.includes("--stage") && !process.argv.includes("production"));

config({ path: isDev ? ".env" : ".env.prod" });

const APP_NAME = "akademove";
const app = await alchemy(APP_NAME, { noTrack: true });
const zoneId = alchemy.env.ZONE_ID;

const [mainDB, mainKV] = await Promise.all([
	Hyperdrive(`${APP_NAME}-db`, {
		name: `${APP_NAME}-db`,
		origin: alchemy.secret.env.DATABASE_URL,
	}),
	KVNamespace(`${APP_NAME}-main-kv`, {
		title: `${APP_NAME}-main-kv`,
	}),
]);

const ORDER_ROOM = DurableObjectNamespace("order-rooms", {
	className: "OrderRoom",
	environment: alchemy.env.NODE_ENV,
	sqlite: true,
});

const WALLET_ROOM = DurableObjectNamespace("wallet-rooms", {
	className: "WalletRoom",
	environment: alchemy.env.NODE_ENV,
	sqlite: true,
});

const LISTING_ROOM = DurableObjectNamespace("listing-rooms", {
	className: "ListingRoom",
	environment: alchemy.env.NODE_ENV,
	sqlite: true,
});

export const [server, web] = await Promise.all([
	Worker(`${APP_NAME}-server`, {
		name: `${APP_NAME}-server`,
		cwd: "apps/server",
		entrypoint: "src/index.ts",
		compatibility: "node",
		bundle: { minify: !isDev, sourcemap: isDev },
		bindings: {
			NODE_ENV: alchemy.env.NODE_ENV,
			RUNTIME: alchemy.env.RUNTIME,
			ROOT_DOMAIN: alchemy.env.ROOT_DOMAIN,
			CORS_ORIGIN: alchemy.env.WEB_URL,
			AUTH_SECRET: alchemy.secret(alchemy.env.AUTH_SECRET),
			AUTH_URL: alchemy.env.AUTH_URL,
			S3_ENDPOINT: alchemy.secret.env.S3_ENDPOINT,
			S3_REGION: alchemy.secret.env.S3_REGION,
			S3_ACCESS_KEY_ID: alchemy.secret.env.S3_ACCESS_KEY_ID,
			S3_SECRET_ACCESS_KEY: alchemy.secret.env.S3_SECRET_ACCESS_KEY,
			S3_PUBLIC_URL: alchemy.env.S3_PUBLIC_URL,
			LOG_SOURCE_TOKEN: alchemy.secret.env.LOG_SOURCE_TOKEN,
			LOG_ENDPOINT: alchemy.secret.env.LOG_ENDPOINT,
			GOOGLE_MAPS_API_KEY: alchemy.secret.env.GOOGLE_MAPS_API_KEY,
			RESEND_API_KEY: alchemy.secret.env.RESEND_API_KEY,
			MIDTRANS_IS_PRODUCTION: alchemy.secret.env.MIDTRANS_IS_PRODUCTION,
			MIDTRANS_SERVER_KEY: alchemy.secret.env.MIDTRANS_SERVER_KEY,
			MIDTRANS_CLIENT_KEY: alchemy.secret.env.MIDTRANS_CLIENT_KEY,
			ORDER_ROOM,
			WALLET_ROOM,
			LISTING_ROOM,
			MAIN_DB: mainDB,
			MAIN_KV: mainKV,
		},
		dev: {
			port: 3000,
		},
		domains: [{ domainName: `${APP_NAME}-server.zenta.dev`, zoneId }],
	}),
	TanStackStart(`${APP_NAME}-web`, {
		name: `${APP_NAME}-web`,
		cwd: "apps/web",
		bundle: { minify: !isDev, sourcemap: isDev },
		bindings: {
			NODE_ENV: alchemy.env.NODE_ENV,
			VITE_WEB_URL: alchemy.env.WEB_URL,
			VITE_SERVER_URL: alchemy.env.SERVER_URL,
			VITE_GOOGLE_MAPS_API_KEY: alchemy.env.GOOGLE_MAPS_API_KEY,
			LOG_SOURCE_TOKEN: alchemy.secret.env.LOG_SOURCE_TOKEN,
			LOG_ENDPOINT: alchemy.secret.env.LOG_ENDPOINT,
		},
		dev: {
			command: "bun run dev",
		},
		domains: [{ domainName: `${APP_NAME}.zenta.dev`, zoneId }],
	}),
]);

export type ServerEnv = typeof server.Env;

console.log(`Server -> ${server.url}`);
console.log(`Web    -> ${web.url}`);

await app.finalize();
