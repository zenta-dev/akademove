import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { authMiddleware } from "@/core/middlewares/auth";
import { MerchantMainHandler } from "./main/handler";
import { MerchantMenuHandler } from "./menu/handler";
import { MerchantSpec } from "./spec";

const os = implement(MerchantSpec).$context<ORPCContext>().use(authMiddleware);

export const MerchantHandler = os.router({
	...MerchantMainHandler,
	menu: MerchantMenuHandler,
});
