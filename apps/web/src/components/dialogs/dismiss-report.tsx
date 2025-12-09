import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import type { Report } from "@repo/schema/report";
import { useQueryClient } from "@tanstack/react-query";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import * as z from "zod";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient } from "@/lib/orpc";

const dismissSchema = z.object({
	reason: z.string().min(10, "Dismissal reason must be at least 10 characters"),
});

type DismissFormData = z.infer<typeof dismissSchema>;

interface DismissReportDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	report: Report;
}

export const DismissReportDialog = ({
	open,
	onOpenChange,
	report,
}: DismissReportDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();

	const form = useForm({
		resolver: zodResolver(dismissSchema),
		defaultValues: {
			reason: "",
		},
	});

	const handleDismiss = async (data: DismissFormData) => {
		setIsLoading(true);
		try {
			const result = await orpcClient.report.dismiss({
				params: { id: report.id },
				body: { reason: data.reason },
			});
			if (result.status === 200) {
				toast.success(m.server_report_dismissed());
				queryClient.invalidateQueries();
				form.reset();
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to dismiss report:", error);
		} finally {
			setIsLoading(false);
		}
	};

	return (
		<Dialog
			open={open}
			onOpenChange={(newOpen) => {
				if (!newOpen) form.reset();
				onOpenChange(newOpen);
			}}
		>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.dismiss_report()}</DialogTitle>
					<DialogDescription>{m.dismiss_report_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(handleDismiss)}
						className="space-y-4"
					>
						<div className="py-2">
							<p className="text-muted-foreground text-sm">
								{report.description}
							</p>
						</div>
						<FormField
							control={form.control}
							name="reason"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.dismissal_reason()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Explain why this report is being dismissed..."
											{...field}
											rows={4}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<DialogFooter>
							<Button
								type="button"
								variant="outline"
								onClick={() => {
									form.reset();
									onOpenChange(false);
								}}
								disabled={isLoading}
							>
								{m.cancel()}
							</Button>
							<Button type="submit" variant="destructive" disabled={isLoading}>
								{isLoading ? "Dismissing..." : m.dismiss_report()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
