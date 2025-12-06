import { m } from "@repo/i18n";
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

const getReportCategories = (): { value: ReportCategory; label: string }[] => [
	{ value: "BEHAVIOR", label: m.report_user_inappropriate() },
	{ value: "SAFETY", label: m.report_user_safety() },
	{ value: "FRAUD", label: m.report_user_fraud() },
	{ value: "OTHER", label: m.report_user_other() },
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
				throw new Error(m.report_user_description_required());
			}

			if (description.trim().length < 20) {
				throw new Error(m.report_user_description_too_short());
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
			toast.success(m.report_user_success());
			onOpenChange(false);
			resetForm();
		},
		onError: (error: Error) => {
			toast.error(m.report_user_error({ error: error.message }));
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
					<DialogTitle>{m.report_user_title()}</DialogTitle>
					<DialogDescription>
						{m.report_user_desc({ name: targetUserName || "this user" })}
					</DialogDescription>
				</DialogHeader>

				<form onSubmit={handleSubmit} className="space-y-4">
					{/* Category Selection */}
					<div>
						<Label htmlFor="category">{m.report_user_category()}</Label>
						<Select
							value={category}
							onValueChange={(value) => setCategory(value as ReportCategory)}
							disabled={reportMutation.isPending}
						>
							<SelectTrigger id="category">
								<SelectValue />
							</SelectTrigger>
							<SelectContent>
								{getReportCategories().map((cat) => (
									<SelectItem key={cat.value} value={cat.value}>
										{cat.label}
									</SelectItem>
								))}
							</SelectContent>
						</Select>
					</div>

					{/* Description */}
					<div>
						<Label htmlFor="description">{m.report_user_description()}</Label>
						<Textarea
							id="description"
							placeholder={m.report_user_description_placeholder()}
							value={description}
							onChange={(e) => setDescription(e.target.value)}
							rows={5}
							required
							disabled={reportMutation.isPending}
							minLength={20}
						/>
						<p className="mt-1 text-muted-foreground text-xs">
							{m.report_user_description_min({ length: description.length })}
						</p>
					</div>

					{/* Privacy Notice */}
					<div className="rounded-lg border border-yellow-200 bg-yellow-50 p-3 text-sm">
						<p className="font-medium text-yellow-900">
							{m.report_user_privacy()}
						</p>
						<p className="mt-1 text-yellow-800">
							{m.report_user_privacy_desc()}
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
							{m.cancel()}
						</Button>
						<Button
							type="submit"
							disabled={reportMutation.isPending || description.length < 20}
						>
							{reportMutation.isPending
								? m.submitting()
								: m.report_user_submit()}
						</Button>
					</DialogFooter>
				</form>
			</DialogContent>
		</Dialog>
	);
}
