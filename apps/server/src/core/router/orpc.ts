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
import type { StandardHandleResult } from "@orpc/server/standard";
import type { Interceptor } from "@orpc/shared";
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
import type { Hono } from "hono";
import { TRUSTED_ORIGINS } from "@/core/constants";
import { BaseError, UnknownError } from "@/core/error";
import type { HonoContext, ORPCContext } from "@/core/interface";
import { RBACService } from "@/core/services/rbac";
import { ServerRouter } from "@/features";

const errorInterceptor: Interceptor<
	// biome-ignore lint/suspicious/noExplicitAny: i dunno how refer from orpc
	any,
	Promise<StandardHandleResult>
> = async (opts) => {
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
};

export const setupOrpcRouter = (app: Hono<HonoContext>) => {
	app.use("/*", async (c, next) => {
		const url = c.req.raw.url;

		const isRPC = url.includes("rpc");
		const isAPI = url.includes("api");

		if (!isRPC && !isAPI) {
			return await next();
		}

		const corsPlugin = new CORSPlugin({
			origin: TRUSTED_ORIGINS,
			allowHeaders: ["Content-Type", "Authorization", "X-Client-Agent"],
			allowMethods: ["POST", "GET", "PUT", "OPTIONS"],
			exposeHeaders: ["Content-Length"],
			maxAge: 600,
			credentials: true,
		});

		const responseHeadersPlugin = new ResponseHeadersPlugin();

		const { svc, repo, user } = c.var;
		const context: ORPCContext = {
			req: c.req.raw,
			svc,
			repo,
			user,
			clientAgent: "unknown",
		};

		if (isRPC) {
			const handler = new RPCHandler(ServerRouter, {
				plugins: [corsPlugin, responseHeadersPlugin],
				interceptors: [errorInterceptor],
			});
			const result = await handler.handle(c.req.raw, {
				prefix: "/rpc",
				context,
			});

			if (result.matched) {
				return c.newResponse(result.response.body, result.response);
			}
		}

		if (isAPI) {
			const converter = new ZodToJsonSchemaConverter();

			const handler = new OpenAPIHandler(ServerRouter, {
				plugins: [
					corsPlugin,
					responseHeadersPlugin,
					new StrictGetMethodPlugin(),
					new OpenAPIReferencePlugin({
						schemaConverters: [converter],
						specGenerateOptions: {
							commonSchemas: {
								Configuration: {
									schema: ConfigurationSchema,
									strategy: "output",
								},
								Driver: { schema: DriverSchema, strategy: "output" },
								Merchant: { schema: MerchantSchema, strategy: "output" },
								MerchantMenu: {
									schema: MerchantMenuSchema,
									strategy: "output",
								},
								Order: { schema: OrderSchema, strategy: "output" },
								Report: { schema: ReportSchema, strategy: "output" },
								Coupon: { schema: CouponSchema, strategy: "output" },
								Review: { schema: ReviewSchema, strategy: "output" },
								Schedule: { schema: ScheduleSchema, strategy: "output" },
								User: { schema: UserSchema, strategy: "output" },
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
				interceptors: [errorInterceptor],
			});
			const result = await handler.handle(c.req.raw, {
				prefix: "/api",
				context,
			});

			if (result.matched) {
				return c.newResponse(result.response.body, result.response);
			}
		}

		return await next();
	});

	return app;
};
