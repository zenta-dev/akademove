import { createORPCRouter } from "@/core/router/orpc";
import { UserAdminHandler } from "./admin/user-admin-handler";
import { UserMeHandler } from "./me/user-me-handler";
import { UserSpec } from "./user-spec";

const { pub } = createORPCRouter(UserSpec);

export const UserHandler = pub.router({
	admin: UserAdminHandler,
	me: UserMeHandler,
});
