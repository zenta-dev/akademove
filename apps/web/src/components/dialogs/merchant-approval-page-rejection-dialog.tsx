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
	reason: z.string().min(1, "Rejection reason is required"),
});

export const MerchantApprovalPageRejectionDialog = ({
	merchantId,
	isOpen,
	onOpenChange,
}: {
	merchantId: string;
	isOpen: boolean;
	onOpenChange: (open: boolean) => void;
}) => {
	const form = useForm({
		resolver: zodResolver(FormSchema),
		defaultValues: {
			reason: "",
		},
	});

	const mutation = useMutation(
		orpcQuery.merchant.submitRejection.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success("Merchant application rejected");
				onOpenChange(false);
				form.reset();
			},
			onError: (error: Error) => {
				toast.error("Failed to reject merchant", {
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
					<DialogTitle>Reject Merchant Application</DialogTitle>
					<DialogDescription>
						Provide a reason for the rejection. The merchant will receive an
						email with the details.
					</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="reason"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Rejection Reason</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Explain why this application is being rejected..."
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

							<Button
								type="submit"
								disabled={mutation.isPending}
								variant="destructive"
							>
								{mutation.isPending && <Submitting />}
								Reject Application
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
