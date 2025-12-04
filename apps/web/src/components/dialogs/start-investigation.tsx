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

const investigationSchema = z.object({
	notes: z
		.string()
		.min(10, "Investigation notes must be at least 10 characters"),
});

type InvestigationFormData = z.infer<typeof investigationSchema>;

interface StartInvestigationDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	report: Report;
}

export const StartInvestigationDialog = ({
	open,
	onOpenChange,
	report,
}: StartInvestigationDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();

	const form = useForm<InvestigationFormData>({
		resolver: zodResolver(investigationSchema),
		defaultValues: {
			notes: "",
		},
	});

	const handleStartInvestigation = async (data: InvestigationFormData) => {
		setIsLoading(true);
		try {
			const result = await orpcClient.report.startInvestigation({
				params: { id: report.id },
				body: { notes: data.notes },
			});
			if (result.status === 200) {
				toast.success(m.server_report_investigation_started());
				queryClient.invalidateQueries({ queryKey: ["reports"] });
				form.reset();
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to start investigation:", error);
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
					<DialogTitle>{m.start_investigation()}</DialogTitle>
					<DialogDescription>{m.start_investigation_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(handleStartInvestigation)}
						className="space-y-4"
					>
						<div className="py-2">
							<p className="text-muted-foreground text-sm">
								{report.description}
							</p>
						</div>
						<FormField
							control={form.control}
							name="notes"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.investigation_notes()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Provide initial investigation notes..."
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
							<Button type="submit" disabled={isLoading}>
								{isLoading ? m.loading() : m.start_investigation()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
