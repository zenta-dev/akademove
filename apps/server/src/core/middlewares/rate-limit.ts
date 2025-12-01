import { os } from "@orpc/server";
import { createMiddleware } from "hono/factory";
import { log } from "@/utils";
import { MiddlewareError } from "../error";
import type { HonoContext, ORPCContext } from "../interface";

const base = os.$context<ORPCContext>();

interface RateLimitConfig {
	/**
	 * Maximum number of requests allowed within the window
	 */
	limit: number;
	/**
	 * Time window in seconds
	 */
	window: number;
	/**
	 * Unique key prefix for this rate limiter
	 */
	keyPrefix?: string;
	/**
	 * Whether to use IP-based rate limiting (default: true)
	 */
	useIp?: boolean;
	/**
	 * Whether to use user-based rate limiting (default: false)
	 */
	useUser?: boolean;
}

interface RateLimitState {
	count: number;
	resetAt: number;
}

/**
 * Rate limiting middleware for Hono routes
 * Uses Cloudflare KV for distributed rate limiting
 */
export const honoRateLimit = (config: RateLimitConfig) =>
	createMiddleware<HonoContext>(async (c, next) => {
		const {
			limit,
			window,
			keyPrefix = "rate",
			useIp = true,
			useUser = false,
		} = config;
		const { svc } = c.var;

		// Build rate limit key
		const keyParts: string[] = [keyPrefix];

		if (useIp) {
			const ip =
				c.req.header("cf-connecting-ip") ||
				c.req.header("x-forwarded-for") ||
				"unknown";
			keyParts.push(`ip:${ip}`);
		}

		if (useUser && c.var.session) {
			keyParts.push(`user:${c.var.session.user.id}`);
		}

		const key = keyParts.join(":");

		try {
			// Get current state from KV
			const stateStr = await svc.kv.get<string>(key);
			const now = Date.now();
			let state: RateLimitState;

			if (stateStr) {
				state = JSON.parse(stateStr);

				// Check if window has expired
				if (now >= state.resetAt) {
					// Reset counter
					state = { count: 1, resetAt: now + window * 1000 };
				} else {
					// Increment counter
					state.count += 1;
				}
			} else {
				// Initialize new state
				state = { count: 1, resetAt: now + window * 1000 };
			}

			// Check if limit exceeded
			if (state.count > limit) {
				const retryAfter = Math.ceil((state.resetAt - now) / 1000);

				log.warn(
					{ key, count: state.count, limit, retryAfter },
					"Rate limit exceeded",
				);

				// Set rate limit headers
				c.header("X-RateLimit-Limit", limit.toString());
				c.header("X-RateLimit-Remaining", "0");
				c.header("X-RateLimit-Reset", state.resetAt.toString());
				c.header("Retry-After", retryAfter.toString());

				throw new MiddlewareError(
					`Rate limit exceeded. Try again in ${retryAfter} seconds.`,
					{ code: "FORBIDDEN" },
				);
			}

			// Update state in KV with TTL
			const ttl = Math.ceil((state.resetAt - now) / 1000);
			await svc.kv.put(key, JSON.stringify(state), { expirationTtl: ttl });

			// Set rate limit headers
			const remaining = Math.max(0, limit - state.count);
			c.header("X-RateLimit-Limit", limit.toString());
			c.header("X-RateLimit-Remaining", remaining.toString());
			c.header("X-RateLimit-Reset", state.resetAt.toString());

			return next();
		} catch (error) {
			if (error instanceof MiddlewareError) {
				throw error;
			}

			// Log error but don't block request if rate limiting fails
			log.error({ error, key }, "Rate limiting error - allowing request");
			return next();
		}
	});

/**
 * Rate limiting middleware for oRPC routes
 * Uses Cloudflare KV for distributed rate limiting
 */
export const orpcRateLimit = (config: RateLimitConfig) =>
	base.middleware(async ({ context, next }) => {
		const {
			limit,
			window,
			keyPrefix = "rate",
			useIp = true,
			useUser = false,
		} = config;
		const { svc, req } = context;

		// Build rate limit key
		const keyParts: string[] = [keyPrefix];

		if (useIp) {
			const ip =
				req.headers.get("cf-connecting-ip") ||
				req.headers.get("x-forwarded-for") ||
				"unknown";
			keyParts.push(`ip:${ip}`);
		}

		if (useUser && context.user) {
			keyParts.push(`user:${context.user.id}`);
		}

		const key = keyParts.join(":");

		try {
			// Get current state from KV
			const stateStr = await svc.kv.get<string>(key);
			const now = Date.now();
			let state: RateLimitState;

			if (stateStr) {
				state = JSON.parse(stateStr);

				// Check if window has expired
				if (now >= state.resetAt) {
					// Reset counter
					state = { count: 1, resetAt: now + window * 1000 };
				} else {
					// Increment counter
					state.count += 1;
				}
			} else {
				// Initialize new state
				state = { count: 1, resetAt: now + window * 1000 };
			}

			// Check if limit exceeded
			if (state.count > limit) {
				const retryAfter = Math.ceil((state.resetAt - now) / 1000);

				log.warn(
					{ key, count: state.count, limit, retryAfter },
					"Rate limit exceeded",
				);

				throw new MiddlewareError(
					`Rate limit exceeded. Try again in ${retryAfter} seconds.`,
					{ code: "FORBIDDEN" },
				);
			}

			// Update state in KV with TTL
			const ttl = Math.ceil((state.resetAt - now) / 1000);
			await svc.kv.put(key, JSON.stringify(state), { expirationTtl: ttl });

			// Note: oRPC doesn't support setting response headers in middleware
			// Headers are set in Hono middleware version only

			return next();
		} catch (error) {
			if (error instanceof MiddlewareError) {
				throw error;
			}

			// Log error but don't block request if rate limiting fails
			log.error({ error, key }, "Rate limiting error - allowing request");
			return next();
		}
	});

/**
 * Predefined rate limit configurations for common use cases
 */
export const RATE_LIMITS = {
	/**
	 * Strict limit for authentication endpoints (login, register)
	 * 5 requests per 15 minutes per IP
	 */
	AUTH: { limit: 5, window: 900, keyPrefix: "auth" },

	/**
	 * Moderate limit for write operations (create, update, delete)
	 * 30 requests per minute per user
	 */
	WRITE: { limit: 30, window: 60, keyPrefix: "write", useUser: true },

	/**
	 * Generous limit for read operations (list, get)
	 * 100 requests per minute per user
	 */
	READ: { limit: 100, window: 60, keyPrefix: "read", useUser: true },

	/**
	 * Very strict limit for expensive operations (reports, exports)
	 * 10 requests per hour per user
	 */
	EXPENSIVE: { limit: 10, window: 3600, keyPrefix: "expensive", useUser: true },

	/**
	 * Medium limit for order placement
	 * 20 orders per hour per user
	 */
	ORDER: { limit: 20, window: 3600, keyPrefix: "order", useUser: true },

	/**
	 * Strict limit for OTP/SMS endpoints
	 * 3 requests per 5 minutes per IP
	 */
	OTP: { limit: 3, window: 300, keyPrefix: "otp" },

	/**
	 * Global API limit per IP
	 * 1000 requests per hour per IP
	 */
	GLOBAL: { limit: 1000, window: 3600, keyPrefix: "global" },
} as const;
