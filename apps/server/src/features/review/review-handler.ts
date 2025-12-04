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
					message: m.server_reviews_retrieved(),
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
				body: { message: m.server_review_retrieved(), data: result },
			};
		}),
	getByOrder: priv.getByOrder
		.use(hasPermission({ review: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.review.getByOrder(params.orderId);

			return {
				status: 200,
				body: {
					message: m.server_order_reviews_retrieved(),
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
					message: m.server_review_eligibility_checked(),
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
					throw new Error(m.server_review_already_exists());
				}
				if (!reviewStatus.orderCompleted) {
					throw new Error(m.server_review_order_not_completed());
				}
				throw new Error(m.server_review_not_authorized());
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
