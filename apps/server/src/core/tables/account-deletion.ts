import { relations } from "drizzle-orm";
import { text, uuid, varchar } from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	createAuditLogTable,
	index,
	nowFn,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";

export const accountDeletionStatus = pgEnum("account_deletion_status", [
	"PENDING",
	"REVIEWING",
	"APPROVED",
	"REJECTED",
	"COMPLETED",
]);

export const accountDeletionReason = pgEnum("account_deletion_reason", [
	"NO_LONGER_NEEDED",
	"PRIVACY_CONCERNS",
	"SWITCHING_SERVICE",
	"TOO_MANY_NOTIFICATIONS",
	"DIFFICULT_TO_USE",
	"POOR_EXPERIENCE",
	"OTHER",
]);

export const accountType = pgEnum("account_type", [
	"USER",
	"DRIVER",
	"MERCHANT",
]);

export const accountDeletion = pgTable(
	"account_deletions",
	{
		id: uuid().primaryKey(),
		fullName: varchar("full_name", { length: 255 }).notNull(),
		email: varchar({ length: 255 }).notNull(),
		phone: varchar({ length: 50 }).notNull(),
		accountType: accountType("account_type").notNull(),
		reason: accountDeletionReason().notNull(),
		additionalInfo: text("additional_info"),
		status: accountDeletionStatus().notNull().default("PENDING"),
		userId: text("user_id").references(() => user.id, {
			onDelete: "set null",
		}),
		reviewedById: text("reviewed_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
		reviewNotes: text("review_notes"),
		createdAt: timestamp("created_at").notNull().$defaultFn(nowFn),
		updatedAt: timestamp("updated_at")
			.notNull()
			.$defaultFn(nowFn)
			.$onUpdate(nowFn),
		reviewedAt: timestamp("reviewed_at"),
		completedAt: timestamp("completed_at"),
	},
	(t) => [
		index("account_deletion_email_idx").on(t.email),
		index("account_deletion_phone_idx").on(t.phone),
		index("account_deletion_user_id_idx").on(t.userId),
		index("account_deletion_status_idx").on(t.status),
		index("account_deletion_reviewed_by_id_idx").on(t.reviewedById),
		index("account_deletion_created_at_idx").on(t.createdAt),
		index("account_deletion_status_created_at_idx").on(t.status, t.createdAt),
		index("account_deletion_user_status_idx").on(t.userId, t.status),
	],
);

export const accountDeletionAuditLog = createAuditLogTable("account_deletion");

///
/// --- Relations --- ///
///
export const accountDeletionRelations = relations(
	accountDeletion,
	({ one }) => ({
		user: one(user, {
			fields: [accountDeletion.userId],
			references: [user.id],
		}),
		reviewedBy: one(user, {
			fields: [accountDeletion.reviewedById],
			references: [user.id],
		}),
	}),
);

export type AccountDeletionDatabase = typeof accountDeletion.$inferSelect;
