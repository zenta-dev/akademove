import { m } from "@repo/i18n";
import * as z from "zod";
import {
	BankSchema,
	DateSchema,
	DayOfWeekSchema,
	PhoneSchema,
	type SchemaRegistries,
	TimeSchema,
} from "./common.js";
import { CONSTANTS } from "./constants.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";
import { flattenZodObject } from "./flatten.helper.js";
import { CoordinateSchema } from "./position.js";

export const MerchantCategorySchema = z
	.enum(CONSTANTS.MERCHANT_CATEGORIES)
	.describe("Primary merchant category");

export const MerchantOperatingStatusSchema = z
	.enum(CONSTANTS.MERCHANT_OPERATING_STATUSES)
	.describe("Merchant operating status");

export const MerchantStatusSchema = z
	.enum(CONSTANTS.MERCHANT_STATUSES)
	.describe("Merchant approval status");

export type MerchantStatus = z.infer<typeof MerchantStatusSchema>;

export const MerchantSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	name: z.string().min(1, m.required_placeholder({ field: m.name() })),
	email: z.email(
		m.invalid_placeholder({ field: m.email_address().toLowerCase() }),
	),
	phone: PhoneSchema.optional(),
	address: z.string(),
	location: CoordinateSchema.optional(),
	status: MerchantStatusSchema.describe("Merchant approval status"),
	isActive: z.boolean(),
	isOnline: z
		.boolean()
		.describe("Whether merchant is currently online/available"),
	operatingStatus: MerchantOperatingStatusSchema.describe(
		"Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE)",
	),
	activeOrderCount: z
		.number()
		.int()
		.nonnegative()
		.describe("Number of active orders being processed by merchant"),
	rating: z.coerce.number(),
	document: z.url().optional(),
	image: z.url().optional(),
	category: MerchantCategorySchema,
	categories: z.array(z.string()).describe("List of merchant item categories"),
	bank: BankSchema,
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Merchant = z.infer<typeof MerchantSchema>;

export const MerchantKeySchema = extractSchemaKeysAsEnum(MerchantSchema);

export const InsertMerchantSchema = MerchantSchema.omit({
	id: true,
	userId: true,
	rating: true,
	status: true,
	isActive: true,
	isOnline: true,
	operatingStatus: true,
	activeOrderCount: true,
	document: true,
	image: true,
	categories: true,
	createdAt: true,
	updatedAt: true,
}).safeExtend({
	document: z
		.file()
		.mime(["image/png", "image/jpg", "image/jpeg", "application/pdf"])
		.optional(),
	image: z.file().mime(["image/png", "image/jpg", "image/jpeg"]).optional(),
});
export type InsertMerchant = z.infer<typeof InsertMerchantSchema>;

export const UpdateMerchantSchema = InsertMerchantSchema.partial();
export type UpdateMerchant = z.infer<typeof UpdateMerchantSchema>;

export const FlatUpdateMerchantSchema = flattenZodObject(UpdateMerchantSchema);
export type FlatUpdateMerchant = z.infer<typeof FlatUpdateMerchantSchema>;

