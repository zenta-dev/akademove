import { env } from "cloudflare:workers";
import type { AnyContractRouter } from "@orpc/contract";
import { OpenAPIHandler } from "@orpc/openapi/fetch";
import { OpenAPIReferencePlugin } from "@orpc/openapi/plugins";
import {
	type Context,
	type Implementer,
	implement,
	ORPCError,
	ValidationError,
} from "@orpc/server";
import { RPCHandler as FetchRPCHandler } from "@orpc/server/fetch";
import {
	BatchHandlerPlugin,
	CORSPlugin,
	ResponseHeadersPlugin,
	StrictGetMethodPlugin,
} from "@orpc/server/plugins";
import type { StandardHandleResult } from "@orpc/server/standard";
import type { Interceptor } from "@orpc/shared";
import { ZodToJsonSchemaConverter } from "@orpc/zod/zod4";
import { AllSchemaRegistries } from "@repo/schema";
import type { Hono } from "hono";
import { TRUSTED_ORIGINS } from "@/core/constants";
import { BaseError, UnknownError } from "@/core/error";
import type { HonoContext, ORPCContext, UserInContext } from "@/core/interface";
import { RBACService } from "@/core/services/rbac";
import { FetchServerRouter } from "@/features";
import { log } from "@/utils";
import {
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "../middlewares/auth";

const _sharedInterceptor: Interceptor<
	// biome-ignore lint/suspicious/noExplicitAny: i dunno how refer from orpc
	any,
	Promise<StandardHandleResult>
> = async (opts) => {
	const path = opts.request.url.pathname;
	log.debug({ path }, "Incoming Request");
	try {
		const res = await opts.next();
		const { response } = res;
		log.debug(response, "Outcoming response");
		return res;
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
			allowHeaders: [
				"Content-Type",
				"Authorization",
				"Accept-Language",
				"X-Client-Agent",
				"X-Orpc-Batch",
			],
			allowMethods: ["POST", "GET", "PUT", "OPTIONS"],
			exposeHeaders: ["Content-Length"],
			maxAge: 600,
			credentials: true,
		});

		const responseHeadersPlugin = new ResponseHeadersPlugin();

		const { svc, repo, manager, clientAgent } = c.var;
		const context: ORPCContext = {
			req: c.req.raw,
			svc,
			repo,
			manager,
			clientAgent,
			user: c.var.session?.user,
			locale: c.var.locale,
		};

		if (isRPC) {
			const handler = new FetchRPCHandler(FetchServerRouter, {
				plugins: [
					corsPlugin,
					responseHeadersPlugin,
					new BatchHandlerPlugin(),
					// new DurableIteratorHandlerPlugin(),
				],
				interceptors: [_sharedInterceptor],
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

			const handler = new OpenAPIHandler(FetchServerRouter, {
				plugins: [
					corsPlugin,
					responseHeadersPlugin,
					new StrictGetMethodPlugin(),
					new OpenAPIReferencePlugin({
						schemaConverters: [converter],
						specGenerateOptions: {
							commonSchemas: {
								...AllSchemaRegistries,
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
				interceptors: [_sharedInterceptor],
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

	return { app };
};

export function createORPCRouter<
	TRouter extends AnyContractRouter,
	TContext extends Context = Record<never, never>,
>(spec: TRouter) {
	const pub = implement<TRouter, TContext>(spec).$context<ORPCContext>();

	type AuthedContext = Omit<ORPCContext, "user" | "token"> & {
		user: UserInContext;
		token: string;
	};

	const priv = pub
		// @ts-expect-error it should fine as long as spec is supplied
		.use(orpcAuthMiddleware)
		.use(orpcRequireAuthMiddleware) as unknown as Implementer<
		TRouter,
		ORPCContext,
		AuthedContext
	>;

	return { pub, priv };
}
