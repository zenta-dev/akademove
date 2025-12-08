import { m } from "@repo/i18n";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { ORPCContext, WithTx } from "@/core/interface";
import { AuditService } from "@/core/services/audit";
import { tables } from "@/core/services/db";
import { log } from "@/utils";
import type {
	ApprovalDocumentStatus,
	DriverApprovalReview,
} from "./driver-approval-spec";

export class DriverApprovalRepository extends BaseRepository {
	/**
	 * Get or create approval review for a driver
	 */
	async getReview(
		driverId: string,
		opts?: WithTx,
	): Promise<DriverApprovalReview> {
		try {
			let review = await (
				opts?.tx ?? this.db
			).query.driverApprovalReview.findFirst({
				where: (f, op) => op.eq(f.driverId, driverId),
			});

			if (!review) {
				// Create a new approval review if it doesn't exist
				const [created] = await (opts?.tx ?? this.db)
					.insert(tables.driverApprovalReview)
					.values({
						id: v7(),
						driverId,
					})
					.returning();

				review = created;
			}

			return this.composeEntity(review);
		} catch (error) {
			throw this.handleError(error, "getReview");
		}
	}

	/**
	 * Update document status in approval review
	 */
	async updateDocumentStatus(
		driverId: string,
		document: "studentCard" | "driverLicense" | "vehicleRegistration",
		status: ApprovalDocumentStatus,
		reason: string | undefined,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<DriverApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(driverId, opts);

			const updateData: Record<string, unknown> = {};

			if (document === "studentCard") {
				updateData.studentCardStatus = status;
				updateData.studentCardReason =
					status === "REJECTED" ? reason || null : null;
			} else if (document === "driverLicense") {
				updateData.driverLicenseStatus = status;
				updateData.driverLicenseReason =
					status === "REJECTED" ? reason || null : null;
			} else {
				updateData.vehicleRegistrationStatus = status;
				updateData.vehicleRegistrationReason =
					status === "REJECTED" ? reason || null : null;
			}

			updateData.updatedAt = new Date();

			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.driverApprovalReview)
				.set(updateData)
				.where(eq(tables.driverApprovalReview.driverId, driverId))
				.returning();

			// Log audit
			await AuditService.logChange(
				{
					tableName: "driver_approval_review" as const,
					recordId: review.id,
					operation: "UPDATE",
					oldData: {
						[document]: review[`${document}Status` as keyof typeof review],
					},
					newData: { [document]: status },
					updatedById: context.user.id,
					metadata: {
						reason: `Document ${document} marked as ${status}${reason ? `: ${reason}` : ""}`,
						...AuditService.extractMetadata(context),
					},
				},
				context,
				opts,
			);

			log.info(
				{ driverId, document, status },
				"[DriverApprovalRepository] Document status updated",
			);

