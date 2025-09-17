import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { InsertDriverSchema, UpdateDriverSchema } from "@repo/schema/driver";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { upgradeWebSocket } from "hono/cloudflare-workers";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { DriverSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get("/track", async (c, next) => {
		return upgradeWebSocket((_c) => {
			return {
				onMessage(event, ws) {
					console.log(`Message from client: ${event.data}`);
					ws.send("Hello from server!");
				},
				onClose: () => {
					console.log("Connection closed");
				},
			};
		})(c, next);
	})
	.get(
		"/",
		DriverSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.driver.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve drivers",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve drivers",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		DriverSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.driver.getById(id, c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Driver with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Driver found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		DriverSpec.create,
		validator("json", InsertDriverSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.driver.create({
				...c.req.valid("json"),
				userId: c.var.user.id,
			});

			return c.json(
				{
					success: true,
					message: "Driver created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		DriverSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateDriverSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.driver.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Driver updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		DriverSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.driver.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Driver deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as DriverHandler };
