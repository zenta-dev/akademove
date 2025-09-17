import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { InsertUserSchema, UpdateUserSchema } from "@repo/schema/user";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import {
	requireAuthMiddleware,
	requiredPermissions,
} from "@/core/middlewares/auth";
import { UserSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		UserSpec.list,
		requiredPermissions({ user: ["read-all"] }),
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.user.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve users",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve users",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		UserSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.user.getById(id, c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: `User with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "User found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		UserSpec.create,
		validator("json", InsertUserSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.user.create({
				...c.req.valid("json"),
			});

			return c.json(
				{
					success: true,
					message: "User created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		UserSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateUserSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.user.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "User updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		UserSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.user.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "User deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as UserHandler };
