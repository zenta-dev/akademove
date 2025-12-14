import { trimObjectValues } from "@repo/shared";
import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { FraudSpec } from "./fraud-spec";

const { priv } = createORPCRouter(FraudSpec);

export const FraudHandler = priv.router({
	// List fraud events (ADMIN only)
	listEvents: priv.listEvents
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.fraud.listEvents(query);

			return {
				status: 200,
				body: {
					message: "Fraud events retrieved successfully",
					data: rows,
					totalPages,
				},
			};
		}),

	// Get single fraud event (ADMIN only)
	getEvent: priv.getEvent
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.fraud.get(params.id);

			return {
				status: 200,
				body: {
					message: "Fraud event retrieved successfully",
					data: result,
				},
			};
		}),

	// Review fraud event (ADMIN only)
	reviewEvent: priv.reviewEvent
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.fraud.update(
					params.id,
					{
						status: data.status,
						resolution: data.resolution,
						actionTaken: data.actionTaken,
					},
					{ tx },
					context,
				);

				return {
					status: 200,
					body: {
						message: "Fraud event reviewed successfully",
						data: result,
					},
				};
			});
		}),

	// Get fraud statistics (ADMIN only)
	getStats: priv.getStats
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.fraud.getStats(query);

			return {
				status: 200,
				body: {
					message: "Fraud statistics retrieved successfully",
					data: result,
				},
			};
		}),

	// Get user fraud profile (ADMIN only)
	getUserProfile: priv.getUserProfile
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.fraud.getUserProfile(params.userId);

			return {
				status: 200,
				body: {
					message: "User fraud profile retrieved successfully",
					data: result,
				},
			};
		}),

	// List high-risk users (ADMIN only)
	listHighRiskUsers: priv.listHighRiskUsers
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } =
				await context.repo.fraud.listHighRiskUsers(query);

			return {
				status: 200,
				body: {
					message: "High-risk users retrieved successfully",
					data: rows,
					totalPages,
				},
			};
		}),

	// Get fraud events for a specific user (ADMIN only)
	getUserEvents: priv.getUserEvents
		.use(requireRoles("ADMIN"))
		.handler(async ({ context, input: { params, query } }) => {
			const { rows, totalPages } = await context.repo.fraud.listEvents({
				userId: params.userId,
				page: query?.page ?? 1,
				limit: query?.limit ?? 20,
				sortBy: "detectedAt",
				order: "desc",
			});

			return {
				status: 200,
				body: {
					message: "User fraud events retrieved successfully",
					data: rows,
					totalPages,
				},
			};
		}),
});
