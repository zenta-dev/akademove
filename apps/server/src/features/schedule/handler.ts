import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	InsertScheduleSchema,
	UpdateScheduleSchema,
} from "@repo/schema/schedule";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { ScheduleSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		ScheduleSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.schedule.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve schedules",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve schedules",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		ScheduleSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.schedule.getById(
				id,
				c.req.valid("query"),
			);
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Schedule with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Schedule found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		ScheduleSpec.create,
		validator("json", InsertScheduleSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.schedule.create({
				...c.req.valid("json"),
			});

			return c.json(
				{
					success: true,
					message: "Schedule created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		ScheduleSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateScheduleSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.schedule.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Schedule updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		ScheduleSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.schedule.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Schedule deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as ScheduleHandler };
