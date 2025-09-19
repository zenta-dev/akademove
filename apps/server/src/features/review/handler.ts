import { implement } from "@orpc/server";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import type { ORPCCOntext } from "@/core/orpc";
import { ReviewSpec } from "./spec";

const os = implement(ReviewSpec).$context<ORPCCOntext>().use(authMiddleware);

export const ReviewHandler = os.router({
	list: os.list
		.use(hasPermission({ review: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.review.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved reviews data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ review: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.review.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved review data", data: result },
			};
		}),
	create: os.create
		.use(hasPermission({ review: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.review.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Review created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ review: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.review.update(params.id, body);

			return {
				status: 200,
				body: { message: "Review updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ review: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.review.remove(params.id);

			return {
				status: 200,
				body: { message: "Review deleted successfully", data: null },
			};
		}),
});
