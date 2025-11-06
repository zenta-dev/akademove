/**
 *  ┌───────────────────────────────────────────┐
 *  │  WARNING: DO NOT TOUCH CARELESSLY         │
 *  │   OR YOU WILL BE FIRED                    │
 *  └───────────────────────────────────────────┘
 */

import { createStatementSchema } from "@repo/schema/rbac";
import type { UserRole } from "@repo/schema/user";
import { type PermissionMap, type Permissions, statement } from "@repo/shared";
import { log } from "@/utils";
import { AuthError, BaseError } from "../error";

const roles: Record<UserRole, PermissionMap> = {
	admin: {
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
		configurations: ["list", "get", "update"],
	},
	operator: {
		driver: ["list", "get", "update", "ban"],
		merchant: ["list", "get", "update"],
		order: ["list", "get", "update", "cancel", "assign"],
		schedule: ["list", "get", "update"],
		coupon: ["list", "get", "create", "update"],
		report: ["list", "get", "create", "export"],
		review: ["list", "get"],
		user: ["list", "get", "update"],
		pricing: ["get", "update", "delete"],
	},
	merchant: {
		merchant: ["get", "update"],
		merchantMenu: ["list", "get", "create", "update", "delete"],
		order: ["list", "get", "update"],
		review: ["get"],
		report: ["get"],
	},
	driver: {
		driver: ["get", "update"],
		schedule: ["list", "get", "create", "update", "delete"],
		order: ["get", "update"],
		review: ["get"],
		report: ["get"],
	},
	user: {
		user: ["get", "update"],
		driver: ["list", "get"],
		order: ["list", "get", "create", "update", "cancel"],
		review: ["list", "get", "create", "update"],
		merchant: ["list", "get"],
		coupon: ["list", "get"],
		bookings: ["get", "create", "update", "delete"],
	},
} as const;

export interface HasPermissionInput<R extends UserRole = UserRole> {
	role: R;
	permissions: Permissions;
}

export class RBACService {
	private readonly roles = roles;

	public hasPermission<R extends UserRole>(
		input: HasPermissionInput<R>,
	): boolean {
		try {
			const { role, permissions } = input;

			const rolePerms = this.roles[role];
			if (!rolePerms) return false;

			for (const [resource, actions] of Object.entries(permissions)) {
				const allowed = rolePerms[resource as keyof typeof rolePerms];
				if (!allowed) return false;

				const allowedList = Array.from(allowed as readonly string[]);
				for (const action of actions || []) {
					if (!allowedList.includes(action)) return false;
				}
			}
			return true;
		} catch (error) {
			log.error(error, `${this.hasPermission.name} failed`);
			if (error instanceof BaseError) throw error;
			throw new AuthError("You didnt have access", {
				code: "UNAUTHORIZED",
			});
		}
	}

	static schema = createStatementSchema(statement).partial().meta({
		title: "Statements",
		ref: "Statements",
	});
}
