import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useRouter } from "@tanstack/react-router";
import {
	AlertCircle,
	CheckCircle,
	Loader2,
	Pencil,
	XCircle,
} from "lucide-react";
import { useMemo, useState } from "react";
import { MerchantApprovalPageApprovalDialog } from "@/components/dialogs/merchant-approval-page-approval-dialog";
import { MerchantApprovalPageRejectionDialog } from "@/components/dialogs/merchant-approval-page-rejection-dialog";
import { MerchantDocumentReviewDialog } from "@/components/dialogs/merchant-document-review-dialog";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Separator } from "@/components/ui/separator";
import { hasAccess } from "@/lib/actions";
import { orpcQuery } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute(
	"/dash/admin/merchant-approval/$merchantId",
)({
	beforeLoad: async () => {
		const ok = await hasAccess(["ADMIN"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	head: () => ({ meta: [{ title: "Merchant Approval Review" }] }),
	component: RouteComponent,
});

function RouteComponent() {
	const router = useRouter();
	const { merchantId } = Route.useParams();
	const [reviewModal, setReviewModal] = useState<{
		open: boolean;
		document?: "businessDocument";
		url?: string;
		status?: "PENDING" | "APPROVED" | "REJECTED";
		reason?: string | null;
	}>({ open: false });

	const [approvalDialogOpen, setApprovalDialogOpen] = useState(false);
	const [rejectionDialogOpen, setRejectionDialogOpen] = useState(false);

	// Fetch merchant data
	const merchantQuery = useQuery(
		orpcQuery.merchant.get.queryOptions({
			input: { params: { id: merchantId } },
		}),
	);

	// Fetch approval review
	const reviewQuery = useQuery(
		orpcQuery.merchant.getReview.queryOptions({
			input: { params: { id: merchantId } },
		}),
	);

	const merchant = useMemo(
		() => merchantQuery.data?.body.data,
		[merchantQuery.data?.body.data],
	);
	const review = useMemo(
		() => reviewQuery.data?.body.data,
		[reviewQuery.data?.body.data],
	);
	const isLoading = useMemo(
		() => merchantQuery.isPending || reviewQuery.isPending,
		[merchantQuery.isPending, reviewQuery.isPending],
	);

	if (isLoading) {
		return (
			<div className="flex items-center justify-center py-12">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	if (!merchant || !review) {
		return <div className="py-12 text-center">Merchant not found</div>;
	}

	const allDocsApproved = review.businessDocumentStatus === "APPROVED";
	const allRequirementsMet = allDocsApproved;

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
				&larr; Back to Merchant
			</Button>

			{/* Merchant Info Header */}
			<div>
				<h2 className="font-bold text-2xl">{merchant.name}</h2>
				<p className="text-muted-foreground">Email: {merchant.email}</p>
				<p className="text-muted-foreground">Category: {merchant.category}</p>
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
					{/* Business Document */}
					<div className="space-y-2">
						<div className="flex items-center justify-between">
							<Label className="font-medium text-base">
								Business Document (Business Verification)
							</Label>
							<div className="flex gap-2">
								<Button
									variant="outline"
									size="sm"
									disabled={!merchant.document}
									onClick={() =>
										setReviewModal({
											open: true,
											document: "businessDocument",
											url: merchant.document ?? undefined,
											status: review.businessDocumentStatus,
											reason: review.businessDocumentReason,
										})
									}
								>
									<Pencil className="mr-2 h-4 w-4" />
									Review
								</Button>
							</div>
						</div>
						{merchant.document ? (
							renderDocumentStatus(
								review.businessDocumentStatus,
								review.businessDocumentReason,
							)
						) : (
							<div className="rounded-lg bg-gray-500/20 p-4">
								<p className="text-muted-foreground text-sm">
									No business document uploaded
								</p>
							</div>
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
								All requirements met. Merchant can be approved.
							</p>
						</div>
					) : (
						<div className="rounded-lg border border-amber-200 bg-amber-500/20 p-4">
							<p className="font-medium text-amber-800">
								Complete all requirements before approving:
							</p>
							<ul className="mt-2 ml-4 list-disc text-amber-700 text-sm">
								{review.businessDocumentStatus !== "APPROVED" && (
									<li>Approve business document</li>
								)}
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
				<MerchantDocumentReviewDialog
					isOpen={reviewModal.open}
					onOpenChange={(open: boolean) =>
						setReviewModal({ ...reviewModal, open })
					}
					merchantId={merchantId}
					document={reviewModal.document}
					documentUrl={reviewModal.url}
					currentStatus={reviewModal.status ?? "PENDING"}
					currentReason={reviewModal.reason}
				/>
			)}

			{/* Dialogs */}
			<MerchantApprovalPageApprovalDialog
				merchantId={merchantId}
				isOpen={approvalDialogOpen}
				onOpenChange={setApprovalDialogOpen}
				onSuccess={() => {
					router.navigate({
						to: "/dash/admin/merchants",
						search: {
							order: "desc",
							mode: "cursor",
							page: 1,
							limit: 11,
						},
					});
				}}
			/>

			<MerchantApprovalPageRejectionDialog
				merchantId={merchantId}
				isOpen={rejectionDialogOpen}
				onOpenChange={setRejectionDialogOpen}
			/>
		</div>
	);
}
