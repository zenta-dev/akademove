import { createAccessControl } from "better-auth/plugins/access";

///
/// WARNING: BE CAREFUL EDITING THIS SHIT
/// 				 OR YOU WILL BE FIRED
///

const statement = {
	driver: ["create", "get", "update", "delete", "ban", "approve"],
	merchant: ["create", "get", "update", "delete", "approve"],
	order: ["create", "get", "update", "delete", "cancel", "assign"],
	schedule: ["create", "get", "update", "delete"],
	promo: ["create", "get", "update", "delete", "approve"],
	report: ["create", "get", "update", "delete", "export"],
	review: ["create", "get", "update", "delete"],
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
	pricing: ["get", "update", "delete"],
	bookings: ["create", "get", "update", "delete"],
} as const;

const ac = createAccessControl(statement);

const admin = ac.newRole({
	driver: ["get", "update", "ban", "approve"],
	merchant: ["get", "update", "delete", "approve"],
	order: ["get", "update", "delete", "cancel", "assign"],
	schedule: ["get", "update", "delete"],
	promo: ["create", "get", "update", "delete", "approve"],
	report: ["create", "get", "update", "delete", "export"],
	review: ["get", "update", "delete"],
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
	pricing: ["get", "update", "delete"],
	bookings: ["create", "get", "update", "delete"],
});

const operator = ac.newRole({
	driver: ["get", "update", "ban"],
	merchant: ["get", "update"],
	order: ["get", "update", "cancel", "assign"],
	schedule: ["get", "update"],
	promo: ["get", "update"],
	report: ["create", "get", "export"],
	review: ["get"],
	user: ["get", "update"],
	pricing: ["get", "update", "delete"],
});

const merchant = ac.newRole({
	merchant: ["get", "update"],
	order: ["get", "update"],
	review: ["get"],
	report: ["get"],
});

const driver = ac.newRole({
	driver: ["get", "update"],
	schedule: ["create", "get", "update", "delete"],
	order: ["get", "update"],
	review: ["get"],
	report: ["get"],
});

const user = ac.newRole({
	user: ["get", "update"],
	order: ["create", "get", "update", "cancel"],
	review: ["create", "get", "update"],
	merchant: ["get"],
	promo: ["get"],
	bookings: ["create", "get", "update", "delete"],
});

export const authPermission = {
	ac,
	roles: { admin, operator, merchant, driver, user },
};
