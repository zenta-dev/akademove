import { useMutation, useQueryClient } from "@tanstack/react-query";
import { CheckCircle, Loader2, XCircle } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient } from "@/lib/orpc";

type DocumentType = "studentCard" | "driverLicense" | "vehicleRegistration";

interface DriverDocumentReviewDialogProps {
	isOpen: boolean;
	onOpenChange: (open: boolean) => void;
	driverId: string;
	document: DocumentType;
	documentUrl: string;
	currentStatus: "PENDING" | "APPROVED" | "REJECTED";
	currentReason?: string | null;
}

const DOCUMENT_LABELS: Record<DocumentType, string> = {
	studentCard: "Student Card",
	driverLicense: "Driver License",
	vehicleRegistration: "Vehicle Registration",
};

export const DriverDocumentReviewDialog = ({
	isOpen,
	onOpenChange,
	driverId,
	document,
	documentUrl,
	currentStatus,
	currentReason,
}: DriverDocumentReviewDialogProps) => {
	const queryClient = useQueryClient();
	const [reason, setReason] = useState(currentReason ?? "");
	const [action, setAction] = useState<"APPROVED" | "REJECTED" | null>(null);

	const isPdf = documentUrl.toLowerCase().endsWith(".pdf");

	const updateDocumentMutation = useMutation({
		mutationFn: async ({
			status,
			reason,
		}: {
			status: "APPROVED" | "REJECTED";
			reason?: string;
		}) => {
			const result = await orpcClient.driver.updateDocumentStatus({
				params: { id: driverId },
				body: {
					document,
					status,
					reason: status === "REJECTED" ? reason : undefined,
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (_, variables) => {
			toast.success(
				`${DOCUMENT_LABELS[document]} ${variables.status === "APPROVED" ? "approved" : "rejected"} successfully`,
			);
			queryClient.invalidateQueries();
			onOpenChange(false);
			setReason("");
			setAction(null);
		},
		onError: (error) => {
			toast.error(`Failed to update document status: ${error.message}`);
		},
	});

	const handleApprove = () => {
		setAction("APPROVED");
		updateDocumentMutation.mutate({ status: "APPROVED" });
	};

	const handleReject = () => {
		if (!reason.trim()) {
			toast.error("Please provide a reason for rejection");
			return;
		}
		setAction("REJECTED");
		updateDocumentMutation.mutate({
			status: "REJECTED",
			reason: reason.trim(),
		});
	};

	const handleClose = () => {
		onOpenChange(false);
		setReason("");
		setAction(null);
	};

	return (
		<Dialog open={isOpen} onOpenChange={handleClose}>
			<DialogContent className="max-h-[95vh] max-w-7xl">
				<DialogHeader>
					<DialogTitle>Review {DOCUMENT_LABELS[document]}</DialogTitle>
					<DialogDescription>
						Review the document and approve or reject it. If rejecting, please
						provide a reason.
					</DialogDescription>
				</DialogHeader>

				{/* Document Preview */}
				<div className="relative h-[50vh] w-full overflow-auto rounded-lg border bg-muted/50">
					{isPdf ? (
						<iframe
							src={documentUrl}
							className="h-full w-full border-0"
							title={DOCUMENT_LABELS[document]}
						/>
					) : (
						<img
							src={documentUrl}
							alt={DOCUMENT_LABELS[document]}
							className="h-full w-full object-contain"
						/>
					)}
				</div>

				{/* Current Status */}
				{currentStatus !== "PENDING" && (
					<div
						className={`rounded-lg p-3 ${
							currentStatus === "APPROVED"
								? "bg-green-500/20 text-green-700"
								: "bg-red-500/20 text-red-700"
						}`}
					>
						<p className="font-medium text-sm">
							Current Status: {currentStatus}
							{currentStatus === "REJECTED" && currentReason && (
								<span className="ml-2 font-normal">
									- Reason: {currentReason}
								</span>
							)}
						</p>
					</div>
				)}

				{/* Rejection Reason Input */}
				<div className="space-y-2">
					<Label htmlFor="rejection-reason">
						Rejection Reason (required if rejecting)
					</Label>
					<Textarea
						id="rejection-reason"
						placeholder="Enter reason for rejection (e.g., document is blurry, expired, etc.)"
						value={reason}
						onChange={(e) => setReason(e.target.value)}
						rows={2}
					/>
				</div>

				<DialogFooter className="flex-wrap gap-2 sm:flex-row">
					<Button
						variant="outline"
						onClick={() => window.open(documentUrl, "_blank")}
					>
						Open Full Size
					</Button>
					<div className="flex flex-1 justify-end gap-2">
						<Button variant="outline" onClick={handleClose}>
							Cancel
						</Button>
						<Button
							variant="destructive"
							onClick={handleReject}
							disabled={updateDocumentMutation.isPending}
						>
							{updateDocumentMutation.isPending && action === "REJECTED" ? (
								<Loader2 className="mr-2 h-4 w-4 animate-spin" />
							) : (
								<XCircle className="mr-2 h-4 w-4" />
							)}
							Reject Document
						</Button>
						<Button
							onClick={handleApprove}
							disabled={updateDocumentMutation.isPending}
						>
							{updateDocumentMutation.isPending && action === "APPROVED" ? (
								<Loader2 className="mr-2 h-4 w-4 animate-spin" />
							) : (
								<CheckCircle className="mr-2 h-4 w-4" />
							)}
							Approve Document
						</Button>
					</div>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};
