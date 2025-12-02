import type { ReportCategory } from "@repo/schema/report";
import { useMutation } from "@tanstack/react-query";
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
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient } from "@/lib/orpc";

const REPORT_CATEGORIES: { value: ReportCategory; label: string }[] = [
	{ value: "BEHAVIOR", label: "Inappropriate Behavior" },
	{ value: "SAFETY", label: "Safety Concern" },
	{ value: "FRAUD", label: "Fraud or Scam" },
	{ value: "OTHER", label: "Other Issue" },
];

interface ReportUserDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	targetUserId: string;
	targetUserName?: string;
	orderId?: string;
}

export function ReportUserDialog({
	open,
	onOpenChange,
	targetUserId,
	targetUserName,
	orderId,
}: ReportUserDialogProps) {
	const [category, setCategory] = useState<ReportCategory>("BEHAVIOR");
	const [description, setDescription] = useState("");

	const reportMutation = useMutation({
		mutationFn: async () => {
			if (!description.trim()) {
				throw new Error("Please provide a description");
			}

			if (description.trim().length < 20) {
				throw new Error("Description must be at least 20 characters");
			}

			// Note: reporterId will be set by backend from authenticated user context
			const result = await orpcClient.report.create({
				body: {
					reporterId: "", // Backend will override with context.user.id
					targetUserId,
					orderId,
					category,
					description: description.trim(),
					status: "PENDING",
				},
			});

			if (result.status !== 200) {
				throw new Error(result.body.message);
			}

			return result.body.data;
		},
		onSuccess: () => {
			toast.success(
				"Report submitted successfully. Our team will review it shortly.",
			);
			onOpenChange(false);
			resetForm();
		},
		onError: (error: Error) => {
			toast.error(`Failed to submit report: ${error.message}`);
		},
	});

	const resetForm = () => {
		setCategory("BEHAVIOR");
		setDescription("");
	};

	const handleSubmit = (e: React.FormEvent) => {
		e.preventDefault();
		reportMutation.mutate();
	};

	return (
		<Dialog
			open={open}
			onOpenChange={(newOpen) => {
				onOpenChange(newOpen);
				if (!newOpen) resetForm();
			}}
		>
			<DialogContent className="max-w-md">
				<DialogHeader>
					<DialogTitle>Report User</DialogTitle>
					<DialogDescription>
						{targetUserName
							? `Report an issue with ${targetUserName}`
							: "Report an issue with this user"}
						. Your report will be reviewed by our safety team.
					</DialogDescription>
				</DialogHeader>

				<form onSubmit={handleSubmit} className="space-y-4">
					{/* Category Selection */}
					<div>
						<Label htmlFor="category">Issue Category</Label>
						<Select
							value={category}
							onValueChange={(value) => setCategory(value as ReportCategory)}
							disabled={reportMutation.isPending}
						>
							<SelectTrigger id="category">
								<SelectValue />
							</SelectTrigger>
							<SelectContent>
								{REPORT_CATEGORIES.map((cat) => (
									<SelectItem key={cat.value} value={cat.value}>
										{cat.label}
									</SelectItem>
								))}
							</SelectContent>
						</Select>
					</div>

					{/* Description */}
					<div>
						<Label htmlFor="description">
							Description{" "}
							<span className="text-muted-foreground text-xs">
								(min. 20 characters)
							</span>
						</Label>
						<Textarea
							id="description"
							placeholder="Please describe the issue in detail..."
							value={description}
							onChange={(e) => setDescription(e.target.value)}
							rows={5}
							required
							disabled={reportMutation.isPending}
							minLength={20}
						/>
						<p className="mt-1 text-muted-foreground text-xs">
							{description.length}/20 characters minimum
						</p>
					</div>

					{/* Privacy Notice */}
					<div className="rounded-lg border border-yellow-200 bg-yellow-50 p-3 text-sm">
						<p className="font-medium text-yellow-900">Privacy Notice</p>
						<p className="mt-1 text-yellow-800">
							Your report will be kept confidential. The reported user will not
							be notified of your identity.
						</p>
					</div>

					<DialogFooter>
						<Button
							type="button"
							variant="outline"
							onClick={() => {
								onOpenChange(false);
								resetForm();
							}}
							disabled={reportMutation.isPending}
						>
							Cancel
						</Button>
						<Button
							type="submit"
							disabled={reportMutation.isPending || description.length < 20}
						>
							{reportMutation.isPending ? "Submitting..." : "Submit Report"}
						</Button>
					</DialogFooter>
				</form>
			</DialogContent>
		</Dialog>
	);
}
