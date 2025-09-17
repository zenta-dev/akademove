import type { StandardSchemaV1 } from "better-auth";
import { type Env, Hono, type ValidationTargets } from "hono";
import type { DriverRepository } from "@/features/driver/repository";
import type { MerchantRepository } from "@/features/merchant/repository";
import type { OrderRepository } from "@/features/order/repository";
import type { PromoRepository } from "@/features/promo/repository";
import type { ReportRepository } from "@/features/report/repository";
import type { ReviewRepository } from "@/features/review/repository";
import type { ScheduleRepository } from "@/features/schedule/repository";
import type { UserRepository } from "@/features/user/repository";
import type { AuthInstance } from "./services/auth";
import type { HasPermissionRole } from "./services/auth.permission";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";

export type HonoContext = {
	Variables: {
		// db: DatabaseInstance;
		auth: AuthInstance;
		kv: KeyValueService;
		mail: MailService;
		user: {
			id: string;
			role: HasPermissionRole;
			banned: boolean;
		};
		repo: {
			driver: DriverRepository;
			merchant: MerchantRepository;
			order: OrderRepository;
			schedule: ScheduleRepository;
			promo: PromoRepository;
			report: ReportRepository;
			review: ReviewRepository;
			user: UserRepository;
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
