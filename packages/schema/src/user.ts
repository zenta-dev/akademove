import { m } from "@repo/i18n";
import * as z from "zod";
import { UserBadgeSchema } from "./badge.js";
import { DateSchema, PhoneSchema, type SchemaRegistries } from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";
import { flattenZodObject } from "./flatten.helper.js";

export const UserRoleSchema = z.enum(CONSTANTS.USER_ROLES);
export type UserRole = z.infer<typeof UserRoleSchema>;

export const UserGenderSchema = z.enum(CONSTANTS.USER_GENDERS);
export type UserGender = z.infer<typeof UserGenderSchema>;

export const UserSchema = z.object({
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

	// attachements:
	userBadges: z.array(UserBadgeSchema),
});
export type User = z.infer<typeof UserSchema>;

export const UserKeySchema = extractSchemaKeysAsEnum(UserSchema).exclude([
	"userBadges",
]);

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
	});
export type InsertUser = z.infer<typeof InsertUserSchema>;

export const UpdateUserRoleSchema = UserSchema.pick({ role: true });
export type UpdateUserRole = z.infer<typeof UpdateUserRoleSchema>;

export const UpdateUserPasswordSchema = z
	.object({
		oldPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.password(), min: 8 })),
		newPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.password(), min: 8 })),
		confirmNewPassword: z
			.string()
			.min(8, m.min_placeholder({ field: m.confirm_password(), min: 8 })),
	})
	.refine((data) => data.newPassword === data.confirmNewPassword, {
		path: ["confirmNewPassword"],
		message: m.password_do_not_match(),
	});
export type UpdateUserPassword = z.infer<typeof UpdateUserPasswordSchema>;

export const BanUserSchema = z.object({
	banReason: z.string(),
	banExpiresIn: z.number().optional(),
});
export type BanUser = z.infer<typeof BanUserSchema>;

export const UnbanUserSchema = UserSchema.pick({ id: true });
export type UnbanUser = z.infer<typeof UnbanUserSchema>;

export const AdminUpdateUserSchema = z.union([
	UpdateUserRoleSchema,
	UpdateUserPasswordSchema,
	BanUserSchema,
	UnbanUserSchema,
]);
export type AdminUpdateUser = z.infer<typeof AdminUpdateUserSchema>;

export const UpdateUserSchema = UserSchema.pick({
	name: true,
	email: true,
})
	.extend({
		photo: z
			.file(m.required_placeholder({ field: m.photo() }))
			.mime(["image/png", "image/jpg", "image/jpeg"]),
		phone: PhoneSchema.partial(),
	})
	.partial();
export type UpdateUser = z.infer<typeof UpdateUserSchema>;
export const FlatUpdateUserSchema = flattenZodObject(UpdateUserSchema);

export const DashboardStatsSchema = z.object({
	totalUsers: z.number(),
	totalDrivers: z.number(),
	totalMerchants: z.number(),
	activeOrders: z.number(),
	totalOrders: z.number(),
	completedOrders: z.number(),
	cancelledOrders: z.number(),
	totalRevenue: z.number(),
	todayRevenue: z.number(),
	todayOrders: z.number(),
	onlineDrivers: z.number(),
});
export type DashboardStats = z.infer<typeof DashboardStatsSchema>;

export const UserSchemaRegistries = {
	UserRole: { schema: UserRoleSchema, strategy: "output" },
	UserGender: { schema: UserGenderSchema, strategy: "output" },
	User: { schema: UserSchema, strategy: "output" },
	InsertUser: { schema: InsertUserSchema, strategy: "input" },
	UpdateUserRole: { schema: UpdateUserRoleSchema, strategy: "input" },
	UpdateUserPassword: { schema: UpdateUserPasswordSchema, strategy: "input" },
	BanUser: { schema: BanUserSchema, strategy: "input" },
	UnbanUser: { schema: UnbanUserSchema, strategy: "input" },
	AdminUpdateUser: { schema: AdminUpdateUserSchema, strategy: "input" },
	UserKey: { schema: UserKeySchema, strategy: "input" },
	DashboardStats: { schema: DashboardStatsSchema, strategy: "output" },
} satisfies SchemaRegistries;
