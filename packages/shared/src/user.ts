import { m } from "@repo/i18n";
import type { UserRole } from "@repo/schema/user";

export const ROLES_TYPED: { id: UserRole; name: string }[] = [
	{
		id: "admin",
		name: m.administrator(),
	},
	{
		id: "operator",
		name: m.operator(),
	},
	{
		id: "merchant",
		name: m.merchant(),
	},
	{
		id: "driver",
		name: m.driver(),
	},
	{
		id: "user",
		name: m.user(),
	},
];
