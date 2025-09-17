import {
	createSuccessResponseSchema,
	EmptySchema,
	listifySchema,
} from "@repo/schema/common";
import { UserSchema } from "@repo/schema/user";
import { describeRoute, resolver } from "hono-openapi";
import { FAILED_RESPONSES, FEATURE_TAGS } from "@/core/constants";

export const UserSpec = Object.freeze({
	list: describeRoute({
		operationId: "getAllUser",
		tags: [FEATURE_TAGS.USER],
		responses: {
			200: {
				description: "List of user",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(listifySchema(UserSchema)).meta({
								title: "GetAllUserSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.USER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	byID: describeRoute({
		operationId: "getUserById",
		tags: [FEATURE_TAGS.USER],
		responses: {
			200: {
				description: "Get user by id success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(UserSchema).meta({
								title: "GetUserByIdSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.USER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	create: describeRoute({
		operationId: "createUser",
		tags: [FEATURE_TAGS.USER],
		responses: {
			200: {
				description: "Create user success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(UserSchema).meta({
								title: "CreateUserSuccessResponse",
							}),
						),
					},
				},
			},
			500: FAILED_RESPONSES["500"],
		},
	}),
	update: describeRoute({
		operationId: "updateUser",
		tags: [FEATURE_TAGS.USER],
		responses: {
			200: {
				description: "Update user success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(UserSchema).meta({
								title: "UpdateUserSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.USER),
			500: FAILED_RESPONSES["500"],
		},
	}),
	delete: describeRoute({
		operationId: "deleteUser",
		tags: [FEATURE_TAGS.USER],
		responses: {
			200: {
				description: "Delete user success",
				content: {
					"application/json": {
						schema: resolver(
							createSuccessResponseSchema(EmptySchema).meta({
								title: "DeleteUserSuccessResponse",
							}),
						),
					},
				},
			},
			404: FAILED_RESPONSES["404"](FEATURE_TAGS.USER),
			500: FAILED_RESPONSES["500"],
		},
	}),
} as const);
