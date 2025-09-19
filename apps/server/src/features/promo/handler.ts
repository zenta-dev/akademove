import { implement } from "@orpc/server";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { PromoSpec } from "./spec";

const os = implement(PromoSpec).$context<ORPCCOntext>().use(authMiddleware);

export const PromoHandler = os.router({
	list: os.list
		.use(hasPermission({ promo: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.promo.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved promos data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ promo: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.promo.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved promo data", data: result },
			};
		}),
	create: os.create
		.use(hasPermission({ promo: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.promo.create(body);

			return {
				status: 200,
				body: { message: "Promo created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ promo: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.promo.update(params.id, body);

			return {
				status: 200,
				body: { message: "Promo updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ promo: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.promo.remove(params.id);

			return {
				status: 200,
				body: { message: "Promo deleted successfully", data: null },
			};
		}),
});
