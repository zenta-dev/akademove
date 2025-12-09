import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { RepositoryError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { ReviewSpec } from "./review-spec";
import { ReviewValidationService } from "./services/review-validation-service";

const { priv } = createORPCRouter(ReviewSpec);

export const ReviewHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
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
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.review.get(params.id);

		return {
			status: 200,
			body: { message: m.server_review_retrieved(), data: result },
		};
	}),
	getByOrder: priv.getByOrder.handler(
		async ({ context, input: { params } }) => {
			const result = await context.repo.review.getByOrder(params.orderId);

			return {
				status: 200,
				body: {
					message: m.server_order_reviews_retrieved(),
					data: result,
				},
			};
		},
	),
	checkCanReview: priv.checkCanReview.handler(
		async ({ context, input: { params } }) => {
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
		},
	),
	create: priv.create.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);

		// Validate that user can review this order
		const reviewStatus = await context.repo.review.getOrderReviewStatus(
			data.orderId,
			context.user.id,
		);

		if (!reviewStatus.canReview) {
			if (reviewStatus.alreadyReviewed) {
				throw new RepositoryError(m.server_review_already_exists(), {
					code: "BAD_REQUEST",
				});
			}
			if (!reviewStatus.orderCompleted) {
				throw new RepositoryError(m.server_review_order_not_completed(), {
					code: "BAD_REQUEST",
				});
			}
			throw new RepositoryError(m.server_review_not_authorized(), {
				code: "BAD_REQUEST",
			});
		}

		// FIX: Validate that toUserId is the correct party in the order
		// This prevents users from reviewing arbitrary users
		const validationService = new ReviewValidationService(context.svc.db);
		const targetValidation = await validationService.validateReviewTarget({
			orderId: data.orderId,
			fromUserId: context.user.id,
			toUserId: data.toUserId,
		});

		if (!targetValidation.valid) {
			throw new RepositoryError(
				targetValidation.error ?? "Invalid review target",
				{
					code: "BAD_REQUEST",
				},
			);
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
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.review.update(params.id, data);

		return {
			status: 200,
			body: { message: m.server_review_updated(), data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.review.remove(params.id);

		return {
			status: 200,
			body: { message: m.server_review_deleted(), data: null },
		};
	}),
});
