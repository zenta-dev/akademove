import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, PhoneSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";
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
	.meta({
		title: "Session",
		ref: "Session",
	});

export const SignInSchema = z.object({
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
	password: z
		.string()
		.min(8, m.min_placeholder({ field: m.password(), min: 8 })),
});

export const SignUpSchema = z
	.object({
		name: z.string().min(1, m.required_placeholder({ field: m.name() })),
		email: z.email(
			m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
		),
		photo: z.file().mime(["image/png", "image/jpg", "image/jpeg"]).optional(),
		gender: UserGenderSchema,
		phone: PhoneSchema,
		password: z
			.string()
			.min(8, m.min_placeholder({ field: m.password(), min: 8 })),
		confirmPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.confirm_password(), min: 8 })),
	})
	.refine((data) => data.password === data.confirmPassword, {
		path: ["confirmPassword"],
		message: m.password_do_not_match(),
	});
export const FlatSignUpSchema = flattenZodObject(SignUpSchema, "");

export const SignUpDriverSchema = SignUpSchema.omit({ photo: true }).safeExtend(
	{
		photo: z.file().mime(["image/png", "image/jpg", "image/jpeg"]),
		detail: InsertDriverSchema,
	},
);
export const FlatSignUpDriverSchema = flattenZodObject(SignUpDriverSchema, "");

export const SignUpMerchantSchema = SignUpSchema.safeExtend({
	detail: InsertMerchantSchema,
});

export const FlatSignUpMerchantSchema = flattenZodObject(
	SignUpMerchantSchema,
	"",
);

export const ForgotPasswordSchema = z.object({
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
});

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
	});

export const SignInResponseSchema = z.object({
	token: z.string(),
	user: UserSchema,
});

export const SignUpResponseSchema = z.object({
	user: UserSchema,
});

export const GetSessionResponseSchema = z
	.object({
		token: z.string().optional(),
		user: UserSchema,
	})
	.nullable();

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
