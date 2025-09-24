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
import type { AuthService, PermissionRole } from "./services/auth";
import type { DatabaseService } from "./services/db";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";

export interface ORPCCOntext {
	req: Request;
	svc: {
		db: DatabaseService;
		auth: AuthService;
		kv: KeyValueService;
		mail: MailService;
	};
	repo: {
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
		role: PermissionRole;
		banned: boolean;
	};
}
