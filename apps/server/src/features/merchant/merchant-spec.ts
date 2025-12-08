import { oc } from "@orpc/contract";
import { MerchantApprovalSpec } from "./approval/merchant-approval-spec";
import { MerchantMainSpec } from "./main/merchant-main-spec";
import { MerchantMenuSpec } from "./menu/merchant-menu-spec";
import { MerchantOrderSpec } from "./order/merchant-order-spec";

export const MerchantSpec = oc.router({
	...MerchantMainSpec,
	...MerchantApprovalSpec,
	menu: oc.prefix("/{merchantId}/menus").router(MerchantMenuSpec),
	order: oc.prefix("/{merchantId}/orders").router(MerchantOrderSpec),
});
