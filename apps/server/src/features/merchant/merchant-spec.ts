import { oc } from "@orpc/contract";
import { MerchantApprovalSpec } from "./approval/merchant-approval-spec";
import { MerchantMainSpec } from "./main/merchant-main-spec";
import { MerchantMenuSpec } from "./menu/merchant-menu-spec";
import { MerchantMenuCategorySpec } from "./menu-category/merchant-menu-category-spec";
import { MerchantOperatingHoursSpec } from "./operating-hours/merchant-operating-hours-spec";
import { MerchantOrderSpec } from "./order/merchant-order-spec";
import { MerchantWalletSpec } from "./wallet/merchant-wallet-spec";

export const MerchantSpec = oc.router({
	...MerchantMainSpec,
	...MerchantApprovalSpec,
	menu: oc.prefix("/{merchantId}/menus").router(MerchantMenuSpec),
	menuCategory: oc
		.prefix("/{merchantId}/menu-categories")
		.router(MerchantMenuCategorySpec),
	operatingHours: oc
		.prefix("/{merchantId}/operating-hours")
		.router(MerchantOperatingHoursSpec),
	order: oc.prefix("/{merchantId}/orders").router(MerchantOrderSpec),
	wallet: oc.prefix("/{merchantId}/wallet").router(MerchantWalletSpec),
});
