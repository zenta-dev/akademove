import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { createFileRoute, redirect } from "@tanstack/react-router";
import {
	AlertCircle,
	CheckCircle,
	Loader2,
	Pencil,
	XCircle,
} from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { DriverApprovalPageApprovalDialog } from "@/components/dialogs/driver-approval-page-approval-dialog";
import { DriverApprovalPageRejectionDialog } from "@/components/dialogs/driver-approval-page-rejection-dialog";
import { DriverDocumentReviewDialog } from "@/components/dialogs/driver-document-review-dialog";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Separator } from "@/components/ui/separator";
import { hasAccess } from "@/lib/actions";
import { orpcClient, orpcQuery } from "@/lib/orpc";
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
	const queryClient = useQueryClient();
	const [reviewModal, setReviewModal] = useState<{
		open: boolean;
		document?: "studentCard" | "driverLicense" | "vehicleRegistration";
		url?: string;
		status?: "PENDING" | "APPROVED" | "REJECTED";
		reason?: string | null;
	}>({ open: false });

	const [approvalDialogOpen, setApprovalDialogOpen] = useState(false);
	const [rejectionDialogOpen, setRejectionDialogOpen] = useState(false);

	// Fetch driver data
	const driverQuery = useQuery(
		orpcQuery.driver.get.queryOptions({
			input: { params: { id: driverId } },
		}),
	);

	// Fetch approval review
	const reviewQuery = useQuery(
		orpcQuery.driver.getReview.queryOptions({
			input: { params: { id: driverId } },
		}),
	);

	const driver = driverQuery.data?.body.data;
	const review = reviewQuery.data?.body.data;
	const isLoading = driverQuery.isPending || reviewQuery.isPending;

	// Quiz verification mutation
	const verifyQuizMutation = useMutation({
		mutationFn: async (quizVerified: boolean) => {
			const result = await orpcClient.driver.verifyQuiz({
				params: { id: driverId },
				body: { quizVerified },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (_, quizVerified) => {
			toast.success(
				quizVerified
					? "Quiz verified successfully"
					: "Quiz verification removed",
			);
			queryClient.invalidateQueries();
		},
		onError: (error) => {
			toast.error(`Failed to update quiz verification: ${error.message}`);
		},
	});

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
				bg: "bg-yellow-500/20",
			},
			APPROVED: {
				icon: CheckCircle,
				color: "text-green-600",
				bg: "bg-green-500/20",
			},
			REJECTED: { icon: XCircle, color: "text-red-600", bg: "bg-red-500/20" },
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
		<div className="mx-auto w-full max-w-3xl space-y-6 py-6">
			{/* Back button */}
			<Button
				variant="link"
				onClick={() => {
					history.back();
				}}
				className="px-0"
			>
				&larr; Back to Driver
			</Button>

			{/* Driver Info Header */}
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
							<div className="flex gap-2">
								<Button
									variant="outline"
									size="sm"
									onClick={() =>
										setReviewModal({
											open: true,
											document: "studentCard",
											url: driver.studentCard,
											status: review.studentCardStatus,
											reason: review.studentCardReason,
										})
									}
								>
									<Pencil className="mr-2 h-4 w-4" />
									Review
								</Button>
							</div>
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
							<div className="flex gap-2">
								<Button
									variant="outline"
									size="sm"
									onClick={() =>
										setReviewModal({
											open: true,
											document: "driverLicense",
											url: driver.driverLicense,
											status: review.driverLicenseStatus,
											reason: review.driverLicenseReason,
										})
									}
								>
									<Pencil className="mr-2 h-4 w-4" />
									Review
								</Button>
							</div>
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
							<div className="flex gap-2">
								<Button
									variant="outline"
									size="sm"
									onClick={() =>
										setReviewModal({
											open: true,
											document: "vehicleRegistration",
											url: driver.vehicleCertificate,
											status: review.vehicleRegistrationStatus,
											reason: review.vehicleRegistrationReason,
										})
									}
								>
									<Pencil className="mr-2 h-4 w-4" />
									Review
								</Button>
							</div>
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
					<div className="rounded-lg bg-blue-500/20 p-4">
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

					<div className="flex items-center gap-3 rounded-lg bg-gray-500/20 p-4">
						<Checkbox
							id="quiz-verified"
							checked={review.quizVerified}
							disabled={
								verifyQuizMutation.isPending || driver.quizStatus !== "PASSED"
							}
							onCheckedChange={(checked) => {
								verifyQuizMutation.mutate(checked === true);
							}}
						/>
						<Label
							htmlFor="quiz-verified"
							className="flex-1 cursor-pointer font-medium"
						>
							{verifyQuizMutation.isPending ? (
								<span className="flex items-center gap-2">
									<Loader2 className="h-4 w-4 animate-spin" />
									Updating...
								</span>
							) : review.quizVerified ? (
								"✓ Quiz Verified"
							) : (
								"Quiz verification pending"
							)}
						</Label>
						{driver.quizStatus !== "PASSED" && (
							<span className="text-muted-foreground text-sm">
								(Driver must pass quiz first)
							</span>
						)}
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
						<div className="rounded-lg border border-green-200 bg-green-500/20 p-4">
							<p className="font-medium text-green-800">
								✓ All requirements met. Driver can be approved.
							</p>
						</div>
					) : (
						<div className="rounded-lg border border-amber-200 bg-amber-500/20 p-4">
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

			{/* Document Review Dialog */}
			{reviewModal.document && reviewModal.url && (
				<DriverDocumentReviewDialog
					isOpen={reviewModal.open}
					onOpenChange={(open) => setReviewModal({ ...reviewModal, open })}
					driverId={driverId}
					document={reviewModal.document}
					documentUrl={reviewModal.url}
					currentStatus={reviewModal.status ?? "PENDING"}
					currentReason={reviewModal.reason}
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
