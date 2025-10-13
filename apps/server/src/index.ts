import "./polyfill";

import { env } from "cloudflare:workers";
import { OpenAPIHandler } from "@orpc/openapi/fetch";
import { OpenAPIReferencePlugin } from "@orpc/openapi/plugins";
import { ORPCError, ValidationError } from "@orpc/server";
import { RPCHandler } from "@orpc/server/fetch";
import {
	CORSPlugin,
	ResponseHeadersPlugin,
	StrictGetMethodPlugin,
} from "@orpc/server/plugins";
import { ZodToJsonSchemaConverter } from "@orpc/zod/zod4";
import { LocationSchema, TimeSchema } from "@repo/schema/common";
import { ConfigurationSchema } from "@repo/schema/configuration";
import { CouponSchema } from "@repo/schema/coupon";
import { DriverSchema } from "@repo/schema/driver";
import { MerchantMenuSchema, MerchantSchema } from "@repo/schema/merchant";
import { OrderSchema } from "@repo/schema/order";
import { ReportSchema } from "@repo/schema/report";
import { ReviewSchema } from "@repo/schema/review";
import { ScheduleSchema } from "@repo/schema/schedule";
import { UserSchema } from "@repo/schema/user";
import { cors } from "hono/cors";
import { logger } from "hono/logger";
import { TRUSTED_ORIGINS } from "@/core/constants";
import { BaseError, UnknownError } from "@/core/error";
import { createHono } from "@/core/hono";
import type { ORPCContext } from "@/core/interface";
import { getDatabase } from "@/core/services/db";
import { CloudflareKVService } from "@/core/services/kv";
import { ResendMailService } from "@/core/services/mail";
import { RBACService } from "@/core/services/rbac";
import { S3StorageService } from "@/core/services/storage";
import { ServerRouter } from "@/features";
import { AuthRepository } from "@/features/auth/repository";
import { createConfigurationRepository } from "@/features/configuration/repository";
import { createCouponRepository } from "@/features/coupon/repository";
import { DriverRepository } from "@/features/driver/repository";
import { MerchantMainRepository } from "@/features/merchant/main/repository";
import { MerchantMenuRepository } from "@/features/merchant/menu/repository";
import { createOrderRepository } from "@/features/order/repository";
import { createReportRepository } from "@/features/report/repository";
import { createReviewRepository } from "@/features/review/repository";
import { createScheduleRepository } from "@/features/schedule/repository";
import { createUserRepository } from "@/features/user/repository";
import { isCloudflare } from "@/utils";

const app = createHono();

app.use(logger());
app.use("*", async (c, next) => {
	const db = getDatabase();

	c.set("svc", {
		db,
		mail: new ResendMailService(env.RESEND_API_KEY),
		kv: new CloudflareKVService(env.MAIN_KV),
		storage: new S3StorageService({
			endpoint: env.S3_ENDPOINT,
			region: env.S3_REGION,
			accessKeyId: env.S3_ACCESS_KEY_ID,
			secretAccessKey: env.S3_SECRET_ACCESS_KEY,
			publicUrl: env.S3_PUBLIC_URL,
		}),
		rbac: new RBACService(),
	});
	try {
		await next();
	} finally {
		if (isCloudflare) await db.$client.end();
	}
});

app.use(
	"/*",
	cors({
		origin: TRUSTED_ORIGINS,
		allowMethods: ["GET", "POST", "PUT", "OPTIONS"],
		allowHeaders: ["Content-Type", "Authorization", "X-Client-Agent"],
		credentials: true,
	}),
);

const converter = new ZodToJsonSchemaConverter();
const sharedPlugins = [
	new CORSPlugin({
		origin: TRUSTED_ORIGINS,
		allowHeaders: ["Content-Type", "Authorization", "X-Client-Agent"],
		allowMethods: ["POST", "GET", "PUT", "OPTIONS"],
		exposeHeaders: ["Content-Length"],
		maxAge: 600,
		credentials: true,
	}),
	new ResponseHeadersPlugin(),
];

