import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, PhoneSchema } from "./common.ts";
import { InsertDriverSchema } from "./driver.ts";
import { flattenZodObject } from "./flatten.helper.ts";
import { InsertMerchantSchema } from "./merchant.ts";
import { UserGenderSchema, UserSchema } from "./user.ts";

export const SessionSchema = z
	.object({
		id: z.string(),
		expiresAt: DateSchema,
		token: z.string(),
		ipAddress: z.string().optional(),
		userAgent: z.string().optional(),
		userId: z.string(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({ title: "Session" });

export const SignInSchema = z
	.object({
		email: z
			.email(m.invalid_placeholder({ field: m.email_address().toLowerCase() }))
			.max(255),
		password: z
			.string()
			.min(8, m.min_placeholder({ field: m.password(), min: 8 })),
	})
	.meta({ title: "SignInRequest" });

export const SignUpSchema = z
	.object({
		name: z
			.string()
			.min(1, m.required_placeholder({ field: m.name() }))
			.max(256),
		email: z
			.email(m.invalid_placeholder({ field: m.email_address().toLowerCase() }))
			.max(256),
		photo: z.file().mime(["image/png", "image/jpg", "image/jpeg"]).optional(),
		gender: UserGenderSchema.optional(),
		phone: PhoneSchema,
		password: z
			.string()
			.min(8, m.min_placeholder({ field: m.password(), min: 8 }))
			.max(256),
		confirmPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.confirm_password(), min: 8 }))
			.max(256),
	})
	.refine((data) => data.password === data.confirmPassword, {
		path: ["confirmPassword"],
		message: m.password_do_not_match(),
	})
	.meta({ title: "SignUpRequest" });
export const FlatSignUpSchema = flattenZodObject(SignUpSchema, "").meta({
	title: "FlatSignUpRequest",
});

export const SignUpDriverSchema = SignUpSchema.omit({ photo: true })
	.safeExtend({
		photo: z
			.file(m.required_placeholder({ field: m.photo() }))
			.mime(["image/png", "image/jpg", "image/jpeg"]),
		detail: InsertDriverSchema,
	})
	.meta({ title: "SignUpDriverRequest" });
export const FlatSignUpDriverSchema = flattenZodObject(
	SignUpDriverSchema,
	"",
).meta({ title: "FlatSignUpDriverRequest" });

export const SignUpMerchantSchema = SignUpSchema.safeExtend({
	gender: UserGenderSchema.optional(),
	detail: InsertMerchantSchema,
}).meta({ title: "SignUpMerchantRequest" });

export const FlatSignUpMerchantSchema = flattenZodObject(
	SignUpMerchantSchema,
	"",
).meta({ title: "FlatSignUpMerchantRequest" });

export const ForgotPasswordSchema = z
	.object({
		email: z.email(
			m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
		),
	})
	.meta({ title: "ForgotPasswordRequest" });

export const ResetPasswordSchema = z
	.object({
		token: z.string(),
		newPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.new_password(), min: 8 })),
		confirmPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.confirm_password(), min: 8 })),
	})
	.refine((data) => data.newPassword === data.confirmPassword, {
		path: ["confirmPassword"],
		message: m.password_do_not_match(),
	})
	.meta({ title: "ResetPasswordRequest" });

export const SignInResponseSchema = z
	.object({
		token: z.string(),
		user: UserSchema,
	})
	.meta({ title: "SignInResBody" });

export const SignUpResponseSchema = z
	.object({
		user: UserSchema,
	})
	.meta({ title: "SignUpResBody" });

export const GetSessionResponseSchema = z
	.object({
		token: z.string().optional(),
		user: UserSchema,
	})
	.nullable()
	.meta({ title: "GetSessionResBody" });

export type Session = z.infer<typeof SessionSchema>;
export type SignIn = z.infer<typeof SignInSchema>;
export type SignUp = z.infer<typeof SignUpSchema>;
export type SignUpDriver = z.infer<typeof SignUpDriverSchema>;
export type SignUpMerchant = z.infer<typeof SignUpMerchantSchema>;
export type FlatSignUp = z.infer<typeof FlatSignUpSchema>;
export type FlatSignUpDriver = z.infer<typeof FlatSignUpDriverSchema>;
export type FlatSignUpMerchant = z.infer<typeof FlatSignUpMerchantSchema>;
export type ForgotPassword = z.infer<typeof ForgotPasswordSchema>;
export type ResetPassword = z.infer<typeof ResetPasswordSchema>;
export type SignInResponse = z.infer<typeof SignInResponseSchema>;
export type SignUpResponse = z.infer<typeof SignUpResponseSchema>;
export type GetSessionResponse = z.infer<typeof GetSessionResponseSchema>;
