import { type Env, Hono, type ValidationTargets } from "hono";
import type { StandardSchemaV1 } from "node_modules/zod/v4/core/standard-schema";
import type { DriverRepository } from "@/features/driver/repository";
import type { MerchantRepository } from "@/features/merchant/repository";
import type { AuthInstance } from "./services/auth";
import type { DatabaseInstance } from "./services/db";
import type { KeyValueService } from "./services/kv";

export type HonoContext = {
	Variables: {
		db: DatabaseInstance;
		auth: AuthInstance;
		kv: KeyValueService;
		userId: string;
		repo: {
			driver: DriverRepository;
			merchant: MerchantRepository;
		};
	};
	Bindings: Env;
};

export const createHono = () => new Hono<HonoContext>();

export const handleValidation = <
	Schema extends StandardSchemaV1,
	Target extends keyof ValidationTargets,
>(
	result: (
		| { success: true; data: StandardSchemaV1.InferOutput<Schema> }
		| {
				success: false;
				error: readonly StandardSchemaV1.Issue[];
				data: StandardSchemaV1.InferOutput<Schema>;
		  }
	) & { target: Target },
) => {
	if (!result.success) {
		return new Response(
			JSON.stringify({
				success: false,
				message: "Invalid request body",
				errors: result.error.map((v) => ({
					name: "ValidationError",
					path: v.path?.at(0) ?? v.path,
					cause: v.message,
				})),
			}),
			{
				status: 400,
				headers: {
					"Content-Type": "application/json",
				},
			},
		);
	}
};
