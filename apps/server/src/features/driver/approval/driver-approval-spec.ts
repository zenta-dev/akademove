import { oc } from "@orpc/contract";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const ApprovalDocumentStatusSchema = z.enum([
	"PENDING",
	"APPROVED",
	"REJECTED",
]);
export type ApprovalDocumentStatus = z.infer<
	typeof ApprovalDocumentStatusSchema
>;

export const DriverApprovalReviewSchema = z.object({
	id: z.uuid(),
	driverId: z.uuid(),
	status: z.enum(["PENDING", "APPROVED", "REJECTED"]),
	studentCardStatus: ApprovalDocumentStatusSchema,
	studentCardReason: z.string().nullable(),
	driverLicenseStatus: ApprovalDocumentStatusSchema,
	driverLicenseReason: z.string().nullable(),
	vehicleRegistrationStatus: ApprovalDocumentStatusSchema,
	vehicleRegistrationReason: z.string().nullable(),
	quizVerified: z.boolean(),
	quizReviewedAt: z.coerce.date().nullable(),
	reviewedBy: z.string().nullable(),
	reviewedAt: z.coerce.date().nullable(),
	reviewNotes: z.string().nullable(),
	createdAt: z.coerce.date(),
	updatedAt: z.coerce.date(),
});

export type DriverApprovalReview = z.infer<typeof DriverApprovalReviewSchema>;

export const UpdateDocumentStatusSchema = z.object({
	document: z.enum(["studentCard", "driverLicense", "vehicleRegistration"]),
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

export const VerifyQuizSchema = z.object({
	quizVerified: z.boolean(),
});

export type VerifyQuiz = z.infer<typeof VerifyQuizSchema>;

export const DriverApprovalSpec = {
	getReview: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "GET",
			path: "/{id}/approval-review",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.string() }) }))
		.output(
			createSuccesSchema(
				DriverApprovalReviewSchema,
				"Approval review retrieved successfully",
			),
		),

	updateDocumentStatus: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
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
				DriverApprovalReviewSchema,
				"Document status updated successfully",
			),
		),

	verifyQuiz: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
			method: "POST",
			path: "/{id}/approval-review/verify-quiz",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.string() }),
				body: VerifyQuizSchema,
			}),
		)
		.output(
			createSuccesSchema(
				DriverApprovalReviewSchema,
				"Quiz verification updated successfully",
			),
		),

	submitApproval: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
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
				DriverApprovalReviewSchema,
				"Driver approved successfully",
			),
		),

	submitRejection: oc
		.route({
			tags: [FEATURE_TAGS.DRIVER],
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
				DriverApprovalReviewSchema,
				"Driver rejected successfully",
			),
		),
};
