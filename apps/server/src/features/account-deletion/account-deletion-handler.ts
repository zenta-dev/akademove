import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { AccountDeletionSpec } from "./account-deletion-spec";

const { pub, priv } = createORPCRouter(AccountDeletionSpec);

export const AccountDeletionHandler = pub.router({
	submit: pub.submit.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);

		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.accountDeletion.create(
				{
					...data,
					userId: context.user?.id,
				},
				{ tx },
			);

			return {
				status: 201 as const,
				body: {
					message: "Account deletion request submitted successfully",
					data: result,
				},
			};
		});
	}),
	list: priv.list
		.use(hasPermission({ accountDeletion: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.accountDeletion.list(
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
					message: "Account deletion requests retrieved successfully",
					data: {
						rows: result.rows,
						pagination: result.pagination
							? { totalPages: result.pagination.totalPages ?? 0 }
							: undefined,
					},
				},
			};
		}),
	getById: priv.getById
		.use(hasPermission({ accountDeletion: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.accountDeletion.get(params.id);

			return {
				status: 200 as const,
				body: {
					message: "Account deletion request retrieved successfully",
					data: result,
				},
			};
		}),
	review: priv.review
		.use(hasPermission({ accountDeletion: ["review"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.accountDeletion.review(
					params.id,
					{
						status: data.status,
						reviewNotes: data.reviewNotes,
						reviewedById: context.user.id,
					},
					{ tx },
					context,
				);

				return {
					status: 200 as const,
					body: {
						message: "Account deletion request reviewed successfully",
						data: result,
					},
				};
			});
		}),
	delete: priv.delete
		.use(hasPermission({ accountDeletion: ["delete"] }))
		.handler(async ({ context, input: { params } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const success = await context.repo.accountDeletion.delete(params.id, {
					tx,
				});

				return {
					status: 200 as const,
					body: {
						message: "Account deletion request deleted successfully",
						data: { success },
					},
				};
			});
		}),
});
