import type { StandardSchemaV1 } from "better-auth";
import { type Env, Hono, type ValidationTargets } from "hono";
import type { AuthService, PermissionRole } from "./services/auth";
import type { DatabaseService } from "./services/db";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";

export type HonoContext = {
	Variables: {
		db: DatabaseService;
		auth: AuthService;
		kv: KeyValueService;
		mail: MailService;
		user: {
			id: string;
			role: PermissionRole;
			banned: boolean;
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
