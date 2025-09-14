import { env } from "cloudflare:workers";
import { FailedResponseSchema } from "@repo/schema/common";
import { resolver } from "hono-openapi";

export const FEATURE_TAGS = Object.freeze({
	DRIVER: "Driver",
	MERCHANT: "Merchant",
} as const);

export const CACHE_TTLS = Object.freeze({
	"1h": 1 * 3600,
	"24h": 24 * 3600,
} as const);

export const CACHE_PREFIXES = Object.freeze({
	DRIVER: `${FEATURE_TAGS.DRIVER.toLowerCase()}:`,
	MERCHANT: `${FEATURE_TAGS.MERCHANT.toLowerCase()}:`,
} as const);
export const TRUSTED_ORIGINS = [env.AUTH_URL, env.CORS_ORIGIN];

type ResponseContent = {
	content: {
		"application/json": {
			schema: ReturnType<typeof resolver>;
		};
	};
};

type FailedResponse = ResponseContent & {
	description: string;
};

type FailedResponseFunction = (resource: string) => FailedResponse;

const failContent: ResponseContent = {
	content: {
		"application/json": {
			schema: resolver(FailedResponseSchema),
		},
	},
};

export const FAILED_RESPONSES: {
	readonly 404: FailedResponseFunction;
	readonly 500: FailedResponse;
} = Object.freeze({
	404: (resource: string): FailedResponse => ({
		...failContent,
		description: `${resource} not found`,
	}),
	500: {
		...failContent,
		description: "Internal server error",
	},
} as const);
