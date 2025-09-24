import { implement } from "@orpc/server";
import { authMiddleware } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { MerchantMainHandler } from "./main/handler";
import { MerchantMenuHandler } from "./menu/handler";
import { MerchantSpec } from "./spec";

const os = implement(MerchantSpec).$context<ORPCCOntext>().use(authMiddleware);

export const MerchantHandler = os.router({
	...MerchantMainHandler,
	menu: MerchantMenuHandler,
});
