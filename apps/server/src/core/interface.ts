import type { ResponseHeadersPluginContext } from "@orpc/server/plugins";
import type { ClientAgent } from "@repo/schema/common";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { UserRole } from "@repo/schema/user";
import type { Env } from "hono";
import type { AuthRepository } from "@/features/auth/repository";
import type { ConfigurationRepository } from "@/features/configuration/repository";
import type { CouponRepository } from "@/features/coupon/repository";
import type { DriverRepository } from "@/features/driver/repository";
import type { MerchantMainRepository } from "@/features/merchant/main/repository";
import type { MerchantMenuRepository } from "@/features/merchant/menu/repository";
import type { OrderRepository } from "@/features/order/repository";
import type { ReportRepository } from "@/features/report/repository";
import type { ReviewRepository } from "@/features/review/repository";
import type { ScheduleRepository } from "@/features/schedule/repository";
import type { UserRepository } from "@/features/user/repository";
import type { DatabaseService } from "./services/db";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";
import type { RBACService } from "./services/rbac";
import type { StorageService } from "./services/storage";

export interface GetOptions {
	fromCache?: boolean;
}
export interface GetAllOptions extends GetOptions, UnifiedPaginationQuery {}

export abstract class BaseRepository<T> {
	// Database specifix
	abstract getAll(opts?: GetAllOptions, ...args: unknown[]): Promise<T[]>;
	abstract getById(id: string, opts?: GetOptions): Promise<T | undefined>;
	abstract create(item: unknown): Promise<T>;
	abstract update(id: string, item: unknown, ...args: unknown[]): Promise<T>;
	abstract delete(id: string): Promise<void>;
}

export interface ServiceContext {
	db: DatabaseService;
	kv: KeyValueService;
	mail: MailService;
	storage: StorageService;
	rbac: RBACService;
}

export interface RepositoryContext {
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
}

export interface UserInContext {
	id: string;
	role: UserRole;
	banned: boolean;
}

export interface HonoContext {
	Variables: {
		svc: ServiceContext;
		user: UserInContext;
		repo: RepositoryContext;
	};
	Bindings: Env;
}

export interface ORPCContext extends ResponseHeadersPluginContext {
	req: Request;
	svc: ServiceContext;
	repo: RepositoryContext;
	user: UserInContext;
	clientAgent: ClientAgent;
	token?: string;
}
