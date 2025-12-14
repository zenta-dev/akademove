import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { hasRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { EmergencyContactSpec } from "./emergency-contact-spec";

const { pub, priv } = createORPCRouter(EmergencyContactSpec);

export const EmergencyContactHandler = pub.router({
	// Public endpoint - get primary contact (for emergency WhatsApp redirect)
	getPrimary: priv.getPrimary.handler(async ({ context }) => {
		const result = await context.repo.emergencyContact.getPrimary();
		return {
			status: 200,
			body: {
				message: m.server_emergency_contact_retrieved(),
				data: result,
			},
		};
	}),

	// Public endpoint - list active contacts (for emergency trigger)
	listActive: priv.listActive.handler(async ({ context }) => {
		const result = await context.repo.emergencyContact.listActive();
		return {
			status: 200,
			body: {
				message: m.server_emergency_contacts_retrieved(),
				data: result,
			},
		};
	}),

	// Private endpoints - require ADMIN or OPERATOR role
	list: priv.list.handler(async ({ context, input: { query } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		const result = await context.repo.emergencyContact.list(query);
		return {
			status: 200,
			body: {
				message: m.server_emergency_contacts_retrieved(),
				data: result.rows,
			},
		};
	}),

	get: priv.get.handler(async ({ context, input: { params } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		const result = await context.repo.emergencyContact.get(params.id);
		return {
			status: 200,
			body: {
				message: m.server_emergency_contact_retrieved(),
				data: result,
			},
		};
	}),

	create: priv.create.handler(async ({ context, input: { body } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.emergencyContact.createContact(
				data,
				context.user.id,
				{ tx },
			);

			logger.info(
				{ emergencyContactId: result.id, userId: context.user.id },
				"[EmergencyContactHandler] Emergency contact created",
			);

			return {
				status: 201,
				body: {
					message: m.server_emergency_contact_created(),
					data: result,
				},
			};
		});
	}),

	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.emergencyContact.updateContact(
				params.id,
				data,
				context.user.id,
				{ tx },
			);

			logger.info(
				{ emergencyContactId: params.id, userId: context.user.id },
				"[EmergencyContactHandler] Emergency contact updated",
			);

			return {
				status: 200,
				body: {
					message: m.server_emergency_contact_updated(),
					data: result,
				},
			};
		});
	}),

	delete: priv.delete.handler(async ({ context, input: { params } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.emergencyContact.deleteContact(
				params.id,
				{
					tx,
				},
			);

			logger.info(
				{ emergencyContactId: params.id, userId: context.user.id },
				"[EmergencyContactHandler] Emergency contact deleted",
			);

			return {
				status: 200,
				body: {
					message: m.server_emergency_contact_deleted(),
					data: result,
				},
			};
		});
	}),

	toggleActive: priv.toggleActive.handler(
		async ({ context, input: { params } }) => {
			if (!hasRoles(context.user.role, "SYSTEM")) {
				throw new AuthError("Access denied: Missing required role", {
					code: "FORBIDDEN",
				});
			}

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.emergencyContact.toggleActive(
					params.id,
					context.user.id,
					{ tx },
				);

				logger.info(
					{
						emergencyContactId: params.id,
						isActive: result.isActive,
						userId: context.user.id,
					},
					"[EmergencyContactHandler] Emergency contact toggled",
				);

				return {
					status: 200,
					body: {
						message: m.server_emergency_contact_updated(),
						data: result,
					},
				};
			});
		},
	),
});
