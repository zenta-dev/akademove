import { FailedResponseSchema } from "@repo/schema/common";
import { resolver } from "hono-openapi";

export const CACHE_TTLS = Object.freeze({
	"1h": 1 * 60 * 60,
	"24h": 24 * 60 * 60,
} as const);

export const CACHE_PREFIXES = Object.freeze({
	DRIVER: "driver:",
} as const);

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
	readonly 400: FailedResponseFunction;
	readonly 500: FailedResponse;
} = Object.freeze({
	400: (resource: string): FailedResponse => ({
		...failContent,
		description: `${resource} not found`,
	}),
	500: {
		...failContent,
		description: "Internal server error",
	},
} as const);
