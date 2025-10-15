import { env } from "cloudflare:workers";
import { Hono } from "hono";
import { cors } from "hono/cors";
import { logger } from "hono/logger";
import { TRUSTED_ORIGINS } from "@/core/constants";
import { BaseError } from "@/core/error";
import type { HonoContext } from "@/core/interface";
import { getDatabase } from "@/core/services/db";
import { CloudflareKVService } from "@/core/services/kv";
import { ResendMailService } from "@/core/services/mail";
import { RBACService } from "@/core/services/rbac";
import { S3StorageService } from "@/core/services/storage";
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

export const createHono = () => new Hono<HonoContext>();

export const setupHonoRouter = () => {
	const app = createHono();

	app.use(logger());
	app.use(
		"/*",
		cors({
			origin: TRUSTED_ORIGINS,
			allowMethods: ["GET", "POST", "PUT", "OPTIONS"],
			allowHeaders: ["Content-Type", "Authorization", "X-Client-Agent"],
			credentials: true,
		}),
	);

	app.use("*", async (c, next) => {
		const svc = {
			db: getDatabase(),
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
		};
		c.set("svc", svc);
		c.set("repo", {
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
		});
		try {
			return await next();
		} finally {
			if (isCloudflare) await svc.db.$client.end();
		}
	});

	app.onError((err, c) => {
		console.error("Error:", err);
		if ("getResponse" in err) {
			return err.getResponse();
		}
		if (err instanceof BaseError) {
			return err.toResponse();
		}
		const message =
			err instanceof Error ? err.message : "Internal Server Error";
		const response =
			err instanceof Error
				? { success: false, message }
				: {
						success: false,
						message: "Internal Server Error",
					};

		return c.json(response, 500);
	});

	return app;
};
