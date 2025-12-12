import { createORPCRouter } from "@/core/router/orpc";
import { MerchantApprovalHandler } from "./approval/merchant-approval-handler";
import { MerchantMainHandler } from "./main/merchant-main-handler";
import { MerchantMenuHandler } from "./menu/merchant-menu-handler";
import { MerchantSpec } from "./merchant-spec";
import { MerchantOperatingHoursHandler } from "./operating-hours/merchant-operating-hours-handler";
import { MerchantOrderHandler } from "./order/merchant-order-handler";
import { MerchantWalletHandler } from "./wallet/merchant-wallet-handler";

const { priv } = createORPCRouter(MerchantSpec);

export const MerchantHandler = priv.router({
	...MerchantMainHandler,
	...MerchantApprovalHandler,
	menu: MerchantMenuHandler,
	order: MerchantOrderHandler,
	operatingHours: MerchantOperatingHoursHandler,
	wallet: MerchantWalletHandler,
});
