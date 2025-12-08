import { oc } from "@orpc/contract";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const MerchantApprovalDocumentStatusSchema = z.enum([
	"PENDING",
	"APPROVED",
	"REJECTED",
]);
export type MerchantApprovalDocumentStatus = z.infer<
	typeof MerchantApprovalDocumentStatusSchema
>;

export const MerchantApprovalReviewSchema = z.object({
	id: z.uuid(),
	merchantId: z.uuid(),
	status: z.enum(["PENDING", "APPROVED", "REJECTED"]),
	businessDocumentStatus: MerchantApprovalDocumentStatusSchema,
	businessDocumentReason: z.string().nullable(),
	reviewedBy: z.string().nullable(),
	reviewedAt: z.date().nullable(),
	reviewNotes: z.string().nullable(),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export type MerchantApprovalReview = z.infer<
	typeof MerchantApprovalReviewSchema
>;

export const UpdateDocumentStatusSchema = z.object({
	document: z.enum(["businessDocument"]),
	status: z.enum(["APPROVED", "REJECTED"]),
	reason: z.string().optional(),
});

export type UpdateDocumentStatus = z.infer<typeof UpdateDocumentStatusSchema>;

export const SubmitApprovalSchema = z.object({
	reviewNotes: z.string().optional(),
});

export type SubmitApproval = z.infer<typeof SubmitApprovalSchema>;

export const SubmitRejectionSchema = z.object({
	reason: z.string().min(1, "Rejection reason is required"),
});

export type SubmitRejection = z.infer<typeof SubmitRejectionSchema>;

export const MerchantApprovalSpec = {
	getReview: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "GET",
			path: "/{id}/approval-review",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				MerchantApprovalReviewSchema,
				"Approval review retrieved successfully",
			),
		),

	updateDocumentStatus: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/{id}/approval-review/update-document",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: UpdateDocumentStatusSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantApprovalReviewSchema,
				"Document status updated successfully",
			),
		),

	submitApproval: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/{id}/approval-review/submit-approval",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: SubmitApprovalSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantApprovalReviewSchema,
				"Merchant approved successfully",
			),
		),

	submitRejection: oc
		.route({
			tags: [FEATURE_TAGS.MERCHANT],
			method: "POST",
			path: "/{id}/approval-review/submit-rejection",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: SubmitRejectionSchema,
			}),
		)
		.output(
			createSuccesSchema(
				MerchantApprovalReviewSchema,
				"Merchant rejected successfully",
			),
		),
};
