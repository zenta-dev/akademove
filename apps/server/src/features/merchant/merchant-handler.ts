import { createORPCRouter } from "@/core/router/orpc";
import { MerchantApprovalHandler } from "./approval/merchant-approval-handler";
import { MerchantMainHandler } from "./main/merchant-main-handler";
import { MerchantMenuHandler } from "./menu/merchant-menu-handler";
import { MerchantSpec } from "./merchant-spec";
import { MerchantOrderHandler } from "./order/merchant-order-handler";

const { priv } = createORPCRouter(MerchantSpec);

export const MerchantHandler = priv.router({
	...MerchantMainHandler,
	...MerchantApprovalHandler,
	menu: MerchantMenuHandler,
	order: MerchantOrderHandler,
});
