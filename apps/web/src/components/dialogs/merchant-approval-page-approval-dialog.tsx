import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { useMutation } from "@tanstack/react-query";
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
import { orpcQuery, queryClient } from "@/lib/orpc";

const FormSchema = z.object({
	reviewNotes: z.string().optional(),
});

export const MerchantApprovalPageApprovalDialog = ({
	merchantId,
	isOpen,
	onOpenChange,
	onSuccess,
}: {
	merchantId: string;
	isOpen: boolean;
	onOpenChange: (open: boolean) => void;
	onSuccess?: () => void;
}) => {
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
				onSuccess?.();
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
			params: { id: merchantId },
			body: data,
		});
	};

	return (
		<Dialog open={isOpen} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Approve Merchant Application</DialogTitle>
					<DialogDescription>
						Approve this merchant application. They will receive an email
						confirmation.
					</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
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
								<Button variant="outline">Cancel</Button>
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
