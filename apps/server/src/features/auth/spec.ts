import { oc } from "@orpc/contract";
import {
	ForgotPasswordSchema,
	GetSessionResponseSchema,
	ResetPasswordSchema,
	SignInResponseSchema,
	SignInSchema,
	SignUpDriverSchema,
	SignUpMerchantSchema,
	SignUpResponseSchema,
	SignUpSchema,
} from "@repo/schema/auth";
import * as z from "zod/v4";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";
import { RBACService } from "@/core/services/rbac";
import { toOAPIRequestBody } from "@/utils/oapi";

export const AuthSpec = {
	signIn: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/sign-in",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: SignInSchema }))
		.output(
			z.union([
				createSuccesSchema(SignInResponseSchema, "Sign In Successfully"),
			]),
		),
	signUpUser: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/sign-up/user",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(SignUpSchema),
			}),
		})
		.input(z.object({ body: SignUpSchema }))
		.output(
			z.union([
				createSuccesSchema(SignUpResponseSchema, "Sign Up Successfully"),
			]),
		),
	signUpDriver: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/sign-up/driver",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(SignUpDriverSchema),
			}),
		})
		.input(z.object({ body: SignUpDriverSchema }))
		.output(
			z.union([
				createSuccesSchema(SignUpResponseSchema, "Sign Up Successfully"),
			]),
		),
	signUpMerchant: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/sign-up/merchant",
			inputStructure: "detailed",
			outputStructure: "detailed",
			spec: (spec) => ({
				...spec,
				...toOAPIRequestBody(SignUpMerchantSchema),
			}),
		})
		.input(z.object({ body: SignUpMerchantSchema }))
		.output(
			z.union([
				createSuccesSchema(SignUpResponseSchema, "Sign Up Successfully"),
			]),
		),
	signOut: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/sign-out",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.any())
		.output(
			z.union([createSuccesSchema(z.literal(true), "Sign Out Successfully")]),
		),
	getSession: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "GET",
			path: "/session",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.any())
		.output(
			z.union([
				createSuccesSchema(
					GetSessionResponseSchema,
					"Get Session Successfully",
				),
			]),
		),
	forgotPassword: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/forgot-password",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: ForgotPasswordSchema }))
		.output(
			z.union([
				createSuccesSchema(
					z.literal(true),
					"Password reset requested successfully",
				),
			]),
		),
	resetPassword: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/reset-password",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: ResetPasswordSchema }))
		.output(
			z.union([
				createSuccesSchema(z.literal(true), "Reset password successfully"),
			]),
		),
	hasPermission: oc
		.route({
			tags: [FEATURE_TAGS.AUTH],
			method: "POST",
			path: "/has-permission",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				body: z.object({
					permissions: RBACService.schema,
				}),
			}),
		)
		.output(z.union([createSuccesSchema(z.boolean(), "User has permission")])),
};
