import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect } from "@tanstack/react-router";
import { AlertCircle, CheckCircle, Eye, Loader2, XCircle } from "lucide-react";
import { useState } from "react";
import { DriverApprovalPageApprovalDialog } from "@/components/dialogs/driver-approval-page-approval-dialog";
import { DriverApprovalPageRejectionDialog } from "@/components/dialogs/driver-approval-page-rejection-dialog";
import { DriverDocumentPreviewModal } from "@/components/modals/driver-document-preview-modal";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Separator } from "@/components/ui/separator";
import { hasAccess } from "@/lib/actions";
import { orpcQuery } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute(
	"/dash/operator/driver-approval/$driverId",
)({
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	head: () => ({ meta: [{ title: "Driver Approval Review" }] }),
	component: RouteComponent,
});

function RouteComponent() {
	const { driverId } = Route.useParams();
	const [previewModal, setPreviewModal] = useState<{
		open: boolean;
		document?: "studentCard" | "driverLicense" | "vehicleRegistration";
		url?: string;
	}>({ open: false });

	const [approvalDialogOpen, setApprovalDialogOpen] = useState(false);
	const [rejectionDialogOpen, setRejectionDialogOpen] = useState(false);

	// Fetch driver data
	const driverQuery = useQuery({
		queryKey: ["driver", driverId],
		queryFn: async () => {
			const result = await orpcQuery.driver.get.query({
				params: { id: driverId },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Fetch approval review
	const reviewQuery = useQuery({
		queryKey: ["driver-approval-review", driverId],
		queryFn: async () => {
			const result = await orpcQuery.driver.getReview.query({
				params: { id: driverId },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	const driver = driverQuery.data;
	const review = reviewQuery.data;
	const isLoading = driverQuery.isPending || reviewQuery.isPending;

	if (isLoading) {
		return (
			<div className="flex items-center justify-center py-12">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	if (!driver || !review) {
		return <div className="py-12 text-center">Driver not found</div>;
	}

	const allDocsApproved =
		review.studentCardStatus === "APPROVED" &&
		review.driverLicenseStatus === "APPROVED" &&
		review.vehicleRegistrationStatus === "APPROVED";

	const allRequirementsMet = allDocsApproved && review.quizVerified;

	const renderDocumentStatus = (
		status: "PENDING" | "APPROVED" | "REJECTED",
		reason?: string | null,
	) => {
		const statusConfig = {
			PENDING: {
				icon: AlertCircle,
				color: "text-yellow-600",
				bg: "bg-yellow-50",
			},
			APPROVED: {
				icon: CheckCircle,
				color: "text-green-600",
				bg: "bg-green-50",
			},
			REJECTED: { icon: XCircle, color: "text-red-600", bg: "bg-red-50" },
		};

		const config = statusConfig[status];
		const Icon = config.icon;

		return (
			<div className={cn("rounded-lg p-4", config.bg)}>
				<div className="mb-2 flex items-center gap-2">
					<Icon className={cn("h-5 w-5", config.color)} />
					<span className="font-medium text-sm">{status}</span>
				</div>
				{reason && (
					<p className="text-muted-foreground text-sm italic">
						Reason: {reason}
					</p>
				)}
			</div>
		);
	};

	return (
		<div className="space-y-6">
			<div>
				<h2 className="font-bold text-2xl">{driver.user?.name || "Driver"}</h2>
				<p className="text-muted-foreground">Student ID: {driver.studentId}</p>
			</div>

			{/* Document Checklist Section */}
			<Card>
				<CardHeader>
					<CardTitle className="flex items-center justify-between">
						<span>Document Review Checklist</span>
						<Badge variant={allDocsApproved ? "default" : "outline"}>
							{allDocsApproved ? "All Documents Approved" : "Documents Pending"}
						</Badge>
					</CardTitle>
				</CardHeader>
				<CardContent className="space-y-6">
					{/* Student Card */}
					<div className="space-y-2">
						<div className="flex items-center justify-between">
							<Label className="font-medium text-base">
								Student Card (ID Verification)
							</Label>
							<Button
								variant="outline"
								size="sm"
								onClick={() =>
									setPreviewModal({
										open: true,
										document: "studentCard",
										url: driver.studentCard,
									})
								}
							>
								<Eye className="mr-2 h-4 w-4" />
								View
							</Button>
						</div>
						{renderDocumentStatus(
							review.studentCardStatus,
							review.studentCardReason,
						)}
					</div>

					<Separator />

					{/* Driver License */}
					<div className="space-y-2">
						<div className="flex items-center justify-between">
							<Label className="font-medium text-base">
								Driver License (License Verification)
							</Label>
							<Button
								variant="outline"
								size="sm"
								onClick={() =>
									setPreviewModal({
										open: true,
										document: "driverLicense",
										url: driver.driverLicense,
									})
								}
							>
								<Eye className="mr-2 h-4 w-4" />
								View
							</Button>
						</div>
						{renderDocumentStatus(
							review.driverLicenseStatus,
							review.driverLicenseReason,
						)}
					</div>

					<Separator />

					{/* Vehicle Registration */}
					<div className="space-y-2">
						<div className="flex items-center justify-between">
							<Label className="font-medium text-base">
								Vehicle Registration (Vehicle Verification)
							</Label>
							<Button
								variant="outline"
								size="sm"
								onClick={() =>
									setPreviewModal({
										open: true,
										document: "vehicleRegistration",
										url: driver.vehicleCertificate,
									})
								}
							>
								<Eye className="mr-2 h-4 w-4" />
								View
							</Button>
						</div>
						{renderDocumentStatus(
							review.vehicleRegistrationStatus,
							review.vehicleRegistrationReason,
						)}
					</div>
				</CardContent>
			</Card>

			{/* Quiz Verification Section */}
			<Card>
				<CardHeader>
					<CardTitle>Driver Quiz Verification</CardTitle>
				</CardHeader>
				<CardContent className="space-y-4">
					<div className="rounded-lg bg-blue-50 p-4">
						<div className="mb-2 flex items-center justify-between">
							<Label className="font-medium">
								Quiz Status: {driver.quizStatus}
							</Label>
							{driver.quizScore && (
								<Badge variant="secondary">Score: {driver.quizScore}%</Badge>
							)}
						</div>
						<p className="text-muted-foreground text-sm">
							Completed:{" "}
							{driver.quizCompletedAt
								? new Date(driver.quizCompletedAt).toLocaleDateString()
								: "Not yet completed"}
						</p>
					</div>

					<div className="flex items-center gap-3 rounded-lg bg-gray-50 p-4">
						<Checkbox
							id="quiz-verified"
							checked={review.quizVerified}
							disabled
						/>
						<Label
							htmlFor="quiz-verified"
							className="flex-1 cursor-pointer font-medium"
						>
							{review.quizVerified
								? "✓ Quiz Verified"
								: "Quiz verification pending"}
						</Label>
					</div>
				</CardContent>
			</Card>

			{/* Review Summary & Actions */}
			<Card>
				<CardHeader>
					<CardTitle>Review Summary</CardTitle>
				</CardHeader>
				<CardContent className="space-y-4">
					{allRequirementsMet ? (
						<div className="rounded-lg border border-green-200 bg-green-50 p-4">
							<p className="font-medium text-green-800">
								✓ All requirements met. Driver can be approved.
							</p>
						</div>
					) : (
						<div className="rounded-lg border border-amber-200 bg-amber-50 p-4">
							<p className="font-medium text-amber-800">
								⚠ Complete all requirements before approving:
							</p>
							<ul className="mt-2 ml-4 list-disc text-amber-700 text-sm">
								{review.studentCardStatus !== "APPROVED" && (
									<li>Approve student card</li>
								)}
								{review.driverLicenseStatus !== "APPROVED" && (
									<li>Approve driver license</li>
								)}
								{review.vehicleRegistrationStatus !== "APPROVED" && (
									<li>Approve vehicle registration</li>
								)}
								{!review.quizVerified && <li>Verify quiz</li>}
							</ul>
						</div>
					)}

					<Separator />

					<div className="flex gap-3">
						<Button
							onClick={() => setApprovalDialogOpen(true)}
							disabled={!allRequirementsMet}
							className="flex-1"
						>
							Approve Application
						</Button>
						<Button
							onClick={() => setRejectionDialogOpen(true)}
							variant="destructive"
							className="flex-1"
						>
							Reject Application
						</Button>
					</div>
				</CardContent>
			</Card>

			{/* Document Preview Modal */}
			{previewModal.document && previewModal.url && (
				<DriverDocumentPreviewModal
					isOpen={previewModal.open}
					onOpenChange={(open) => setPreviewModal({ ...previewModal, open })}
					document={previewModal.document}
					documentUrl={previewModal.url}
				/>
			)}

			{/* Dialogs */}
			<DriverApprovalPageApprovalDialog
				driverId={driverId}
				isOpen={approvalDialogOpen}
				onOpenChange={setApprovalDialogOpen}
			/>

			<DriverApprovalPageRejectionDialog
				driverId={driverId}
				isOpen={rejectionDialogOpen}
				onOpenChange={setRejectionDialogOpen}
			/>
		</div>
	);
}
