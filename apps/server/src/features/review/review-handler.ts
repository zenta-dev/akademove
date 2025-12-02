import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { ReviewSpec } from "./review-spec";

const { priv } = createORPCRouter(ReviewSpec);

export const ReviewHandler = priv.router({
	list: priv.list
		.use(hasPermission({ review: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.review.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved reviews data",
					data: rows,
					totalPages,
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
	getByOrder: priv.getByOrder
		.use(hasPermission({ review: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.review.getByOrder(params.orderId);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved order reviews",
					data: result,
				},
			};
		}),
	checkCanReview: priv.checkCanReview
		.use(hasPermission({ review: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.review.getOrderReviewStatus(
				params.orderId,
				context.user.id,
			);

			return {
				status: 200,
				body: {
					message: "Successfully checked review eligibility",
					data: result,
				},
			};
		}),
	create: priv.create
		.use(hasPermission({ review: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const data = trimObjectValues(body);

			// Validate that user can review this order
			const reviewStatus = await context.repo.review.getOrderReviewStatus(
				data.orderId,
				context.user.id,
			);

			if (!reviewStatus.canReview) {
				if (reviewStatus.alreadyReviewed) {
					throw new Error("You have already reviewed this order");
				}
				if (!reviewStatus.orderCompleted) {
					throw new Error("Order must be completed before reviewing");
				}
				throw new Error("You cannot review this order");
			}

			const result = await context.repo.review.create({
				...data,
				fromUserId: context.user.id,
			});

			return {
				status: 200,
				body: { message: m.server_review_created(), data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ review: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.review.update(params.id, data);

			return {
				status: 200,
				body: { message: m.server_review_updated(), data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ review: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.review.remove(params.id);

			return {
				status: 200,
				body: { message: m.server_review_deleted(), data: null },
			};
		}),
});
