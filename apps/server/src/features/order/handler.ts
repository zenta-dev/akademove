import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { InsertOrderSchema, UpdateOrderSchema } from "@repo/schema/order";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { OrderSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		OrderSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.order.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve orders",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve orders",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		OrderSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.order.getById(id, c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Order with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Order found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		OrderSpec.create,
		validator("json", InsertOrderSchema, handleValidation),
		async (c) => {
			// TODO: fix this the logic is flaw
			const result = await c.var.repo.order.create({
				...c.req.valid("json"),
				userId: c.var.userId,
			});

			return c.json(
				{
					success: true,
					message: "Order created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		OrderSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateOrderSchema, handleValidation),
		async (c) => {
			// TODO: fix this the logic is flaw
			const result = await c.var.repo.order.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Order updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		OrderSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.order.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Order deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as OrderHandler };
