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
	MerchantApprovalDocumentStatus,
	MerchantApprovalReview,
} from "./merchant-approval-spec";

export class MerchantApprovalRepository extends BaseRepository {
	/**
	 * Get or create approval review for a merchant
	 */
	async getReview(
		merchantId: string,
		opts?: WithTx,
	): Promise<MerchantApprovalReview> {
		try {
			let review = await (
				opts?.tx ?? this.db
			).query.merchantApprovalReview.findFirst({
				where: (f, op) => op.eq(f.merchantId, merchantId),
			});

			if (!review) {
				// Create a new approval review if it doesn't exist
				const [created] = await (opts?.tx ?? this.db)
					.insert(tables.merchantApprovalReview)
					.values({
						id: v7(),
						merchantId,
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
		merchantId: string,
		document: "businessDocument",
		status: MerchantApprovalDocumentStatus,
		reason: string | undefined,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<MerchantApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(merchantId, opts);

			const updateData: Record<string, unknown> = {};

			if (document === "businessDocument") {
				updateData.businessDocumentStatus = status;
				updateData.businessDocumentReason =
					status === "REJECTED" ? reason || null : null;
			}

			updateData.updatedAt = new Date();

			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.merchantApprovalReview)
				.set(updateData)
				.where(eq(tables.merchantApprovalReview.merchantId, merchantId))
				.returning();

			// Log audit
			await AuditService.logChange(
				{
					tableName: "merchant_approval_review" as const,
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
				{ merchantId, document, status },
				"[MerchantApprovalRepository] Document status updated",
			);

			return this.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "updateDocumentStatus");
		}
	}

	/**
	 * Submit approval - validates all documents, then approves merchant
	 */
	async submitApproval(
		merchantId: string,
		reviewNotes: string | undefined,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<MerchantApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(merchantId, opts);

			// Validate all documents are approved
			if (review.businessDocumentStatus !== "APPROVED") {
				throw new RepositoryError(
					"All documents must be approved before submitting approval",
					{ code: "BAD_REQUEST" },
				);
			}

			// Get the merchant
			const merchantRecord = await (
				opts?.tx ?? this.db
			).query.merchant.findFirst({
				where: (f, op) => op.eq(f.id, merchantId),
			});

			if (!merchantRecord) {
				throw new RepositoryError(m.error_merchant_not_found(), {
					code: "NOT_FOUND",
				});
			}

			// Check merchant status
			if (merchantRecord.status !== "PENDING") {
				throw new RepositoryError(
					"Merchant must be in PENDING status to approve",
					{ code: "BAD_REQUEST" },
				);
			}

			// Update approval review
			const [updatedReview] = await (opts?.tx ?? this.db)
				.update(tables.merchantApprovalReview)
				.set({
					status: "APPROVED",
					reviewedBy: context.user.id,
					reviewedAt: new Date(),
					reviewNotes: reviewNotes || null,
					updatedAt: new Date(),
				})
				.where(eq(tables.merchantApprovalReview.merchantId, merchantId))
				.returning();

			// Update merchant status to APPROVED and isActive to true
			await (opts?.tx ?? this.db)
				.update(tables.merchant)
				.set({ status: "APPROVED", isActive: true })
				.where(eq(tables.merchant.id, merchantId));

			// Log audit
			await AuditService.logChange(
				{
					tableName: "merchant_approval_review" as const,
					recordId: review.id,
					operation: "UPDATE",
					oldData: { status: "PENDING" },
					newData: { status: "APPROVED" },
					updatedById: context.user.id,
					metadata: {
						reason: "Merchant approved - all documents verified",
						...AuditService.extractMetadata(context),
					},
				},
				context,
				opts,
			);

			log.info(
				{ merchantId, reviewedBy: context.user.id },
				"[MerchantApprovalRepository] Merchant approved",
			);

			return this.composeEntity(updatedReview);
		} catch (error) {
			throw this.handleError(error, "submitApproval");
		}
	}

	/**
	 * Submit rejection - rejects merchant application
	 */
	async submitRejection(
		merchantId: string,
		reason: string,
		context: ORPCContext,
		opts?: WithTx,
	): Promise<MerchantApprovalReview> {
		try {
			if (!context.user) {
				throw new RepositoryError("User context is required", {
					code: "UNAUTHORIZED",
				});
			}

			const review = await this.getReview(merchantId, opts);

			// Get the merchant
			const merchantRecord = await (
				opts?.tx ?? this.db
			).query.merchant.findFirst({
				where: (f, op) => op.eq(f.id, merchantId),
			});

			if (!merchantRecord) {
				throw new RepositoryError(m.error_merchant_not_found(), {
					code: "NOT_FOUND",
				});
			}

			// Check merchant status
			if (merchantRecord.status !== "PENDING") {
				throw new RepositoryError(
					"Merchant must be in PENDING status to reject",
					{ code: "BAD_REQUEST" },
				);
			}

			// Update approval review
			const [updatedReview] = await (opts?.tx ?? this.db)
				.update(tables.merchantApprovalReview)
				.set({
					status: "REJECTED",
					reviewedBy: context.user.id,
					reviewedAt: new Date(),
					reviewNotes: reason,
					updatedAt: new Date(),
				})
				.where(eq(tables.merchantApprovalReview.merchantId, merchantId))
				.returning();

			// Update merchant status to REJECTED
			await (opts?.tx ?? this.db)
				.update(tables.merchant)
				.set({ status: "REJECTED" })
				.where(eq(tables.merchant.id, merchantId));

			// Log audit
			await AuditService.logChange(
				{
					tableName: "merchant_approval_review" as const,
					recordId: review.id,
					operation: "UPDATE",
					oldData: { status: "PENDING" },
					newData: { status: "REJECTED" },
					updatedById: context.user.id,
					metadata: {
						reason: `Merchant rejected: ${reason}`,
						...AuditService.extractMetadata(context),
					},
				},
				context,
				opts,
			);

			log.info(
				{ merchantId, reason, reviewedBy: context.user.id },
				"[MerchantApprovalRepository] Merchant rejected",
			);

			return this.composeEntity(updatedReview);
		} catch (error) {
			throw this.handleError(error, "submitRejection");
		}
	}

	private composeEntity(data: unknown): MerchantApprovalReview {
		return data as MerchantApprovalReview;
	}
}
