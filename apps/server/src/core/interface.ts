import type { ResponseHeadersPluginContext } from "@orpc/server/plugins";
import type { ClientAgent } from "@repo/schema/common";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { UserRole } from "@repo/schema/user";
import type { AuthRepository } from "@/features/auth/auth-repository";
import type { ConfigurationRepository } from "@/features/configuration/configuration-repository";
import type { CouponRepository } from "@/features/coupon/coupon-repository";
import type { DriverRepository } from "@/features/driver/driver-repository";
import type { MerchantMainRepository } from "@/features/merchant/main/merchant-main-repository";
import type { MerchantMenuRepository } from "@/features/merchant/menu/merchant-menu-repository";
import type { OrderRepository } from "@/features/order/order-repository";
import type { ReportRepository } from "@/features/report/report-repository";
import type { ReviewRepository } from "@/features/review/review-repository";
import type { DriverScheduleRepository } from "@/features/schedule/schedule-repository";
import type { UserRepository } from "@/features/user/user-repository";
import type { WalletRepository } from "@/features/wallet/wallet-repository";
import type { JwtManager } from "@/utils/jwt";
import type { DatabaseService, DatabaseTransaction } from "./services/db";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";
import type { MapService } from "./services/map";
import type { PaymentService } from "./services/payment";
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
	map: MapService;
	payment: PaymentService;
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
	schedule: DriverScheduleRepository;
	user: UserRepository;
	wallet: WalletRepository;
}

export interface UserInContext {
	id: string;
	role: UserRole;
	banned: boolean;
}

export interface ManagerContext {
	jwt: JwtManager;
}

export interface HonoContext {
	Variables: {
		svc: ServiceContext;
		repo: RepositoryContext;
		manager: ManagerContext;
		session?: {
			user: UserInContext;
			token: string;
		};
		clientAgent: ClientAgent;
	};
	Bindings: Env;
}

export interface ORPCContext extends ResponseHeadersPluginContext {
	req: Request;
	svc: ServiceContext;
	repo: RepositoryContext;
	manager: ManagerContext;
	user?: UserInContext;
	clientAgent: ClientAgent;
	token?: string;
}

export type WithTx = { tx: DatabaseTransaction };
export type WithUserId = { userId: string };
export type WebsocketAttachment = {
	id: string;
	[key: string]: string;
};
