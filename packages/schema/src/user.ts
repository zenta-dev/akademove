import { m } from "@repo/i18n";
import * as z from "zod";
import { DateSchema, PhoneSchema } from "./common.ts";
import { CONSTANTS } from "./constants.ts";

export const UserRoleSchema = z
	.enum(CONSTANTS.USER_ROLES)
	.meta({ title: "UserRole" });

export const UserGenderSchema = z
	.enum(CONSTANTS.USER_GENDERS)
	.meta({ title: "UserGender" });

export const UserSchema = z
	.object({
		id: z.string(),
		name: z
			.string()
			.min(1, m.required_placeholder({ field: m.name() }))
			.max(256),
		email: z
			.email(m.invalid_placeholder({ field: m.email_address().toLowerCase() }))
			.max(256),
		emailVerified: z.boolean(),
		image: z.url().optional(),
		role: UserRoleSchema,
		banned: z.boolean(),
		banReason: z.string().optional(),
		banExpires: DateSchema.optional(),
		gender: UserGenderSchema.optional(),
		phone: PhoneSchema,
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({ title: "User" });

export const InsertUserSchema = UserSchema.omit({
	id: true,
	emailVerified: true,
	image: true,
	banned: true,
	banReason: true,
	banExpires: true,
	createdAt: true,
	updatedAt: true,
})
	.extend({
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
	})
	.meta({ title: "InsertUserRequest" });

export const UpdateUserRoleSchema = UserSchema.pick({ role: true }).meta({
	title: "UpdateUserRoleRequest",
});

export const UpdateUserPasswordSchema = InsertUserSchema.pick({
	password: true,
	confirmPassword: true,
}).meta({
	title: "UpdateUserPasswordRequest",
});

export const BanUserSchema = z
	.object({
		banReason: z.string(),
		banExpiresIn: z.number().optional(),
	})
	.meta({
		title: "BanUserSchemaRequest",
	});

export const UnbanUserSchema = UserSchema.pick({ id: true }).meta({
	title: "UnbanUserSchemaRequest",
});

export const UpdateUserSchema = z.union([
	UpdateUserRoleSchema,
	UpdateUserPasswordSchema,
	BanUserSchema,
	UnbanUserSchema,
]);

export type UserRole = z.infer<typeof UserRoleSchema>;
export type UserGender = z.infer<typeof UserGenderSchema>;
export type User = z.infer<typeof UserSchema>;
export type InsertUser = z.infer<typeof InsertUserSchema>;
export type UpdateUserRole = z.infer<typeof UpdateUserRoleSchema>;
export type UpdateUserPassword = z.infer<typeof UpdateUserPasswordSchema>;
export type BanUser = z.infer<typeof BanUserSchema>;
export type UnbanUser = z.infer<typeof UnbanUserSchema>;
export type UpdateUser = z.infer<typeof UpdateUserSchema>;
