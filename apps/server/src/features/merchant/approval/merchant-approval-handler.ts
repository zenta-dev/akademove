import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
import { MerchantApprovalSpec } from "./merchant-approval-spec";

const { priv } = createORPCRouter(MerchantApprovalSpec);

export const MerchantApprovalHandler = priv.router({
	getReview: priv.getReview.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.merchant.approval.getReview(params.id);

		return {
			status: 200,
			body: {
				message: "Approval review retrieved successfully",
				data: result,
			},
		};
	}),

	updateDocumentStatus: priv.updateDocumentStatus.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result =
					await context.repo.merchant.approval.updateDocumentStatus(
						params.id,
						data.document,
						data.status,
						data.reason,
						context,
						{ tx },
					);

				return {
					status: 200,
					body: {
						message: "Document status updated successfully",
						data: result,
					},
				};
			});
		},
	),

	submitApproval: priv.submitApproval.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			// Start transaction for approval
			const result = await context.svc.db.transaction(async (tx) => {
				const approvalResult =
					await context.repo.merchant.approval.submitApproval(
						params.id,
						data.reviewNotes,
						context,
						{ tx },
					);

				// Get merchant info for email
				const merchant = await context.repo.merchant.main.get(params.id);

				// Send approval email
				try {
					await context.svc.mail.sendMerchantApprovalStatus({
						to: merchant.email,
						merchantName: merchant.name,
						status: "APPROVED",
					});
				} catch (error) {
					log.error(
						{ error, merchantId: params.id },
						"[MerchantApprovalHandler] Failed to send approval email",
					);
					// Don't fail the request if email fails
				}

				return approvalResult;
			});

			return {
				status: 200,
				body: {
					message: m.success_placeholder({ action: "Merchant approved" }),
					data: result,
				},
			};
		},
	),

	submitRejection: priv.submitRejection.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			// Start transaction for rejection
			const result = await context.svc.db.transaction(async (tx) => {
				const rejectionResult =
					await context.repo.merchant.approval.submitRejection(
						params.id,
						data.reason,
						context,
						{ tx },
					);

				// Get merchant info and approval details for email
				const merchant = await context.repo.merchant.main.get(params.id);
				const review = await context.repo.merchant.approval.getReview(
					params.id,
					{ tx },
				);

				// Build rejection details from review
				const rejectionDetails: Record<string, string> = {};
				if (
					review.businessDocumentStatus === "REJECTED" &&
					review.businessDocumentReason
				) {
					rejectionDetails.businessDocument = review.businessDocumentReason;
				}

				// Send rejection email
				try {
					await context.svc.mail.sendMerchantApprovalStatus({
						to: merchant.email,
						merchantName: merchant.name,
						status: "REJECTED",
						reason: data.reason,
						rejectionDetails,
					});
				} catch (error) {
					log.error(
						{ error, merchantId: params.id },
						"[MerchantApprovalHandler] Failed to send rejection email",
					);
					// Don't fail the request if email fails
				}

				return rejectionResult;
			});

			return {
				status: 200,
				body: {
					message: m.success_placeholder({ action: "Merchant rejected" }),
					data: result,
				},
			};
		},
	),
});
