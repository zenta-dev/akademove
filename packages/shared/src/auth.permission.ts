///
/// WARNING: BE CAREFUL EDITING THIS SHIT
/// 				 OR YOU WILL BE FIRED
///

export const statement = {
	driver: ["list", "get", "create", "update", "delete", "ban", "approve"],
	merchant: ["list", "get", "create", "update", "delete", "approve"],
	merchantMenu: ["list", "get", "create", "update", "delete"],
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
	configurations: ["list", "get", "create", "update", "delete"],
	emergency: ["list", "get", "create", "update"],
	contact: ["list", "get", "update", "delete", "respond"],
} as const;

export type Statement = typeof statement;
export type Resource = keyof Statement;
export type Action<R extends Resource> = Statement[R][number];

export type PermissionMap = {
	[R in Resource]?: Action<R>[];
};

export type Permissions = Partial<{
	[K in keyof Statement]: Action<K>[];
}>;
