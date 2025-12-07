import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverApprovalSpec } from "./driver-approval-spec";

const { priv } = createORPCRouter(DriverApprovalSpec);

export const DriverApprovalHandler = priv.router({
	getReview: priv.getReview.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.driver.approval.getReview(params.id);

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
			const data = trimObjectValues(body);
			const result = await context.repo.driver.approval.updateDocumentStatus(
				params.id,
				data.document,
				data.status,
				data.reason,
				context,
			);

			return {
				status: 200,
				body: {
					message: "Document status updated successfully",
					data: result,
				},
			};
		},
	),

	verifyQuiz: priv.verifyQuiz.handler(
		async ({ context, input: { params, body } }) => {
			const result = await context.repo.driver.approval.verifyQuiz(
				params.id,
				body.quizVerified,
				context,
			);

			return {
				status: 200,
				body: {
					message: "Quiz verification updated successfully",
					data: result,
				},
			};
		},
	),

	submitApproval: priv.submitApproval.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			// Start transaction for approval
			const result = await context.svc.db.transaction(async () => {
				const approvalResult =
					await context.repo.driver.approval.submitApproval(
						params.id,
						data.reviewNotes,
						context,
					);

				// Get driver info for email
				const driver = await context.repo.driver.main.get(params.id);

				// Send approval email
				try {
					await context.svc.mail.sendDriverApprovalStatus({
						to: driver.user?.email || "",
						driverName: driver.user?.name || "Driver",
						status: "APPROVED",
					});
				} catch (error) {
					console.error(
						"[DriverApprovalHandler] Failed to send approval email:",
						error,
					);
					// Don't fail the request if email fails
				}

				return approvalResult;
			});

			return {
				status: 200,
				body: {
					message: m.server_driver_approved(),
					data: result,
				},
			};
		},
	),

	submitRejection: priv.submitRejection.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);

			// Start transaction for rejection
			const result = await context.svc.db.transaction(async () => {
				const rejectionResult =
					await context.repo.driver.approval.submitRejection(
						params.id,
						data.reason,
						context,
					);

				// Get driver info and approval details for email
				const driver = await context.repo.driver.main.get(params.id);
				const review = await context.repo.driver.approval.getReview(params.id);

				// Build rejection details from review
				const rejectionDetails: Record<string, string> = {};
				if (
					review.studentCardStatus === "REJECTED" &&
					review.studentCardReason
				) {
					rejectionDetails.studentCard = review.studentCardReason;
				}
				if (
					review.driverLicenseStatus === "REJECTED" &&
					review.driverLicenseReason
				) {
					rejectionDetails.driverLicense = review.driverLicenseReason;
				}
				if (
					review.vehicleRegistrationStatus === "REJECTED" &&
					review.vehicleRegistrationReason
				) {
					rejectionDetails.vehicleRegistration =
						review.vehicleRegistrationReason;
				}

				// Send rejection email
				try {
					await context.svc.mail.sendDriverApprovalStatus({
						to: driver.user?.email || "",
						driverName: driver.user?.name || "Driver",
						status: "REJECTED",
						reason: data.reason,
						rejectionDetails,
					});
				} catch (error) {
					console.error(
						"[DriverApprovalHandler] Failed to send rejection email:",
						error,
					);
					// Don't fail the request if email fails
				}

				return rejectionResult;
			});

			return {
				status: 200,
				body: {
					message: m.server_driver_rejected(),
					data: result,
				},
			};
		},
	),
});
