import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const AccountDeletionStatusSchema = z.enum([
	"PENDING",
	"REVIEWING",
	"APPROVED",
	"REJECTED",
	"COMPLETED",
] as const);
export type AccountDeletionStatus = z.infer<typeof AccountDeletionStatusSchema>;

export const AccountDeletionReasonSchema = z.enum([
	"NO_LONGER_NEEDED",
	"PRIVACY_CONCERNS",
	"SWITCHING_SERVICE",
	"TOO_MANY_NOTIFICATIONS",
	"DIFFICULT_TO_USE",
	"POOR_EXPERIENCE",
	"OTHER",
] as const);
export type AccountDeletionReason = z.infer<typeof AccountDeletionReasonSchema>;

export const AccountTypeSchema = z.enum([
	"USER",
	"DRIVER",
	"MERCHANT",
] as const);
export type AccountType = z.infer<typeof AccountTypeSchema>;

export const AccountDeletionSchema = z.object({
	id: z.uuid(),
	fullName: z.string().min(1).max(255),
	email: z.email({ message: "Invalid email address" }),
	phone: z.string().min(1).max(50),
	accountType: AccountTypeSchema,
	reason: AccountDeletionReasonSchema,
	additionalInfo: z.string().optional(),
	status: AccountDeletionStatusSchema,
	userId: z.uuid().optional(),
	reviewedById: z.uuid().optional(),
	reviewNotes: z.string().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
	reviewedAt: DateSchema.optional(),
	completedAt: DateSchema.optional(),
});
export type AccountDeletion = z.infer<typeof AccountDeletionSchema>;

export const AccountDeletionKeySchema = extractSchemaKeysAsEnum(
	AccountDeletionSchema,
);

export const InsertAccountDeletionSchema = AccountDeletionSchema.omit({
	id: true,
	status: true,
	reviewedById: true,
	reviewNotes: true,
	createdAt: true,
	updatedAt: true,
	reviewedAt: true,
	completedAt: true,
}).extend({
	userId: z.uuid().optional(),
});
export type InsertAccountDeletion = z.infer<typeof InsertAccountDeletionSchema>;

export const UpdateAccountDeletionSchema = AccountDeletionSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
})
	.partial()
	.extend({
		reviewedAt: DateSchema.optional(),
		completedAt: DateSchema.optional(),
	});
export type UpdateAccountDeletion = z.infer<typeof UpdateAccountDeletionSchema>;

export const AccountDeletionSchemaRegistries = {
	AccountDeletionStatus: {
		schema: AccountDeletionStatusSchema,
		strategy: "output",
	},
	AccountDeletionReason: {
		schema: AccountDeletionReasonSchema,
		strategy: "output",
	},
	AccountType: { schema: AccountTypeSchema, strategy: "output" },
	AccountDeletion: { schema: AccountDeletionSchema, strategy: "output" },
	InsertAccountDeletion: {
		schema: InsertAccountDeletionSchema,
		strategy: "input",
	},
	UpdateAccountDeletion: {
		schema: UpdateAccountDeletionSchema,
		strategy: "input",
	},
	AccountDeletionKey: { schema: AccountDeletionKeySchema, strategy: "input" },
} satisfies SchemaRegistries;
