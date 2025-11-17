import { unflattenData } from "@repo/schema/flatten.helper";
import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { MerchantMainSpec } from "./merchant-main-spec";

const { priv } = createORPCRouter(MerchantMainSpec);

export const MerchantMainHandler = priv.router({
	getMine: priv.getMine
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context }) => {
			const result = await context.repo.merchant.main.getByUserId(
				context.user.id,
			);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	list: priv.list
		.use(hasPermission({ merchant: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.merchant.main.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchants data",
					data: rows,
					totalPages,
				},
			};
		}),
	populars: priv.populars
		.use(hasPermission({ merchant: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			console.log("POPULARS MERCHANT => ", query);
			const result =
				await context.repo.merchant.main.getPopularMerchants(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchants data",
					data: result,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			console.log("GET MERCHANT => ", params);
			const result = await context.repo.merchant.main.get(params.id);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved merchant data",
					data: result,
				},
			};
		}),
	update: priv.update
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(unflattenData(body));
			const result = await context.repo.merchant.main.update(params.id, data);

			return {
				status: 200,
				body: { message: "Merchant updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ merchant: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.merchant.main.remove(params.id);

			return {
				status: 200,
				body: { message: "Merchant deleted successfully", data: null },
			};
		}),
});
