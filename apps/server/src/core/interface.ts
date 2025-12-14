import type { ResponseHeadersPluginContext } from "@orpc/server/plugins";
import type { Locale } from "@repo/i18n";
import type { ClientAgent } from "@repo/schema/common";
import type { PaginationResult } from "@repo/schema/pagination";
import type { UserRole } from "@repo/schema/user";
import type { asc, desc, sql } from "drizzle-orm";
import type { AccountDeletionRepository } from "@/features/account-deletion/account-deletion-repository";
import type { AnalyticsRepository } from "@/features/analytics/analytics-repository";
import type { AuditRepository } from "@/features/audit/audit-repository";
import type { AuthRepository } from "@/features/auth/auth-repository";
import type {
	PasswordResetService,
	SessionService,
	UserRegistrationService,
} from "@/features/auth/services";
import type { BadgeRepository } from "@/features/badge/main/badge-main-repository";
import type { UserBadgeRepository } from "@/features/badge/user/user-badge-repository";
import type { BannerRepository } from "@/features/banner/banner-repository";
import type { BroadcastRepository } from "@/features/broadcast/broadcast-repository";
import type { ChatRepository } from "@/features/chat/chat-repository";
import type { ConfigurationRepository } from "@/features/configuration/configuration-repository";
import type { ContactRepository } from "@/features/contact/contact-repository";
import type { CouponRepository } from "@/features/coupon/coupon-repository";
import type { DriverApprovalRepository } from "@/features/driver/approval/driver-approval-repository";
import type { DriverMainRepository } from "@/features/driver/main/driver-main-repository";
import type { DriverScheduleRepository } from "@/features/driver/schedule/driver-schedule-repository";
import type {
	DriverAvailabilityService,
	DriverLocationService,
	DriverVerificationService,
} from "@/features/driver/services";
import type { DriverQuizAnswerRepository } from "@/features/driver-quiz-answer/driver-quiz-answer-repository";
import type { DriverQuizQuestionRepository } from "@/features/driver-quiz-question/driver-quiz-question-repository";
import type { EmergencyRepository } from "@/features/emergency/emergency-repository";
import type { FraudRepository } from "@/features/fraud/fraud-repository";
import type { LeaderboardRepository } from "@/features/leaderboard/leaderboard-repository";
import type { MerchantApprovalRepository } from "@/features/merchant/approval/merchant-approval-repository";
import type { MerchantMainRepository } from "@/features/merchant/main/merchant-main-repository";
import type { MerchantMenuRepository } from "@/features/merchant/menu/merchant-menu-repository";
import type { MerchantOperatingHoursRepository } from "@/features/merchant/operating-hours/merchant-operating-hours-repository";
import type { MerchantOrderRepository } from "@/features/merchant/order/merchant-order-repository";
import type { NotificationRepository } from "@/features/notification/notification-repository";
import type { PushNotificationService } from "@/features/notification/services/push-notification-service";
import type { OrderRepository } from "@/features/order/order-repository";
import type {
	DeliveryProofService,
	OrderMatchingService,
	OrderPricingService,
	OrderStateService,
} from "@/features/order/services";
import type { PaymentRepository } from "@/features/payment/payment-repository";
import type {
	PaymentChargeService,
	PaymentWebhookService,
} from "@/features/payment/services";
import type { QuickMessageRepository } from "@/features/quick-message/quick-message-repository";
import type { ReportRepository } from "@/features/report/report-repository";
import type { ReviewRepository } from "@/features/review/review-repository";
import type { SupportChatRepository } from "@/features/support-chat/support-chat-repository";
import type { TransactionRepository } from "@/features/transaction/transaction-repository";
import type { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import type { UserLookupRepository } from "@/features/user/lookup/user-lookup-repository";
import type { UserMeRepository } from "@/features/user/me/user-me-repository";
import type {
	WalletBalanceService,
	WalletTransactionService,
} from "@/features/wallet/services";
import type { WalletRepository } from "@/features/wallet/wallet-repository";
import type { JwtManager } from "@/utils/jwt";
import type { PasswordManager } from "@/utils/password";
import type { DatabaseService, DatabaseTransaction } from "./services/db";
import type { FirebaseAdminService } from "./services/firebase";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";
import type { MapService } from "./services/map";
import type {
	BankValidationService,
	PaymentService,
	PayoutService,
} from "./services/payment";
import type { StorageService } from "./services/storage";

export interface ServiceContext {
	db: DatabaseService;
	kv: KeyValueService;
	mail: MailService;
	storage: StorageService;
	map: MapService;
	payment: PaymentService;
	payout: PayoutService;
	bankValidation: BankValidationService;
	firebase: FirebaseAdminService;
	authServices: {
		session: SessionService;
		registration: UserRegistrationService;
		passwordReset: PasswordResetService;
	};
	orderServices: {
		pricing: OrderPricingService;
		matching: OrderMatchingService;
		state: OrderStateService;
		deliveryProof: DeliveryProofService;
	};
	notificationServices: {
		push: PushNotificationService;
	};
	paymentServices: {
		charge: PaymentChargeService;
		webhook: PaymentWebhookService;
	};
	driverServices: {
		location: DriverLocationService;
		verification: DriverVerificationService;
		availability: DriverAvailabilityService;
	};
	walletServices: {
		balance: WalletBalanceService;
		transaction: WalletTransactionService;
	};
}

export interface RepositoryContext {
	accountDeletion: AccountDeletionRepository;
	analytics: AnalyticsRepository;
	auth: AuthRepository;
	badge: {
		main: BadgeRepository;
		user: UserBadgeRepository;
	};
	banner: BannerRepository;
	chat: ChatRepository;
	configuration: ConfigurationRepository;
	contact: ContactRepository;
	quickMessage: QuickMessageRepository;
	driver: {
		main: DriverMainRepository;
		schedule: DriverScheduleRepository;
		approval: DriverApprovalRepository;
	};
	driverQuizQuestion: DriverQuizQuestionRepository;
	driverQuizAnswer: DriverQuizAnswerRepository;
	emergency: EmergencyRepository;
	fraud: FraudRepository;
	leaderboard: LeaderboardRepository;
	merchant: {
		main: MerchantMainRepository;
		menu: MerchantMenuRepository;
		operatingHours: MerchantOperatingHoursRepository;
		order: MerchantOrderRepository;
		approval: MerchantApprovalRepository;
	};
	payment: PaymentRepository;
	order: OrderRepository;
	coupon: CouponRepository;
	report: ReportRepository;
	review: ReviewRepository;
	supportChat: SupportChatRepository;
	transaction: TransactionRepository;
	user: {
		admin: UserAdminRepository;
		me: UserMeRepository;
		lookup: UserLookupRepository;
	};
	wallet: WalletRepository;
	notification: NotificationRepository;
	audit: AuditRepository;
	broadcast: BroadcastRepository;
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
