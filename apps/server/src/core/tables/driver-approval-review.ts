import { relations } from "drizzle-orm";
import { boolean, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import {
	createAuditLogTable,
	DateModifier,
	index,
	pgEnum,
	pgTable,
	timestamp,
} from "./common";
import { driver } from "./driver";

export const approvalDocumentStatus = pgEnum("approval_document_status", [
	"PENDING",
	"APPROVED",
	"REJECTED",
]);

export const approvalStatus = pgEnum("driver_approval_status", [
	"PENDING",
	"APPROVED",
	"REJECTED",
]);

export const driverApprovalReview = pgTable(
	"driver_approval_reviews",
	{
		id: uuid().primaryKey(),
		driverId: uuid("driver_id")
			.notNull()
			.references(() => driver.id, { onDelete: "cascade" }),

		// Overall approval status
		status: approvalStatus().notNull().default("PENDING"),

		// Document Review Checklist
		studentCardStatus: approvalDocumentStatus("student_card_status")
			.notNull()
			.default("PENDING"),
		studentCardReason: text("student_card_reason"),

		driverLicenseStatus: approvalDocumentStatus("driver_license_status")
			.notNull()
			.default("PENDING"),
		driverLicenseReason: text("driver_license_reason"),

		vehicleRegistrationStatus: approvalDocumentStatus(
			"vehicle_registration_status",
		)
			.notNull()
			.default("PENDING"),
		vehicleRegistrationReason: text("vehicle_registration_reason"),

		// Quiz Verification
		quizVerified: boolean("quiz_verified").notNull().default(false),
		quizReviewedAt: timestamp("quiz_reviewed_at"),

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
		index("driver_approval_driver_id_idx").on(t.driverId),
		index("driver_approval_status_idx").on(t.status),
		index("driver_approval_reviewed_by_idx").on(t.reviewedBy),
		index("driver_approval_reviewed_at_idx").on(t.reviewedAt),
		index("driver_approval_driver_status_idx").on(t.driverId, t.status),
	],
);

export const driverApprovalReviewAuditLog = createAuditLogTable(
	"driver_approval_review" as const,
);

///
/// --- Relations --- ///
///
export const driverApprovalReviewRelations = relations(
	driverApprovalReview,
	({ one }) => ({
		driver: one(driver, {
			fields: [driverApprovalReview.driverId],
			references: [driver.id],
		}),
		reviewer: one(user, {
			fields: [driverApprovalReview.reviewedBy],
			references: [user.id],
		}),
	}),
);

export type DriverApprovalReviewDatabase =
	typeof driverApprovalReview.$inferSelect;
