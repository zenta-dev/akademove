import { AuthSchemaRegistries } from "./auth.ts";
import { CommonSchemaRegistries, type SchemaRegistries } from "./common.ts";
import { ConfigurationSchemaRegistries } from "./configuration.ts";
import { CouponSchemaRegistries } from "./coupon.ts";
import { DriverSchemaRegistries } from "./driver.ts";
import { MerchantSchemaRegistries } from "./merchant.ts";
import { OrderSchemaRegistries } from "./order.ts";
import { PaginationSchemaRegistries } from "./pagination.ts";
import { PaymentSchemaRegistries } from "./payment.ts";
import { PositionSchemaRegistries } from "./position.ts";
import { ReportSchemaRegistries } from "./report.ts";
import { ReviewSchemaRegistries } from "./review.ts";
import { TransactionSchemaRegistries } from "./transaction.ts";
import { UserSchemaRegistries } from "./user.ts";
import { WalletSchemaRegistries } from "./wallet.ts";
import { WebsocketSchemaRegistries } from "./websocket.ts";

export const AllSchemaRegistries = {
	...AuthSchemaRegistries,
	...CommonSchemaRegistries,
	...ConfigurationSchemaRegistries,
	...CouponSchemaRegistries,
	...DriverSchemaRegistries,
	...MerchantSchemaRegistries,
	...OrderSchemaRegistries,
	...PaymentSchemaRegistries,
	...PositionSchemaRegistries,
	...ReportSchemaRegistries,
	...ReviewSchemaRegistries,
	...UserSchemaRegistries,
	...WalletSchemaRegistries,
	...WebsocketSchemaRegistries,
	...TransactionSchemaRegistries,
	...PaginationSchemaRegistries,
} satisfies SchemaRegistries;
