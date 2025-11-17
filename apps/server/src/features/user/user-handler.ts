import { createORPCRouter } from "@/core/router/orpc";
import { UserAdminHandler } from "./admin/user-admin-handler";
import { UserSpec } from "./user-spec";

const { pub } = createORPCRouter(UserSpec);

export const UserHandler = pub.router({
	admin: UserAdminHandler,
});
