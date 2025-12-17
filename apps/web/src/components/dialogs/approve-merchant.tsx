import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import * as z from "zod";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogClose,
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
import { orpcQuery } from "@/lib/orpc";

const FormSchema = z.object({
	reviewNotes: z.string().optional(),
});

interface ApproveMerchantDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	merchant: Merchant;
}

export const ApproveMerchantDialog = ({
	open,
	onOpenChange,
	merchant,
}: ApproveMerchantDialogProps) => {
	const queryClient = useQueryClient();

	const form = useForm({
		resolver: zodResolver(FormSchema),
		defaultValues: {
			reviewNotes: "",
		},
	});

	const mutation = useMutation(
		orpcQuery.merchant.submitApproval.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.success_placeholder({ action: "Merchant approved" }));
				onOpenChange(false);
				form.reset();
			},
			onError: (error: Error) => {
				toast.error("Failed to approve merchant", {
					description: error.message || m.an_unexpected_error_occurred(),
				});
			},
		}),
	);

	const onSubmit = async (data: z.infer<typeof FormSchema>) => {
		await mutation.mutateAsync({
			params: { id: merchant.id },
			body: data,
		});
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Approve Merchant</DialogTitle>
					<DialogDescription>
						Approve this merchant application. They will be able to start
						operating immediately.
					</DialogDescription>
				</DialogHeader>
				<div className="py-2">
					<p className="text-muted-foreground text-sm">
						Merchant: <span className="font-medium">{merchant.name}</span>
					</p>
					{!merchant.document && (
						<p className="mt-2 text-amber-600 text-sm">
							Note: This merchant has not uploaded a business document.
						</p>
					)}
				</div>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-2 space-y-4"
					>
						<FormField
							control={form.control}
							name="reviewNotes"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Review Notes (Optional)</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Add any notes about this approval..."
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline" disabled={mutation.isPending}>
									{m.cancel()}
								</Button>
							</DialogClose>

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending && <Submitting />}
								Approve Merchant
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
