import { oc } from "@orpc/contract";
import { MerchantMainSpec } from "./main/merchant-main-spec";
import { MerchantMenuSpec } from "./menu/merchant-menu-spec";

export const MerchantSpec = oc.router({
	...MerchantMainSpec,
	menu: oc.prefix("/{merchantId}/menus").router(MerchantMenuSpec),
});
