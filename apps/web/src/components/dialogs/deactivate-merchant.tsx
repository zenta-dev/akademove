import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
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

const deactivateSchema = z.object({
	reason: z.string().min(10, "Reason must be at least 10 characters"),
});

type DeactivateFormData = z.infer<typeof deactivateSchema>;

interface DeactivateMerchantDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	merchant: Merchant;
}

export const DeactivateMerchantDialog = ({
	open,
	onOpenChange,
	merchant,
}: DeactivateMerchantDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();

	const form = useForm({
		resolver: zodResolver(deactivateSchema),
		defaultValues: {
			reason: "",
		},
	});

	const handleDeactivate = async (data: DeactivateFormData) => {
		setIsLoading(true);
		try {
			const result = await orpcClient.merchant.deactivate({
				params: { id: merchant.id },
				body: { reason: data.reason },
			});
			if (result.status === 200) {
				toast.success(m.server_merchant_deactivated());
				queryClient.invalidateQueries();
				form.reset();
				onOpenChange(false);
			} else {
				toast.error(m.an_unexpected_error_occurred());
			}
		} catch (error) {
			toast.error(m.an_unexpected_error_occurred());
			console.error("Failed to deactivate merchant:", error);
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
					<DialogTitle>{m.deactivate_merchant()}</DialogTitle>
					<DialogDescription>{m.deactivate_merchant_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(handleDeactivate)}
						className="space-y-4"
					>
						<div className="py-2">
							<p className="font-medium text-sm">{merchant.name}</p>
						</div>
						<FormField
							control={form.control}
							name="reason"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.deactivate_reason()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Please provide a detailed reason for deactivation..."
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
								{isLoading ? m.submitting() : m.deactivate()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
