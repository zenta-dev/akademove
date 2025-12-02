import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
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
					message: "Contact submitted successfully",
					data: result,
				},
			};
		});
	}),
	list: priv.list
		.use(hasPermission({ user: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.contact.list(query);

			return {
				status: 200 as const,
				body: {
					message: "Contacts fetched successfully",
					data: result,
				},
			};
		}),
	getById: priv.getById
		.use(hasPermission({ user: ["list"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.contact.get(params.id);

			return {
				status: 200 as const,
				body: {
					message: "Contact fetched successfully",
					data: result,
				},
			};
		}),
	update: priv.update
		.use(hasPermission({ user: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.contact.update(params.id, data, {
					tx,
				});

				return {
					status: 200 as const,
					body: {
						message: "Contact updated successfully",
						data: result,
					},
				};
			});
		}),
	delete: priv.delete
		.use(hasPermission({ user: ["delete"] }))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				await context.repo.contact.delete(params.id, { tx });

				return {
					status: 200 as const,
					body: {
						message: "Contact deleted successfully",
						data: true,
					},
				};
			});
		}),
});
