import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { orpcAuthMiddleware } from "@/core/middlewares/auth";
import { MerchantMainHandler } from "./main/merchant-main-handler";
import { MerchantMenuHandler } from "./menu/merchant-menu-handler";
import { MerchantSpec } from "./merchant-spec";

const os = implement(MerchantSpec)
	.$context<ORPCContext>()
	.use(orpcAuthMiddleware);

export const MerchantHandler = os.router({
	...MerchantMainHandler,
	menu: MerchantMenuHandler,
});
