import { RepositoryError } from "@/core/error";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { AnalyticsSpec } from "./analytics-spec";

const { priv } = createORPCRouter(AnalyticsSpec);

export const AnalyticsHandler = priv.router({
	exportDriverAnalytics: priv.exportDriverAnalytics
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { params, query } }) => {
			// IDOR protection - drivers can only export their own data
			if (
				context.user.role === "DRIVER" &&
				context.user.id !== params.driverId
			) {
				throw new RepositoryError(
					"Forbidden: Cannot export other driver data",
					{
						code: "FORBIDDEN",
					},
				);
			}

			const csv = await context.repo.analytics.exportDriverAnalytics({
				driverId: params.driverId,
				startDate: query.startDate,
				endDate: query.endDate,
			});

			return csv;
		}),
	exportMerchantAnalytics: priv.exportMerchantAnalytics
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { params, query } }) => {
			// IDOR protection - merchants can only export their own data
			if (
				context.user.role === "MERCHANT" &&
				context.user.id !== params.merchantId
			) {
				throw new RepositoryError(
					"Forbidden: Cannot export other merchant data",
					{
						code: "FORBIDDEN",
					},
				);
			}

			const csv = await context.repo.analytics.exportMerchantAnalytics({
				merchantId: params.merchantId,
				startDate: query.startDate,
				endDate: query.endDate,
			});

			return csv;
		}),
	exportOperatorAnalytics: priv.exportOperatorAnalytics
		.use(hasPermission({ order: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			// Only operators and admins can export platform analytics
			if (!["OPERATOR", "ADMIN"].includes(context.user.role)) {
				throw new RepositoryError(
					"Forbidden: Only operators and admins can export platform analytics",
					{
						code: "FORBIDDEN",
					},
				);
			}

			const csv = await context.repo.analytics.exportOperatorAnalytics({
				startDate: query.startDate,
				endDate: query.endDate,
			});

			return csv;
		}),
});
