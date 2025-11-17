import { oc } from "@orpc/contract";
import {
	FlatUpdateUserSchema,
	UpdateUserPasswordSchema,
	UserSchema,
} from "@repo/schema/user";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { toOAPIRequestBody } from "@/utils/oapi";

export const UserMeSpec = {
	update: oc
		.route({
			tags: [FEATURE_TAGS.USER],
			method: "PUT",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(FlatUpdateUserSchema),
			}),
		})
		.input(
			z.object({
				body: FlatUpdateUserSchema,
			}),
		)
		.output(createSuccesSchema(UserSchema, "User updated successfully")),
	changePassword: oc
		.route({
			tags: [FEATURE_TAGS.USER],
			method: "PUT",
			path: "/change-password",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: UpdateUserPasswordSchema,
			}),
		)
		.output(createSuccesSchema(z.boolean(), "User updated successfully")),
};