const apiHandler = new OpenAPIHandler(ServerRouter, {
	plugins: [
		...sharedPlugins,
		new StrictGetMethodPlugin(),
		new OpenAPIReferencePlugin({
			schemaConverters: [converter],
			specGenerateOptions: {
				commonSchemas: {
					// bussiness entities
					Configuration: { schema: ConfigurationSchema, strategy: "output" },
					Driver: { schema: DriverSchema, strategy: "output" },
					Merchant: { schema: MerchantSchema, strategy: "output" },
					MerchantMenu: { schema: MerchantMenuSchema, strategy: "output" },
					Order: { schema: OrderSchema, strategy: "output" },
					Report: { schema: ReportSchema, strategy: "output" },
					Coupon: { schema: CouponSchema, strategy: "output" },
					Review: { schema: ReviewSchema, strategy: "output" },
					Schedule: { schema: ScheduleSchema, strategy: "output" },
					User: { schema: UserSchema, strategy: "output" },
					// additional
					Location: { schema: LocationSchema, strategy: "output" },
					Time: { schema: TimeSchema, strategy: "output" },
					Statements: { schema: RBACService.schema, strategy: "input" },
				},
				info: {
					title: "AkadeMove API",
					version: "1.0.0",
					description: "API for the AkadeMove application",
				},
				components: {
					securitySchemes: {
						bearer_auth: {
							type: "http",
							scheme: "bearer",
							bearerFormat: "JWT",
						},
					},
				},
				security: [{ bearer_auth: [] }],
				servers: [{ url: `${env.AUTH_URL}/api` }],
			},
		}),
	],
	interceptors: [
		async (opts) => {
			try {
				return await opts.next();
			} catch (error) {
				console.error("ORPC Error Interceptor:", error);
				if (error instanceof ORPCError) {
					const { cause } = error;
					if (cause instanceof ValidationError) {
						for (const iss of cause.issues) {
							console.error(iss);
						}
					}
				}
				if (error instanceof BaseError) {
					throw error.toORPCError();
				}

				throw new UnknownError("An error occured", {
					code: "INTERNAL_SERVER_ERROR",
				}).toORPCError();
			}
		},
	],
});

export const rpcHandler = new RPCHandler(ServerRouter, {
	plugins: [...sharedPlugins],
	interceptors: [
		async (opts) => {
			try {
				return await opts.next();
			} catch (error) {
				console.error("ORPC Error Interceptor:", error);
				if (error instanceof ORPCError) {
					const { cause } = error;
					if (cause instanceof ValidationError) {
						for (const iss of cause.issues) {
							console.error(iss);
						}
					}
				}
				if (error instanceof BaseError) {
					throw error.toORPCError();
				}

				throw new UnknownError("An error occured", {
					code: "INTERNAL_SERVER_ERROR",
				}).toORPCError();
			}
		},
	],
});

app.use("/*", async (c, next) => {
	const { svc, user } = c.var;
	const context: ORPCContext = {
		req: c.req.raw,
		svc,
		repo: {
			auth: new AuthRepository(svc.db, svc.kv, svc.storage),
			configuration: createConfigurationRepository(svc.db, svc.kv),
			driver: new DriverRepository(svc.db, svc.kv, svc.storage),
			merchant: {
				main: new MerchantMainRepository(svc.db, svc.kv, svc.storage),
				menu: new MerchantMenuRepository(svc.db, svc.kv, svc.storage),
			},
			order: createOrderRepository(svc.db, svc.kv),
			coupon: createCouponRepository(svc.db, svc.kv),
			report: createReportRepository(svc.db, svc.kv),
			review: createReviewRepository(svc.db, svc.kv),
			schedule: createScheduleRepository(svc.db, svc.kv),
			user: createUserRepository(svc.db),
		},
		user,
		clientAgent: "unknown",
	};

	const rpcResult = await rpcHandler.handle(c.req.raw, {
		prefix: "/rpc",
		context: context,
	});

	if (rpcResult.matched) {
		return c.newResponse(rpcResult.response.body, rpcResult.response);
	}

	const apiResult = await apiHandler.handle(c.req.raw, {
		prefix: "/api",
		context: context,
	});

	if (apiResult.matched) {
		return c.newResponse(apiResult.response.body, apiResult.response);
	}

	await next();
});

app.onError((err, c) => {
	console.error("Error:", err);
	if ("getResponse" in err) {
		return err.getResponse();
	}
	if (err instanceof BaseError) {
		return err.toResponse();
	}
	if (err instanceof Error) {
		return c.json(
			{
				success: false,
				message: err.message,
			},
			500,
		);
	}
	return c.json(
		{
			success: false,
			message: "Internal Server Error",
		},
		500,
	);
});

export default app;
