import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
import { ContactSpec } from "./contact-spec";

const { pub, priv } = createORPCRouter(ContactSpec);

export const ContactHandler = pub.router({
	submit: pub.submit.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);

		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.contact.create(
				{
					...data,
					userId: context.user?.id,
				},
				{ tx },
			);

			return {
				status: 201 as const,
				body: {
					message: m.server_contact_submitted(),
					data: result,
				},
			};
		});
	}),
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.contact.list(
			query
				? {
						...query,
						order: "desc" as const,
						mode: "offset" as const,
						limit: query.limit ?? 10,
					}
				: undefined,
		);

		return {
			status: 200 as const,
			body: {
				message: m.server_contacts_retrieved(),
				data: {
					rows: result.rows,
					pagination: result.pagination
						? { totalPages: result.pagination.totalPages ?? 0 }
						: undefined,
				},
			},
		};
	}),
	getById: priv.getById.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.contact.get(params.id);

		return {
			status: 200 as const,
			body: {
				message: m.server_contact_retrieved(),
				data: result,
			},
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);

		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.contact.update(params.id, data, {
				tx,
			});

			return {
				status: 200 as const,
				body: {
					message: m.server_contact_updated(),
					data: result,
				},
			};
		});
	}),
	delete: priv.delete.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			await context.repo.contact.delete(params.id, { tx });

			return {
				status: 200 as const,
				body: {
					message: m.server_contact_deleted(),
					data: true,
				},
			};
		});
	}),
	respond: priv.respond.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			// Get the original contact first for email details
			const originalContact = await context.repo.contact.get(params.id);

			// Get the responder's name for the email
			const responder = await context.repo.user.admin.get(context.user.id);

			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.contact.respond(
					params.id,
					{
						response: data.response,
						status: data.status ?? "RESOLVED",
						respondedById: context.user.id,
					},
					{ tx },
					context,
				);
			});

			// Send email to user with the response
			try {
				await context.svc.mail.sendContactResponse({
					to: originalContact.email,
					userName: originalContact.name,
					subject: originalContact.subject,
					originalMessage: originalContact.message,
					response: data.response,
					respondedBy: responder?.name ?? "AkadeMove Support",
				});
				log.info(
					{ contactId: params.id, email: originalContact.email },
					"[ContactHandler] Response email sent to user",
				);
			} catch (error) {
				// Log error but don't fail the response operation
				log.error(
					{ error, contactId: params.id, email: originalContact.email },
					"[ContactHandler] Failed to send response email",
				);
			}

			return {
				status: 200 as const,
				body: {
					message: m.server_contact_updated(),
					data: result,
				},
			};
		},
	),
});