			return this.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "updateDocumentStatus");
		}
	}

	/**
	 * Verify quiz for driver approval
	 */
	async verifyQuiz(
		driverId: string,
		quizVerified: boolean,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<DriverApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(driverId, opts);

			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.driverApprovalReview)
				.set({
					quizVerified,
					quizReviewedAt: quizVerified ? new Date() : null,
					updatedAt: new Date(),
				})
				.where(eq(tables.driverApprovalReview.driverId, driverId))
				.returning();

			// Log audit
			await AuditService.logChange(
				{
					tableName: "driver_approval_review" as const,
					recordId: review.id,
					operation: "UPDATE",
					oldData: { quizVerified: review.quizVerified },
					newData: { quizVerified },
					updatedById: context.user.id,
					metadata: {
						reason: `Quiz ${quizVerified ? "verified" : "unverified"}`,
						...AuditService.extractMetadata(context),
					},
				},
				context,
				opts,
			);

			log.info(
				{ driverId, quizVerified },
				"[DriverApprovalRepository] Quiz verification updated",
			);

			return this.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "verifyQuiz");
		}
	}

	/**
	 * Submit approval - validates all documents and quiz, then approves driver
	 */
	async submitApproval(
		driverId: string,
		reviewNotes: string | undefined,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<DriverApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(driverId, opts);

			// Validate all documents are approved
			if (
				review.studentCardStatus !== "APPROVED" ||
				review.driverLicenseStatus !== "APPROVED" ||
				review.vehicleRegistrationStatus !== "APPROVED"
			) {
				throw new RepositoryError(
					"All documents must be approved before submitting approval",
					{ code: "BAD_REQUEST" },
				);
			}

			// Validate quiz is verified
			if (!review.quizVerified) {
				throw new RepositoryError(
					"Quiz must be verified before approving driver",
					{ code: "BAD_REQUEST" },
				);
			}

			// Get the driver
			const driver = await (opts?.tx ?? this.db).query.driver.findFirst({
				where: (f, op) => op.eq(f.id, driverId),
			});

			if (!driver) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			// Check driver status
			// if (driver.status !== "PENDING") {
			// 	throw new RepositoryError(
			// 		"Driver must be in PENDING status to approve",
			// 		{ code: "BAD_REQUEST" },
			// 	);
			// }

			// Check quiz status
			if (driver.quizStatus !== "PASSED") {
				throw new RepositoryError(
					"Driver must have passed the quiz before approval",
					{ code: "BAD_REQUEST" },
				);
			}

			// Update approval review
			const [updatedReview] = await (opts?.tx ?? this.db)
				.update(tables.driverApprovalReview)
				.set({
					status: "APPROVED",
					reviewedBy: context.user.id,
					reviewedAt: new Date(),
					reviewNotes: reviewNotes || null,
					updatedAt: new Date(),
				})
				.where(eq(tables.driverApprovalReview.driverId, driverId))
				.returning();

			// Update driver status
			await (opts?.tx ?? this.db)
				.update(tables.driver)
				.set({ status: "APPROVED" })
				.where(eq(tables.driver.id, driverId));

			// Log audit
			await AuditService.logChange(
				{
					tableName: "driver_approval_review" as const,
					recordId: review.id,
					operation: "UPDATE",
					oldData: { status: "PENDING" },
					newData: { status: "APPROVED" },
					updatedById: context.user.id,
					metadata: {
						reason: "Driver approved - all documents verified",
						...AuditService.extractMetadata(context),
					},
				},
				context,
				opts,
			);

			log.info(
				{ driverId, reviewedBy: context.user.id },
				"[DriverApprovalRepository] Driver approved",
			);

			return this.composeEntity(updatedReview);
		} catch (error) {
			throw this.handleError(error, "submitApproval");
		}
	}

	/**
	 * Submit rejection - rejects driver application
	 */
	async submitRejection(
		driverId: string,
		reason: string,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<DriverApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(driverId, opts);

			// Get the driver
			const driver = await (opts?.tx ?? this.db).query.driver.findFirst({
				where: (f, op) => op.eq(f.id, driverId),
			});

			if (!driver) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			// Check driver status
			if (driver.status !== "PENDING") {
				throw new RepositoryError(
					"Driver must be in PENDING status to reject",
					{ code: "BAD_REQUEST" },
				);
			}

			// Update approval review
			const [updatedReview] = await (opts?.tx ?? this.db)
				.update(tables.driverApprovalReview)
				.set({
					status: "REJECTED",
					reviewedBy: context.user.id,
					reviewedAt: new Date(),
					reviewNotes: reason,
					updatedAt: new Date(),
				})
				.where(eq(tables.driverApprovalReview.driverId, driverId))
				.returning();

			// Update driver status
			await (opts?.tx ?? this.db)
				.update(tables.driver)
				.set({ status: "REJECTED" })
				.where(eq(tables.driver.id, driverId));

			// Log audit
			await AuditService.logChange(
				{
					tableName: "driver_approval_review" as const,
					recordId: review.id,
					operation: "UPDATE",
					oldData: { status: "PENDING" },
					newData: { status: "REJECTED" },
					updatedById: context.user.id,
					metadata: {
						reason: `Driver rejected: ${reason}`,
						...AuditService.extractMetadata(context),
					},
				},
				context,
				opts,
			);

			log.info(
				{ driverId, reason, reviewedBy: context.user.id },
				"[DriverApprovalRepository] Driver rejected",
			);

			return this.composeEntity(updatedReview);
		} catch (error) {
			throw this.handleError(error, "submitRejection");
		}
	}

	private composeEntity(data: unknown): DriverApprovalReview {
		return data as DriverApprovalReview;
	}
}
