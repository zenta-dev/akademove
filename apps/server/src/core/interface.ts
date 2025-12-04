import type { ResponseHeadersPluginContext } from "@orpc/server/plugins";
import type { Locale } from "@repo/i18n";
import type { ClientAgent } from "@repo/schema/common";
import type { PaginationResult } from "@repo/schema/pagination";
import type { UserRole } from "@repo/schema/user";
import type { asc, desc, sql } from "drizzle-orm";
import type { AnalyticsRepository } from "@/features/analytics/analytics-repository";
import type { AuthRepository } from "@/features/auth/auth-repository";
import type { BadgeRepository } from "@/features/badge/main/badge-main-repository";
import type { UserBadgeRepository } from "@/features/badge/user/user-badge-repository";
import type { ChatRepository } from "@/features/chat/chat-repository";
import type { ConfigurationRepository } from "@/features/configuration/configuration-repository";
import type { ContactRepository } from "@/features/contact/contact-repository";
import type { CouponRepository } from "@/features/coupon/coupon-repository";
import type { DriverMainRepository } from "@/features/driver/main/driver-main-repository";
import type { DriverScheduleRepository } from "@/features/driver/schedule/driver-schedule-repository";
import type { EmergencyRepository } from "@/features/emergency/emergency-repository";
import type { LeaderboardRepository } from "@/features/leaderboard/leaderboard-repository";
import type { MerchantMainRepository } from "@/features/merchant/main/merchant-main-repository";
import type { MerchantMenuRepository } from "@/features/merchant/menu/merchant-menu-repository";
import type { MerchantOrderRepository } from "@/features/merchant/order/merchant-order-repository";
import type { NotificationRepository } from "@/features/notification/notification-repository";
import type { OrderRepository } from "@/features/order/order-repository";
import type { PaymentRepository } from "@/features/payment/payment-repository";
import type { QuickMessageRepository } from "@/features/quick-message/quick-message-repository";
import type { ReportRepository } from "@/features/report/report-repository";
import type { ReviewRepository } from "@/features/review/review-repository";
import type { TransactionRepository } from "@/features/transaction/transaction-repository";
import type { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import type { UserMeRepository } from "@/features/user/me/user-me-repository";
import type { WalletRepository } from "@/features/wallet/wallet-repository";
import type { JwtManager } from "@/utils/jwt";
import type { PasswordManager } from "@/utils/password";
import type { DatabaseService, DatabaseTransaction } from "./services/db";
import type { FirebaseAdminService } from "./services/firebase";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";
import type { MapService } from "./services/map";
import type { PaymentService } from "./services/payment";
import type { RBACService } from "./services/rbac";
import type { StorageService } from "./services/storage";

export interface ServiceContext {
	db: DatabaseService;
	kv: KeyValueService;
	mail: MailService;
	storage: StorageService;
	rbac: RBACService;
	map: MapService;
	payment: PaymentService;
	firebase: FirebaseAdminService;
}

export interface RepositoryContext {
	analytics: AnalyticsRepository;
	auth: AuthRepository;
	badge: {
		main: BadgeRepository;
		user: UserBadgeRepository;
	};
	chat: ChatRepository;
	configuration: ConfigurationRepository;
	contact: ContactRepository;
	quickMessage: QuickMessageRepository;
	driver: {
		main: DriverMainRepository;
		schedule: DriverScheduleRepository;
	};
	emergency: EmergencyRepository;
	leaderboard: LeaderboardRepository;
	merchant: {
		main: MerchantMainRepository;
		menu: MerchantMenuRepository;
		order: MerchantOrderRepository;
	};
	payment: PaymentRepository;
	order: OrderRepository;
	coupon: CouponRepository;
	report: ReportRepository;
	review: ReviewRepository;
	transaction: TransactionRepository;
	user: {
		admin: UserAdminRepository;
		me: UserMeRepository;
	};
	wallet: WalletRepository;
	notification: NotificationRepository;
}

export interface UserInContext {
	id: string;
	role: UserRole;
	banned: boolean;
	banReason?: string;
	banExpires?: Date;
}

export interface ManagerContext {
	jwt: JwtManager;
	pw: PasswordManager;
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
		locale: Locale;
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
	locale: Locale;
	token?: string;
}

export type WithTx = { tx: DatabaseTransaction };
export type WithUserId = { userId: string };
export type PartialWithTx = Partial<WithTx>;
export type WebsocketAttachment = {
	id: string;
	[key: string]: string;
};
export type ListResult<T> = {
	rows: T[];
	totalPages?: number;
};

export interface CountCache {
	total: number;
}

export type OrderByOperation = {
	sql: typeof sql;
	asc: typeof asc;
	desc: typeof desc;
};

export type UnifiedListResult<T> = {
	rows: T[];
	pagination?: PaginationResult;
};
