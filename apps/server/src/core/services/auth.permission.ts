import { createAccessControl } from "better-auth/plugins/access";
import type { AuthInstance } from "./auth";

///
/// WARNING: BE CAREFUL EDITING THIS SHIT
/// 				 OR YOU WILL BE FIRED
///

const statement = {
	driver: ["create", "read", "update", "delete", "ban", "approve"],
	merchant: ["create", "read", "update", "delete", "approve"],
	order: ["create", "read", "update", "delete", "cancel", "assign"],
	schedule: ["create", "read", "update", "delete"],
	promo: ["create", "read", "update", "delete", "approve"],
	report: ["create", "read", "update", "delete", "export"],
	review: ["create", "read", "update", "delete", "moderate"],
	user: [
		"invite",
		"create",
		"get",
		"list",
		"update",
		"delete",
		"verify",
		"set-role",
		"ban",
		"impersonate",
		"set-password",
		"update",
	],
	session: ["list", "revoke", "delete"],
} as const;

export const ac = createAccessControl(statement);

export type Permission = typeof ac.statements;
export type Role = keyof typeof statement;
const admin = ac.newRole({
	driver: ["read", "update", "ban", "approve"],
	merchant: ["read", "update", "delete", "approve"],
	order: ["read", "update", "delete", "cancel", "assign"],
	schedule: ["read", "update", "delete"],
	promo: ["create", "read", "update", "delete", "approve"],
	report: ["create", "read", "update", "delete", "export"],
	review: ["read", "update", "delete", "moderate"],
	user: [
		"invite",
		"list",
		"get",
		"update",
		"delete",
		"verify",
		"set-role",
		"set-password",
		"ban",
	],
	session: ["list", "revoke", "delete"],
});

const operator = ac.newRole({
	driver: ["read", "update", "ban"],
	merchant: ["read", "update"],
	order: ["read", "update", "cancel", "assign"],
	schedule: ["read", "update"],
	promo: ["read", "update"],
	report: ["create", "read", "export"],
	review: ["read", "moderate"],
	user: ["get", "update"],
});

const merchant = ac.newRole({
	merchant: ["read", "update"],
	order: ["read", "update"],
	review: ["read"],
	report: ["read"],
	promo: ["create", "read", "update"],
});

const driver = ac.newRole({
	driver: ["read", "update"],
	schedule: ["create", "read", "update", "delete"],
	order: ["read", "update"],
	review: ["read"],
	report: ["read"],
});

const user = ac.newRole({
	user: ["get", "update"],
	order: ["create", "read", "update", "cancel"],
	review: ["create", "read", "update"],
	merchant: ["read"],
	promo: ["read"],
});

export const roles = { admin, operator, merchant, driver, user };

export type HasPermissionBody = Parameters<
	AuthInstance["api"]["userHasPermission"]
>["0"]["body"];
export type HasPermissionRole = HasPermissionBody["role"];
export type HasPermissionPermissions = Exclude<
	HasPermissionBody["permissions"],
	undefined
>;
