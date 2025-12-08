import { relations } from "drizzle-orm";
import { text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	createAuditLogTable,
	DateModifier,
	index,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";
import { merchant } from "./merchant";

export const merchantApprovalDocumentStatus = pgEnum(
	"merchant_approval_document_status",
	["PENDING", "APPROVED", "REJECTED"],
);

export const merchantApprovalStatus = pgEnum("merchant_approval_status", [
	"PENDING",
	"APPROVED",
	"REJECTED",
]);

export const merchantApprovalReview = pgTable(
	"merchant_approval_reviews",
	{
		id: uuid().primaryKey(),
		merchantId: uuid("merchant_id")
			.notNull()
			.references(() => merchant.id, { onDelete: "cascade" }),

		// Overall approval status
		status: merchantApprovalStatus().notNull().default("PENDING"),

		// Document Review Checklist
		businessDocumentStatus: merchantApprovalDocumentStatus(
			"business_document_status",
		)
			.notNull()
			.default("PENDING"),
		businessDocumentReason: text("business_document_reason"),

		// Review Info
		reviewedBy: text("reviewed_by_id").references(() => user.id, {
			onDelete: "set null",
		}),
		reviewedAt: timestamp("reviewed_at"),
		reviewNotes: text("review_notes"),

		// Timestamps
		...DateModifier,
	},
	(t) => [
		index("merchant_approval_merchant_id_idx").on(t.merchantId),
		index("merchant_approval_status_idx").on(t.status),
		index("merchant_approval_reviewed_by_idx").on(t.reviewedBy),
		index("merchant_approval_reviewed_at_idx").on(t.reviewedAt),
		index("merchant_approval_merchant_status_idx").on(t.merchantId, t.status),
	],
);

export const merchantApprovalReviewAuditLog = createAuditLogTable(
	"merchant_approval_review" as const,
);

///
/// --- Relations --- ///
///
export const merchantApprovalReviewRelations = relations(
	merchantApprovalReview,
	({ one }) => ({
		merchant: one(merchant, {
			fields: [merchantApprovalReview.merchantId],
			references: [merchant.id],
		}),
		reviewer: one(user, {
			fields: [merchantApprovalReview.reviewedBy],
			references: [user.id],
		}),
	}),
);

export type MerchantApprovalReviewDatabase =
	typeof merchantApprovalReview.$inferSelect;
