import alchemy from "alchemy";
import {
	DurableObjectNamespace,
	Hyperdrive,
	KVNamespace,
	Queue,
	TanStackStart,
	Tunnel,
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
const zoneId = isDev ? undefined : alchemy.env.ZONE_ID;

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

const PAYMENT_ROOM = DurableObjectNamespace("payment-rooms", {
	className: "PaymentRoom",
	environment: alchemy.env.NODE_ENV,
	sqlite: true,
});

const ORDER_DLQ = await Queue("order-dlq", {
	name: `${APP_NAME}-order-dlq`,
	settings: {
		messageRetentionPeriod: 604800, // 7 days retention for debugging
	},
});

const ORDER_QUEUE = await Queue("order-queue", {
	name: `${APP_NAME}-order-queue`,
	dlq: ORDER_DLQ,
	settings: {
		messageRetentionPeriod: 86400, // 1 day retention
	},
});

const NOTIFICATION_QUEUE = await Queue("notification-queue", {
	name: `${APP_NAME}-notification-queue`,
	dlq: ORDER_DLQ, // Share DLQ for all failed notifications
	settings: {
		messageRetentionPeriod: 3600, // 1 hour retention (notifications are time-sensitive)
	},
});

const PROCESSING_QUEUE = await Queue("processing-queue", {
	name: `${APP_NAME}-processing-queue`,
	dlq: ORDER_DLQ,
	settings: {
		messageRetentionPeriod: 86400, // 1 day retention
	},
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
			GOOGLE_MAPS_API_KEY: alchemy.secret.env.GOOGLE_MAPS_API_KEY,
			RESEND_API_KEY: alchemy.secret.env.RESEND_API_KEY,
			MIDTRANS_IS_PRODUCTION: alchemy.secret.env.MIDTRANS_IS_PRODUCTION,
			MIDTRANS_SERVER_KEY: alchemy.secret.env.MIDTRANS_SERVER_KEY,
			MIDTRANS_CLIENT_KEY: alchemy.secret.env.MIDTRANS_CLIENT_KEY,
			FIREBASE_SERVICE_ACCOUNT: alchemy.secret.env.FIREBASE_SERVICE_ACCOUNT,
			ORDER_ROOM,
			PAYMENT_ROOM,
			DB_URL: alchemy.secret.env.DATABASE_URL,
			MAIN_DB: mainDB,
			MAIN_KV: mainKV,
			ORDER_QUEUE,
			NOTIFICATION_QUEUE,
			PROCESSING_QUEUE,
			ORDER_DLQ,
		},
		// Queue consumers with retry configuration
		eventSources: [
			{
				// Order queue - critical operations, aggressive retries
				queue: ORDER_QUEUE,
				settings: {
					batchSize: 5, // Process 5 messages at a time
					maxConcurrency: 3, // Allow 3 concurrent invocations
					maxRetries: 10, // Retry up to 10 times (resilient)
					maxWaitTimeMs: 1000, // Wait up to 1s to fill batch
					retryDelay: 10, // Wait 10s between retries
					deadLetterQueue: ORDER_DLQ,
				},
			},
			{
				// Notification queue - high throughput, quick processing
				queue: NOTIFICATION_QUEUE,
				settings: {
					batchSize: 50, // Process many notifications at once
					maxConcurrency: 10, // High parallelism for notifications
					maxRetries: 3, // Notifications can fail after 3 attempts
					maxWaitTimeMs: 500, // Quick batching
					retryDelay: 5, // Short retry delay
					deadLetterQueue: ORDER_DLQ,
				},
			},
			{
				// Processing queue - background tasks, eventual consistency
				queue: PROCESSING_QUEUE,
				settings: {
					batchSize: 20, // Moderate batch size
					maxConcurrency: 5, // Moderate parallelism
					maxRetries: 5, // Standard retry count
					maxWaitTimeMs: 2000, // Allow more time to batch
					retryDelay: 30, // Longer retry delay (less urgent)
					deadLetterQueue: ORDER_DLQ,
				},
			},
		],
		crons: ["* * * * *"], // Run every 1 minute for auto-offline checks
		dev: {
			port: 3000,
		},
		domains: isDev
			? []
			: [{ domainName: "server.akademove.com", zoneId, adopt: true }],
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
			VITE_FIREBASE_API_KEY: alchemy.env.FIREBASE_API_KEY,
			VITE_FIREBASE_AUTH_DOMAIN: alchemy.env.FIREBASE_AUTH_DOMAIN,
			VITE_FIREBASE_PROJECT_ID: alchemy.env.FIREBASE_PROJECT_ID,
			VITE_FIREBASE_STORAGE_BUCKET: alchemy.env.FIREBASE_STORAGE_BUCKET,
			VITE_FIREBASE_MESSAGING_SENDER_ID:
				alchemy.env.FIREBASE_MESSAGING_SENDER_ID,
			VITE_FIREBASE_APP_ID: alchemy.env.FIREBASE_APP_ID,
			VITE_FIREBASE_MEASUREMENT_ID: alchemy.env.FIREBASE_MEASUREMENT_ID,
			VITE_FIREBASE_VAPID_KEY: alchemy.env.FIREBASE_VAPID_KEY,
		},
		dev: {
			command: "bun run dev",
		},
		domains: isDev
			? []
			: [{ domainName: "akademove.com", zoneId, adopt: true }],
	}),
]);

if (isDev) {
	await Tunnel("server-app", {
		name: "server-app-tunnel",
		configSrc: "cloudflare",
		ingress: [
			{
				hostname: "dev-server.akademove.com",
				service: "http://localhost:3000",
			},
			{ service: "http_status:404" },
		],
	});
}

export type ServerEnv = typeof server.Env;

console.log(`Server -> ${server.url}`);
console.log(`Web    -> ${web.url}`);

await app.finalize();
