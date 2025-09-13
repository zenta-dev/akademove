import { createSuccessResponseSchema, EmptySchema } from "@repo/schema/common";
import { DriverSchema } from "@repo/schema/driver";
import { describeRoute, resolver } from "hono-openapi";
import z from "zod";
import { FAILED_RESPONSES } from "@/core/constants";

export const DriverSpec = Object.freeze({
	list: describeRoute({
		responses: {
			200: {
				description: "List of driver",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(z.array(DriverSchema)),
						),
					},
				},
			},
			404: FAILED_RESPONSES["400"]("Driver"),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		responses: {
			200: {
				description: "Get driver by id success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(DriverSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["400"]("Driver"),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		responses: {
			200: {
				description: "Create driver success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(DriverSchema)),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		responses: {
			200: {
				description: "Update driver success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(DriverSchema)),
					},
				},
			},
			404: FAILED_RESPONSES["400"]("Driver"),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		responses: {
			200: {
				description: "Delete driver success",
				content: {
					"application/json": {
						schema: resolver(createSuccessResponseSchema(EmptySchema)),
					},
				},
			},
			404: FAILED_RESPONSES["400"]("Driver"),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);
