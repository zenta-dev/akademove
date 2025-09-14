import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { InsertPromoSchema, UpdatePromoSchema } from "@repo/schema/promo";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { PromoSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		PromoSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.promo.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve promos",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve promos",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		PromoSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.promo.getById(id, c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Promo with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Promo found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		PromoSpec.create,
		validator("json", InsertPromoSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.promo.create({
				...c.req.valid("json"),
			});

			return c.json(
				{
					success: true,
					message: "Promo created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		PromoSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdatePromoSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.promo.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Promo updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		PromoSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.promo.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Promo deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as PromoHandler };
