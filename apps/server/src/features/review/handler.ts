import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { InsertReviewSchema, UpdateReviewSchema } from "@repo/schema/review";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { ReviewSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		ReviewSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.review.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve reviews",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve reviews",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		ReviewSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.review.getById(id, c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Review with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Review found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		ReviewSpec.create,
		validator("json", InsertReviewSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.review.create({
				...c.req.valid("json"),
			});

			return c.json(
				{
					success: true,
					message: "Review created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		ReviewSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateReviewSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.review.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Review updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		ReviewSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.review.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Review deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as ReviewHandler };
