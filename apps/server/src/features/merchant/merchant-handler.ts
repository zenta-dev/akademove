import { createORPCRouter } from "@/core/router/orpc";
import { MerchantMainHandler } from "./main/merchant-main-handler";
import { MerchantMenuHandler } from "./menu/merchant-menu-handler";
import { MerchantSpec } from "./merchant-spec";
import { MerchantOrderHandler } from "./order/merchant-order-handler";

const { pub } = createORPCRouter(MerchantSpec);

export const MerchantHandler = pub.router({
	...MerchantMainHandler,
	menu: MerchantMenuHandler,
	order: MerchantOrderHandler,
});
