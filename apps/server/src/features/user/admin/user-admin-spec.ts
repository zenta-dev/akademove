import { oc } from "@orpc/contract";
import { UserListQuerySchema } from "@repo/schema/pagination";
import {
	AdminUpdateUserSchema,
	DashboardStatsQuerySchema,
	DashboardStatsSchema,
	InviteUserSchema,
	UserSchema,
} from "@repo/schema/user";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const UserAdminSpec = {
	list: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: UserListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(UserSchema),
				"Successfully retrieved users data",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(UserSchema, "Successfully retrieved user data")),
	create: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InviteUserSchema }))
		.output(createSuccesSchema(UserSchema, "User created successfully")),
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
				params: z.object({ id: z.string() }),
				body: AdminUpdateUserSchema,
			}),
		)
		.output(createSuccesSchema(UserSchema, "User updated successfully")),
	remove: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "DELETE",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(createSuccesSchema(z.null(), "User deleted successfully")),
	dashboardStats: oc
		.route({
			tags: [FEATURE_TAGS.ADMIN],
			method: "GET",
			path: "/dashboard-stats",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: DashboardStatsQuerySchema }))
		.output(
			createSuccesSchema(
				DashboardStatsSchema,
				"Successfully retrieved dashboard statistics",
			),
		),
};
