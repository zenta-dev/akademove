import { GetQuerySchema, UUIDParamSchema } from "@repo/schema/common";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { InsertReportSchema, UpdateReportSchema } from "@repo/schema/report";
import { validator } from "hono-openapi";
import { createHono, handleValidation } from "@/core/hono";
import { requireAuthMiddleware } from "@/core/middlewares/auth";
import { ReportSpec } from "./spec";

const h = createHono()
	.use("*", requireAuthMiddleware)
	.get(
		"/",
		ReportSpec.list,
		validator("query", UnifiedPaginationQuerySchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.report.getAll(c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: "Failed to retrieve reports",
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Success retrieve reports",
					data: result,
				},
				200,
			);
		},
	)
	.get(
		"/:id",
		ReportSpec.byID,
		validator("param", UUIDParamSchema, handleValidation),
		validator("query", GetQuerySchema, handleValidation),
		async (c) => {
			const { id } = c.req.valid("param");
			const result = await c.var.repo.report.getById(id, c.req.valid("query"));
			if (!result) {
				return c.json(
					{
						success: false,
						message: `Report with id: ${id} not found`,
						errors: [],
					},
					404,
				);
			}
			return c.json(
				{
					success: true,
					message: "Report found",
					data: result,
				},
				200,
			);
		},
	)
	.post(
		"/",
		ReportSpec.create,
		validator("json", InsertReportSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.report.create({
				...c.req.valid("json"),
			});

			return c.json(
				{
					success: true,
					message: "Report created successfully",
					data: result,
				},
				200,
			);
		},
	)
	.put(
		"/:id",
		ReportSpec.update,
		validator("param", UUIDParamSchema, handleValidation),
		validator("json", UpdateReportSchema, handleValidation),
		async (c) => {
			const result = await c.var.repo.report.update(
				c.req.valid("param").id,
				c.req.valid("json"),
			);

			return c.json(
				{
					success: true,
					message: "Report updated successfully",
					data: result,
				},
				200,
			);
		},
	)
	.delete(
		"/:id",
		ReportSpec.delete,
		validator("param", UUIDParamSchema, handleValidation),
		async (c) => {
			await c.var.repo.report.delete(c.req.valid("param").id);

			return c.json(
				{
					success: true,
					message: "Report deleted successfully",
					data: null,
				},
				200,
			);
		},
	);

export { h as ReportHandler };
