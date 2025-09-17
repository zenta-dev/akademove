import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import {
	InsertMerchantSchema,
	UpdateMerchantSchema,
} from "@repo/schema/merchant";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { MerchantSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		MerchantSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.merchant.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve merchants",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve merchants",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		MerchantSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.merchant.getById(
				id,
				c.req.valid("query"),
			);
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Merchant with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Merchant found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		MerchantSpec.create,
		validator("json", InsertMerchantSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.merchant.create({
				...c.req.valid("json"),
				userId: c.var.user.id,
			});

			return c.json(
				{
					success: true,
					message: "Merchant created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		MerchantSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateMerchantSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.merchant.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Merchant updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		MerchantSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.merchant.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Merchant deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as MerchantHandler };
