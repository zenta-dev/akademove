import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema } from "./common.ts";

export const UserSchema = z
	.object({
		id: z.string(),
		name: z.string(),
		email: z.email(),
		emailVerified: z.boolean().default(false),
		image: z.url().optional(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "User",
		ref: "User",
	});

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

export const ForgotPasswordSchema = z.object({
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
});

export const ResetPasswordSchema = z
	.object({
		newPassword: z.string().min(8),
		confirmPassword: z.string().min(8),
	})
	.refine((data) => data.newPassword === data.confirmPassword, {
		path: ["confirmPassword"],
		message: m.password_do_not_match(),
	});

export type User = z.infer<typeof UserSchema>;
export type Session = z.infer<typeof SessionSchema>;
export type SignIn = z.infer<typeof SignInSchema>;
export type SignUp = z.infer<typeof SignUpSchema>;
export type ForgotPassword = z.infer<typeof ForgotPasswordSchema>;
export type ResetPassword = z.infer<typeof ResetPasswordSchema>;
