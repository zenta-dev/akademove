import { env } from "cloudflare:workers";
import type {
	ManagerContext,
	RepositoryContext,
	ServiceContext,
} from "@/core/interface";
import { getDatabase } from "@/core/services/db";
import { CloudflareKVService } from "@/core/services/kv";
import { ResendMailService } from "@/core/services/mail";
import { RBACService } from "@/core/services/rbac";
import { S3StorageService } from "@/core/services/storage";
import { AnalyticsRepository } from "@/features/analytics/analytics-repository";
import { AuthRepository } from "@/features/auth/auth-repository";
import { BadgeRepository } from "@/features/badge/main/badge-main-repository";
import { UserBadgeRepository } from "@/features/badge/user/user-badge-repository";
import { ChatRepository } from "@/features/chat/chat-repository";
import { ConfigurationRepository } from "@/features/configuration/configuration-repository";
import { ContactRepository } from "@/features/contact/contact-repository";
import { CouponRepository } from "@/features/coupon/coupon-repository";
import { DriverMainRepository } from "@/features/driver/main/driver-main-repository";
import { DriverScheduleRepository } from "@/features/driver/schedule/driver-schedule-repository";
import { EmergencyRepository } from "@/features/emergency/emergency-repository";
import { LeaderboardRepository } from "@/features/leaderboard/leaderboard-repository";
import { MerchantMainRepository } from "@/features/merchant/main/merchant-main-repository";
import { MerchantMenuRepository } from "@/features/merchant/menu/merchant-menu-repository";
import { MerchantOrderRepository } from "@/features/merchant/order/merchant-order-repository";
import { NotificationRepository } from "@/features/notification/notification-repository";
import { OrderRepository } from "@/features/order/order-repository";
import { PaymentRepository } from "@/features/payment/payment-repository";
import { ReportRepository } from "@/features/report/report-repository";
import { ReviewRepository } from "@/features/review/review-repository";
import { TransactionRepository } from "@/features/transaction/transaction-repository";
import { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import { UserMeRepository } from "@/features/user/me/user-me-repository";
import { WalletRepository } from "@/features/wallet/wallet-repository";
import { JwtManager } from "@/utils/jwt";
import { PasswordManager } from "@/utils/password";
import { FirebaseAdminService } from "./services/firebase";
import { GoogleMapService } from "./services/map";
import { MidtransPaymentService } from "./services/payment";

var _manager: ManagerContext | undefined;

export function getServices(): ServiceContext {
	const isProduction = env.MIDTRANS_IS_PRODUCTION === "true";

	const svc: ServiceContext = {
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
		map: new GoogleMapService(env.GOOGLE_MAPS_API_KEY),
		payment: new MidtransPaymentService({
			isProduction,
			serverKey: env.MIDTRANS_SERVER_KEY,
			clientKey: env.MIDTRANS_CLIENT_KEY,
		}),
		firebase: new FirebaseAdminService(env.FIREBASE_SERVICE_ACCOUNT),
	};

	return svc;
}

export function getManagers(): ManagerContext {
	if (_manager) return _manager;

	const manager = {
		jwt: new JwtManager({ secret: env.AUTH_SECRET }),
		pw: new PasswordManager(),
	};

	_manager = manager;
	return manager;
}

export function getRepositories(
	svc: ServiceContext,
	manager: ManagerContext,
): RepositoryContext {
	const transaction = new TransactionRepository(svc.db, svc.kv);
	const wallet = new WalletRepository(svc.db, svc.kv);
	const notification = new NotificationRepository(svc.db, svc.kv, svc.firebase);
	const payment = new PaymentRepository(
		svc.db,
		svc.kv,
		svc.payment,
		transaction,
		wallet,
		notification,
	);
	const repo: RepositoryContext = {
		analytics: new AnalyticsRepository(svc.kv, svc.db),
		auth: new AuthRepository(
			svc.db,
			svc.kv,
			svc.storage,
			manager.jwt,
			manager.pw,
			svc.mail,
		),
		badge: {
			main: new BadgeRepository(svc.db, svc.kv, svc.storage),
			user: new UserBadgeRepository(svc.db, svc.kv, svc.storage),
		},
		chat: new ChatRepository(svc.db, svc.kv),
		configuration: new ConfigurationRepository(svc.db, svc.kv),
		contact: new ContactRepository(svc.db, svc.kv),
		driver: {
			main: new DriverMainRepository(svc.db, svc.kv, svc.storage),
			schedule: new DriverScheduleRepository(svc.db, svc.kv),
		},
		emergency: new EmergencyRepository(svc.db, svc.kv),
		leaderboard: new LeaderboardRepository(svc.db, svc.kv),
		merchant: {
			main: new MerchantMainRepository(svc.db, svc.kv, svc.storage),
			menu: new MerchantMenuRepository(svc.db, svc.kv, svc.storage),
			order: new MerchantOrderRepository(svc.db, svc.kv),
		},
		order: new OrderRepository(svc.db, svc.kv, svc.map, payment),
		payment,
		coupon: new CouponRepository(svc.db, svc.kv),
		report: new ReportRepository(svc.db, svc.kv),
		review: new ReviewRepository(svc.db, svc.kv),
		wallet,
		user: {
			admin: new UserAdminRepository(svc.db, svc.kv, svc.storage, manager.pw),
			me: new UserMeRepository(svc.db, svc.kv, svc.storage, manager.pw),
		},
		transaction,
		notification,
	};

	return repo;
}
