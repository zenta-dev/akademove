import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { ReviewSpec } from "./review-spec";

const { priv } = createORPCRouter(ReviewSpec);

export const ReviewHandler = priv.router({
	list: priv.list
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
	get: priv.get
		.use(hasPermission({ review: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.review.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved review data", data: result },
			};
		}),
	create: priv.create
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
	update: priv.update
		.use(hasPermission({ review: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.review.update(params.id, body);

			return {
				status: 200,
				body: { message: "Review updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ review: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.review.remove(params.id);

			return {
				status: 200,
				body: { message: "Review deleted successfully", data: null },
			};
		}),
});
