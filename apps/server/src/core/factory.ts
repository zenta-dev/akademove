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
import { AuthRepository } from "@/features/auth/repository";
import { ConfigurationRepository } from "@/features/configuration/repository";
import { CouponRepository } from "@/features/coupon/repository";
import { DriverRepository } from "@/features/driver/repository";
import { MerchantMainRepository } from "@/features/merchant/main/repository";
import { MerchantMenuRepository } from "@/features/merchant/menu/repository";
import { OrderRepository } from "@/features/order/order_repository";
import { ReportRepository } from "@/features/report/repository";
import { ReviewRepository } from "@/features/review/repository";
import { DriverScheduleRepository } from "@/features/schedule/repository";
import { UserRepository } from "@/features/user/repository";
import { WalletRepository } from "@/features/wallet/wallet_repository";
import { JwtManager } from "@/utils/jwt";
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
	};

	return svc;
}

export function getManagers(): ManagerContext {
	if (_manager) return _manager;

	const manager = { jwt: new JwtManager({ secret: env.AUTH_SECRET }) };

	_manager = manager;
	return manager;
}

export function getRepositories(
	svc: ServiceContext,
	manager: ManagerContext,
): RepositoryContext {
	const repo = {
		auth: new AuthRepository(svc.db, svc.kv, svc.storage, manager.jwt),
		configuration: new ConfigurationRepository(svc.db, svc.kv),
		driver: new DriverRepository(svc.db, svc.kv, svc.storage),
		merchant: {
			main: new MerchantMainRepository(svc.db, svc.kv, svc.storage),
			menu: new MerchantMenuRepository(svc.db, svc.kv, svc.storage),
		},
		order: new OrderRepository(svc.db, svc.kv, svc.map),
		coupon: new CouponRepository(svc.db, svc.kv),
		report: new ReportRepository(svc.db, svc.kv),
		review: new ReviewRepository(svc.db, svc.kv),
		schedule: new DriverScheduleRepository(svc.db, svc.kv),
		user: new UserRepository(svc.db),
		wallet: new WalletRepository(svc.payment),
	};

	return repo;
}