export const MerchantMenuSchema = z.object({
	id: z.uuid(),
	merchantId: z.uuid(),
	name: z.string(),
	image: z.url().optional(),
	category: z.string().optional(),
	categoryId: z
		.uuid()
		.optional()
		.describe("Reference to merchant menu category"),
	price: z.coerce.number<number>().nonnegative(),
	stock: z.coerce.number<number>().int().nonnegative(),
	soldStock: z.coerce
		.number<number>()
		.int()
		.nonnegative()
		.describe("Total number of items sold"),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type MerchantMenu = z.infer<typeof MerchantMenuSchema>;

export const MerchantMenuKeySchema =
	extractSchemaKeysAsEnum(MerchantMenuSchema);

export const InsertMerchantMenuSchema = MerchantMenuSchema.omit({
	id: true,
	image: true,
	merchantId: true,
	soldStock: true,
	createdAt: true,
	updatedAt: true,
}).safeExtend({
	image: z.file().mime(["image/png", "image/jpg", "image/jpeg"]).optional(),
});
export type InsertMerchantMenu = z.infer<typeof InsertMerchantMenuSchema>;

export const UpdateMerchantMenuSchema = InsertMerchantMenuSchema.partial();
export type UpdateMerchantMenu = z.infer<typeof UpdateMerchantMenuSchema>;

export const MerchantOperatingHoursSchema = z.object({
	id: z.uuid(),
	merchantId: z.uuid(),
	dayOfWeek: DayOfWeekSchema,
	isOpen: z.boolean().describe("Whether the merchant is open on this day"),
	is24Hours: z
		.boolean()
		.describe("Whether the merchant operates 24 hours on this day"),
	openTime: TimeSchema.optional().describe("Opening time (h: 0-23, m: 0-59)"),
	closeTime: TimeSchema.optional().describe("Closing time (h: 0-23, m: 0-59)"),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type MerchantOperatingHours = z.infer<
	typeof MerchantOperatingHoursSchema
>;

export const MerchantOperatingHoursKeySchema = extractSchemaKeysAsEnum(
	MerchantOperatingHoursSchema,
);

export const InsertMerchantOperatingHoursSchema =
	MerchantOperatingHoursSchema.omit({
		id: true,
		merchantId: true,
		createdAt: true,
		updatedAt: true,
	});
export type InsertMerchantOperatingHours = z.infer<
	typeof InsertMerchantOperatingHoursSchema
>;

export const UpdateMerchantOperatingHoursSchema =
	InsertMerchantOperatingHoursSchema.partial();
export type UpdateMerchantOperatingHours = z.infer<
	typeof UpdateMerchantOperatingHoursSchema
>;

export const BulkUpsertMerchantOperatingHoursSchema = z.object({
	hours: z.array(InsertMerchantOperatingHoursSchema),
});
export type BulkUpsertMerchantOperatingHours = z.infer<
	typeof BulkUpsertMerchantOperatingHoursSchema
>;

export const ActivateMerchantSchema = z.object({
	id: z.uuid(),
});
export type ActivateMerchant = z.infer<typeof ActivateMerchantSchema>;

export const DeactivateMerchantSchema = z.object({
	id: z.uuid(),
	reason: z
		.string()
		.min(10, "Reason must be at least 10 characters")
		.describe("Reason for deactivation"),
});
export type DeactivateMerchant = z.infer<typeof DeactivateMerchantSchema>;

export const SetMerchantOnlineStatusSchema = z.object({
	merchantId: z.uuid(),
	isOnline: z.boolean(),
});
export type SetMerchantOnlineStatus = z.infer<
	typeof SetMerchantOnlineStatusSchema
>;

export const SetMerchantOperatingStatusSchema = z.object({
	merchantId: z.uuid(),
	operatingStatus: MerchantOperatingStatusSchema,
});
export type SetMerchantOperatingStatus = z.infer<
	typeof SetMerchantOperatingStatusSchema
>;

// ========== MERCHANT MENU CATEGORY ==========
// Dynamic menu categories owned by each merchant
export const MerchantMenuCategorySchema = z.object({
	id: z.uuid(),
	merchantId: z.uuid(),
	name: z.string().min(1, m.required_placeholder({ field: m.name() })),
	description: z.string().optional(),
	sortOrder: z.coerce.number().int().nonnegative().default(0),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type MerchantMenuCategory = z.infer<typeof MerchantMenuCategorySchema>;

export const MerchantMenuCategoryKeySchema = extractSchemaKeysAsEnum(
	MerchantMenuCategorySchema,
);

export const InsertMerchantMenuCategorySchema = MerchantMenuCategorySchema.omit(
	{
		id: true,
		merchantId: true,
		createdAt: true,
		updatedAt: true,
	},
);
export type InsertMerchantMenuCategory = z.infer<
	typeof InsertMerchantMenuCategorySchema
>;

export const UpdateMerchantMenuCategorySchema =
	InsertMerchantMenuCategorySchema.partial();
export type UpdateMerchantMenuCategory = z.infer<
	typeof UpdateMerchantMenuCategorySchema
>;

export const MerchantSchemaRegistries = {
	MerchantCategory: { schema: MerchantCategorySchema, strategy: "output" },
	MerchantStatus: { schema: MerchantStatusSchema, strategy: "output" },
	Merchant: { schema: MerchantSchema, strategy: "output" },
	MerchantMenu: { schema: MerchantMenuSchema, strategy: "output" },
	MerchantMenuCategory: {
		schema: MerchantMenuCategorySchema,
		strategy: "output",
	},
	MerchantOperatingHours: {
		schema: MerchantOperatingHoursSchema,
		strategy: "output",
	},
	MerchantKey: { schema: MerchantKeySchema, strategy: "input" },
	MerchantMenuKey: { schema: MerchantMenuKeySchema, strategy: "input" },
	MerchantMenuCategoryKey: {
		schema: MerchantMenuCategoryKeySchema,
		strategy: "input",
	},
	MerchantOperatingHoursKey: {
		schema: MerchantOperatingHoursKeySchema,
		strategy: "input",
	},
} satisfies SchemaRegistries;
