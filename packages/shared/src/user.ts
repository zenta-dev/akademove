import { m } from "@repo/i18n";
import type { UserRole } from "@repo/schema/user";

export const ROLES_TYPED: { id: UserRole; name: string }[] = [
	{
		id: "ADMIN",
		name: m.administrator(),
	},
	{
		id: "OPERATOR",
		name: m.operator(),
	},
	{
		id: "MERCHANT",
		name: m.merchant(),
	},
	{
		id: "DRIVER",
		name: m.driver(),
	},
	{
		id: "USER",
		name: m.user(),
	},
];
