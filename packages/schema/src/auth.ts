import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, PhoneSchema, type SchemaRegistries } from "./common.js";
import { InsertDriverSchema } from "./driver.js";
import { flattenZodObject } from "./flatten.helper.js";
import { InsertMerchantSchema } from "./merchant.js";
import { UserGenderSchema, UserRoleSchema, UserSchema } from "./user.js";

export const SessionSchema = z.object({
	id: z.string(),
	expiresAt: DateSchema,
	token: z.string(),
	ipAddress: z.string().optional(),
	userAgent: z.string().optional(),
	userId: z.string(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Session = z.infer<typeof SessionSchema>;

export const SignInSchema = z.object({
	email: z
		.email(m.invalid_placeholder({ field: m.email_address().toLowerCase() }))
		.max(255),
	password: z
		.string()
		.min(8, m.min_placeholder({ field: m.password(), min: 8 })),
});
export type SignIn = z.infer<typeof SignInSchema>;

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
	});
export type SignUp = z.infer<typeof SignUpSchema>;

export const FlatSignUpSchema = flattenZodObject(SignUpSchema, "");
export type FlatSignUp = z.infer<typeof FlatSignUpSchema>;

export const SignUpDriverSchema = SignUpSchema.omit({ photo: true }).safeExtend(
	{
		photo: z
			.file(m.required_placeholder({ field: m.photo() }))
			.mime(["image/png", "image/jpg", "image/jpeg"]),
		detail: InsertDriverSchema,
	},
);
export type SignUpDriver = z.infer<typeof SignUpDriverSchema>;

export const FlatSignUpDriverSchema = flattenZodObject(SignUpDriverSchema, "");
export type FlatSignUpDriver = z.infer<typeof FlatSignUpDriverSchema>;

export const SignUpMerchantSchema = SignUpSchema.safeExtend({
	gender: UserGenderSchema.optional(),
	detail: InsertMerchantSchema,
});
export type SignUpMerchant = z.infer<typeof SignUpMerchantSchema>;

export const FlatSignUpMerchantSchema = flattenZodObject(
	SignUpMerchantSchema,
	"",
);
export type FlatSignUpMerchant = z.infer<typeof FlatSignUpMerchantSchema>;

export const ForgotPasswordSchema = z.object({
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
});
export type ForgotPassword = z.infer<typeof ForgotPasswordSchema>;

export const ResetPasswordSchema = z
	.object({
		email: z.email(
			m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
		),
		code: z
			.string()
			.length(6, m.invalid_placeholder({ field: "OTP code" }))
			.regex(/^\d{6}$/, m.invalid_placeholder({ field: "OTP code" })),
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
export type ResetPassword = z.infer<typeof ResetPasswordSchema>;

export const SendEmailVerificationSchema = z.object({
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
});
export type SendEmailVerification = z.infer<typeof SendEmailVerificationSchema>;

export const VerifyEmailSchema = z.object({
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
	code: z
		.string()
		.length(6, m.invalid_placeholder({ field: "OTP code" }))
		.regex(/^\d{6}$/, m.invalid_placeholder({ field: "OTP code" })),
});
export type VerifyEmail = z.infer<typeof VerifyEmailSchema>;

export const SignInResponseSchema = z.object({
	token: z.string(),
	user: UserSchema,
});
export type SignInResponse = z.infer<typeof SignInResponseSchema>;

export const SignUpResponseSchema = z.object({
	user: UserSchema,
	token: z.string(),
});
export type SignUpResponse = z.infer<typeof SignUpResponseSchema>;

export const GetSessionResponseSchema = z
	.object({
		token: z.string().optional(),
		user: UserSchema,
	})
	.nullable();
export type GetSessionResponse = z.infer<typeof GetSessionResponseSchema>;

export const RoleAccessSchema = z.enum([
	...UserRoleSchema.options,
	"ALL",
	"SYSTEM",
]);
export type RoleAccess = z.infer<typeof RoleAccessSchema>;

export const AuthSchemaRegistries = {
	Session: { schema: SessionSchema, strategy: "output" },
	SignInRequest: { schema: SignInSchema, strategy: "input" },
	ResetPassword: { schema: ResetPasswordSchema, strategy: "input" },
	SendEmailVerification: {
		schema: SendEmailVerificationSchema,
		strategy: "input",
	},
	VerifyEmail: { schema: VerifyEmailSchema, strategy: "input" },
	SignInResponse: { schema: SignInResponseSchema, strategy: "output" },
	SignUpResponse: { schema: SignUpResponseSchema, strategy: "output" },
	GetSessionResponse: { schema: GetSessionResponseSchema, strategy: "output" },
	RoleAccess: { schema: RoleAccessSchema, strategy: "input" },
} satisfies SchemaRegistries;
