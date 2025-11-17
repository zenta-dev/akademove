import { oc } from "@orpc/contract";
import { UserAdminSpec } from "./admin/user-admin-spec";
import { UserMeSpec } from "./me/user-me-spec";

export const UserSpec = oc.router({
	admin: oc.prefix("/admin").router(UserAdminSpec),
	me: oc.prefix("/me").router(UserMeSpec),
});
