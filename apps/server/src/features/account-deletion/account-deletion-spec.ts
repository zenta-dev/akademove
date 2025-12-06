import { oc } from "@orpc/contract";
import {
	AccountDeletionSchema,
	InsertAccountDeletionSchema,
} from "@repo/schema/account-deletion";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const AccountDeletionSpec = {
	submit: oc
		.route({
			tags: [FEATURE_TAGS.USER],
			method: "POST",
			path: "/submit",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertAccountDeletionSchema }))
		.output(
			z.union([
				createSuccesSchema(
					AccountDeletionSchema,
					"Account deletion request submitted successfully",
					{
						status: 201,
					},
				),
			]),
		),
	list: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: z
					.object({
						page: z.coerce.number().int().min(1).optional(),
						limit: z.coerce.number().int().min(1).max(100).optional(),
						status: z
							.enum([
								"PENDING",
								"REVIEWING",
								"APPROVED",
								"REJECTED",
								"COMPLETED",
							])
							.optional(),
						search: z.string().optional(),
					})
					.optional(),
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					z.object({
						rows: z.array(AccountDeletionSchema),
						pagination: z
							.object({
								totalPages: z.number().int().min(0),
							})
							.optional(),
					}),
					"Account deletion requests fetched successfully",
				),
			]),
		),
	getById: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					id: z.uuid(),
				}),
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					AccountDeletionSchema,
					"Account deletion request fetched successfully",
				),
			]),
		),
	review: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "PUT",
			path: "/{id}/review",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					id: z.uuid(),
				}),
				body: z.object({
					status: z.enum(["REVIEWING", "APPROVED", "REJECTED", "COMPLETED"]),
					reviewNotes: z.string().optional(),
				}),
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					AccountDeletionSchema,
					"Account deletion request reviewed successfully",
				),
			]),
		),
	delete: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					id: z.uuid(),
				}),
			}),
		)
		.output(
			z.union([
				createSuccesSchema(
					z.object({ success: z.boolean() }),
					"Account deletion request deleted successfully",
				),
			]),
		),
};
