import { env } from "cloudflare:workers";
import type { AnyContractRouter } from "@orpc/contract";
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
import type { Hono } from "hono";
import { BaseError, UnknownError } from "@/core/error";
import type { HonoContext, ORPCContext, UserInContext } from "@/core/interface";
import { logger } from "@/utils/logger";
import { TRUSTED_ORIGINS } from "../constants.env";
import {
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "../middlewares/auth";

// Lazy-load heavy dependencies to reduce cold start time
// These modules are loaded on first request instead of at script startup
// biome-ignore lint/suspicious/noExplicitAny: Dynamic import type inference is complex
let _fetchServerRouter: any = null;

async function getFetchServerRouter() {
	if (!_fetchServerRouter) {
		const { FetchServerRouter } = await import("@/features");
		_fetchServerRouter = FetchServerRouter;
	}
	return _fetchServerRouter;
}

const _sharedInterceptor: Interceptor<
	// biome-ignore lint/suspicious/noExplicitAny: i dunno how refer from orpc
	any,
	Promise<StandardHandleResult>
> = async (opts) => {
	const path = opts.request.url.pathname;
	logger.debug({ path }, "Incoming Request");
	try {
		const body = (await opts.request.body) ?? {};
		logger.debug({ body }, "Incoming request body");
		const res = await opts.next();
		const { response } = res;
		logger.debug(response, "Outcoming response");
		return res;
	} catch (error) {
		logger.error({ error }, "ORPC Error Interceptor");

		if (error instanceof ORPCError) {
			const { cause } = error;
			if (cause instanceof ValidationError) {
				for (const iss of cause.issues) {
					logger.error({ issue: iss }, "ORPC Validation Error");
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
			allowMethods: ["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"],
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
			const FetchServerRouter = await getFetchServerRouter();
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
			// Lazy load OpenAPI dependencies - these are only needed for /api routes
			const [
				{ OpenAPIHandler },
				{ OpenAPIReferencePlugin },
				{ ZodToJsonSchemaConverter },
				{ AllSchemaRegistries },
			] = await Promise.all([
				import("@orpc/openapi/fetch"),
				import("@orpc/openapi/plugins"),
				import("@orpc/zod/zod4"),
				import("@repo/schema"),
			]);

			const FetchServerRouter = await getFetchServerRouter();
			const converter = new ZodToJsonSchemaConverter();

			const handler = new OpenAPIHandler(FetchServerRouter, {
				plugins: [
					corsPlugin,
					responseHeadersPlugin,
					new StrictGetMethodPlugin(),
					new OpenAPIReferencePlugin({
						schemaConverters: [converter],
						specGenerateOptions: {
							commonSchemas: AllSchemaRegistries,
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
