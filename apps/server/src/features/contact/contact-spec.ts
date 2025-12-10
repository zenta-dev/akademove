import { oc } from "@orpc/contract";
import {
	ContactSchema,
	InsertContactSchema,
	UpdateContactSchema,
} from "@repo/schema/contact";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ContactSpec = {
	submit: oc
		.route({
			tags: [FEATURE_TAGS.USER],
			method: "POST",
			path: "/submit",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertContactSchema }))
		.output(
			z.union([
				createSuccesSchema(ContactSchema, "Contact submitted successfully", {
					status: 201,
				}),
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
						page: z.coerce.number().int().nonnegative().min(1).optional(),
						limit: z.coerce
							.number()
							.int()
							.nonnegative()
							.min(1)
							.max(1000)
							.optional(),
						status: z
							.enum(["PENDING", "REVIEWING", "RESOLVED", "CLOSED"])
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
						rows: z.array(ContactSchema),
						pagination: z
							.object({
								totalPages: z.coerce.number().int().nonnegative().min(0),
							})
							.optional(),
					}),
					"Contacts fetched successfully",
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
				createSuccesSchema(ContactSchema, "Contact fetched successfully"),
			]),
		),
	update: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "PUT",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					id: z.uuid(),
				}),
				body: UpdateContactSchema,
			}),
		)
		.output(
			z.union([
				createSuccesSchema(ContactSchema, "Contact updated successfully"),
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
				createSuccesSchema(z.literal(true), "Contact deleted successfully"),
			]),
		),
	respond: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/{id}/respond",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({
					id: z.uuid(),
				}),
				body: z.object({
					response: z.string().min(1).max(5000),
					status: z
						.enum(["PENDING", "REVIEWING", "RESOLVED", "CLOSED"])
						.optional(),
				}),
			}),
		)
		.output(
			z.union([
				createSuccesSchema(ContactSchema, "Response sent successfully"),
			]),
		),
};
