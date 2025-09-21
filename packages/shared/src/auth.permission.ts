import { createAccessControl } from "better-auth/plugins/access";

///
/// WARNING: BE CAREFUL EDITING THIS SHIT
/// 				 OR YOU WILL BE FIRED
///

const statement = {
	driver: ["list", "get", "create", "update", "delete", "ban", "approve"],
	merchant: ["list", "get", "create", "update", "delete", "approve"],
	order: ["list", "get", "create", "update", "delete", "cancel", "assign"],
	schedule: ["list", "get", "create", "update", "delete"],
	coupon: ["list", "get", "create", "update", "delete", "approve"],
	report: ["list", "get", "create", "update", "delete", "export"],
	review: ["list", "get", "create", "update", "delete"],
	user: [
		"list",
		"get",
		"invite",
		"create",
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
	bookings: ["list", "get", "create", "update", "delete"],
} as const;

const ac = createAccessControl(statement);

const admin = ac.newRole({
	driver: ["list", "get", "update", "ban", "approve"],
	merchant: ["list", "get", "update", "delete", "approve"],
	order: ["list", "get", "update", "delete", "cancel", "assign"],
	schedule: ["list", "get", "update", "delete"],
	coupon: ["list", "get", "create", "update", "delete", "approve"],
	report: ["list", "get", "create", "update", "delete", "export"],
	review: ["list", "get", "update", "delete"],
	user: [
		"list",
		"get",
		"invite",
		"update",
		"delete",
		"verify",
		"set-role",
		"set-password",
		"ban",
	],
	session: ["list", "revoke", "delete"],
	pricing: ["get", "update", "delete"],
	bookings: ["list", "get", "create", "update", "delete"],
});

const operator = ac.newRole({
	driver: ["list", "get", "update", "ban"],
	merchant: ["list", "get", "update"],
	order: ["list", "get", "update", "cancel", "assign"],
	schedule: ["list", "get", "update"],
	coupon: ["list", "get", "create", "update"],
	report: ["list", "get", "create", "export"],
	review: ["list", "get"],
	user: ["list", "get", "update"],
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
	schedule: ["get", "create", "update", "delete"],
	order: ["get", "update"],
	review: ["get"],
	report: ["get"],
});

const user = ac.newRole({
	user: ["get", "update"],
	order: ["get", "create", "update", "cancel"],
	review: ["get", "create", "update"],
	merchant: ["get"],
	coupon: ["get"],
	bookings: ["get", "create", "update", "delete"],
});

export const authPermission = {
	ac,
	roles: { admin, operator, merchant, driver, user },
};
