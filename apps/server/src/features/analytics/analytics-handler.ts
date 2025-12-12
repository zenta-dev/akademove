import { RepositoryError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { AnalyticsSpec } from "./analytics-spec";

const { priv } = createORPCRouter(AnalyticsSpec);

export const AnalyticsHandler = priv.router({
	exportDriverAnalytics: priv.exportDriverAnalytics.handler(
		async ({ context, input: { params, query } }) => {
			// IDOR protection - drivers can only export their own data
			if (
				!shouldBypassAuthorization() &&
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

			return {
				status: 200,
				headers: {
					"Content-Type": "text/csv",
					"Content-Disposition": `attachment; filename="driver-${params.driverId}-analytics.csv"`,
				},
				body: csv,
			};
		},
	),
	exportMerchantAnalytics: priv.exportMerchantAnalytics.handler(
		async ({ context, input: { params, query } }) => {
			// IDOR protection - merchants can only export their own data
			if (
				!shouldBypassAuthorization() &&
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

			return {
				status: 200,
				headers: {
					"Content-Type": "text/csv",
					"Content-Disposition": `attachment; filename="merchant-${params.merchantId}-analytics.csv"`,
				},
				body: csv,
			};
		},
	),
	exportOperatorAnalytics: priv.exportOperatorAnalytics.handler(
		async ({ context, input: { query } }) => {
			// Only operators and admins can export platform analytics
			if (
				!shouldBypassAuthorization() &&
				!["OPERATOR", "ADMIN"].includes(context.user.role)
			) {
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

			const startDateStr = query.startDate.toISOString().split("T")[0];
			const endDateStr = query.endDate.toISOString().split("T")[0];

			return {
				status: 200,
				headers: {
					"Content-Type": "text/csv",
					"Content-Disposition": `attachment; filename="platform-analytics-${startDateStr}-to-${endDateStr}.csv"`,
				},
				body: csv,
			};
		},
	),
});
