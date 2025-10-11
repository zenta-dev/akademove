import type { ResponseHeadersPluginContext } from "@orpc/server/plugins";
import type { ClientAgent } from "@repo/schema/common";
import type { UserRole } from "@repo/schema/user";
import type { AuthRepository } from "@/features/auth/repository";
import type { ConfigurationRepository } from "@/features/configuration/repository";
import type { DriverRepository } from "@/features/driver/repository";
import type { MerchantMainRepository } from "@/features/merchant/main/repository";
import type { OrderRepository } from "@/features/order/repository";
import type { ReportRepository } from "@/features/report/repository";
import type { ReviewRepository } from "@/features/review/repository";
import type { ScheduleRepository } from "@/features/schedule/repository";
import type { UserRepository } from "@/features/user/repository";
import type { CouponRepository } from "../features/coupon/repository";
import type { MerchantMenuRepository } from "../features/merchant/menu/repository";
import type { DatabaseService } from "./services/db";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";
import type { RBACService } from "./services/rbac";
import type { StorageService } from "./services/storage";

export interface ORPCContext extends ResponseHeadersPluginContext {
	req: Request;
	svc: {
		db: DatabaseService;
		kv: KeyValueService;
		mail: MailService;
		storage: StorageService;
		rbac: RBACService;
	};
	repo: {
		auth: AuthRepository;
		configuration: ConfigurationRepository;
		driver: DriverRepository;
		merchant: {
			main: MerchantMainRepository;
			menu: MerchantMenuRepository;
		};
		order: OrderRepository;
		coupon: CouponRepository;
		report: ReportRepository;
		review: ReviewRepository;
		schedule: ScheduleRepository;
		user: UserRepository;
	};
	user: {
		id: string;
		role: UserRole;
		banned: boolean;
	};
	clientAgent: ClientAgent;
	token?: string;
}
