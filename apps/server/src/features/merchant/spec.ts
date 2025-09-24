import { oc } from "@orpc/contract";
import { MerchantMainSpec } from "./main/spec";
import { MerchantMenuSpec } from "./menu/spec";

export const MerchantSpec = oc.router({
	...MerchantMainSpec,
	menu: oc.prefix("/{merchantId}/menus").router(MerchantMenuSpec),
});
