import { oc } from "@orpc/contract";
import { UserAdminSpec } from "./admin/user-admin-spec";

export const UserSpec = oc.router({
	admin: oc.prefix("/admin").router(UserAdminSpec),
});
