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

const resolveSchema = z.object({
	resolution: z.string().min(10, "Resolution must be at least 10 characters"),
});

type ResolveFormData = z.infer<typeof resolveSchema>;

interface ResolveReportDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	report: Report;
}

export const ResolveReportDialog = ({
	open,
	onOpenChange,
	report,
}: ResolveReportDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();

	const form = useForm<ResolveFormData>({
		resolver: zodResolver(resolveSchema),
		defaultValues: {
			resolution: "",
		},
	});

	const handleResolve = async (data: ResolveFormData) => {
		setIsLoading(true);
		try {
			const result = await orpcClient.report.resolve({
				params: { id: report.id },
				body: { resolution: data.resolution },
			});
			if (result.status === 200) {
				toast.success(m.server_report_resolved());
				queryClient.invalidateQueries({ queryKey: ["reports"] });
				form.reset();
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to resolve report:", error);
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
					<DialogTitle>{m.resolve_report()}</DialogTitle>
					<DialogDescription>{m.resolve_report_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(handleResolve)}
						className="space-y-4"
					>
						<div className="py-2">
							<p className="text-muted-foreground text-sm">
								{report.description}
							</p>
						</div>
						<FormField
							control={form.control}
							name="resolution"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.resolution()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Describe how this report was resolved..."
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
								{isLoading ? "Resolving..." : m.resolve_report()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
