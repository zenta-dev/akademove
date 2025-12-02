import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { CONSTANTS } from "@repo/schema/constants";
import { useMutation } from "@tanstack/react-query";
import type { ReactElement } from "react";
import { useState } from "react";
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
	DialogTrigger,
} from "@/components/ui/dialog";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient, queryClient } from "@/lib/orpc";
import { useMyMerchant } from "@/providers/merchant";

const RejectOrderSchema = z.object({
	reason: z.enum(CONSTANTS.ORDER_REJECTION_REASONS),
	note: z.string().optional(),
});

type RejectOrderForm = z.infer<typeof RejectOrderSchema>;

interface RejectOrderDialogProps {
	orderId: string;
	trigger?: ReactElement;
}

export const RejectOrderDialog = ({
	orderId,
	trigger,
}: RejectOrderDialogProps) => {
	const [dialogOpen, setDialogOpen] = useState(false);
	const merchant = useMyMerchant();

	const form = useForm({
		resolver: zodResolver(RejectOrderSchema),
		defaultValues: {
			reason: "OUT_OF_STOCK",
			note: "",
		},
	});

	const mutation = useMutation({
		mutationFn: async (values: RejectOrderForm) => {
			if (!merchant.value?.id) throw new Error("Merchant not found");
			const result = await orpcClient.merchant.order.reject({
				params: { merchantId: merchant.value.id, id: orderId },
				body: values,
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: async () => {
			await queryClient.invalidateQueries({ queryKey: ["orders"] });
			await queryClient.invalidateQueries({
				queryKey: ["merchant", "analytics"],
			});
			toast.success("Order rejected successfully");
			setDialogOpen(false);
			form.reset();
		},
		onError: (error: Error) => {
			toast.error("Failed to reject order", {
				description: error.message || "An unexpected error occurred",
			});
		},
	});

	const onSubmit = async (values: RejectOrderForm) => {
		await mutation.mutateAsync(values);
	};

	const reasonLabels: Record<string, string> = {
		OUT_OF_STOCK: "Out of Stock",
		TOO_BUSY: "Too Busy",
		INGREDIENT_UNAVAILABLE: "Ingredient Unavailable",
		CLOSED: "Store Closed",
		OTHER: "Other",
	};

	const defaultTrigger = (
		<Button variant="destructive" size="sm">
			Reject Order
		</Button>
	);

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>{trigger || defaultTrigger}</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Reject Order</DialogTitle>
					<DialogDescription>
						Please select a reason for rejecting this order. The customer will
						be notified.
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
									<Select
										onValueChange={field.onChange}
										defaultValue={field.value}
										disabled={mutation.isPending}
									>
										<FormControl>
											<SelectTrigger>
												<SelectValue placeholder="Select a reason" />
											</SelectTrigger>
										</FormControl>
										<SelectContent>
											{CONSTANTS.ORDER_REJECTION_REASONS.map((reason) => (
												<SelectItem key={reason} value={reason}>
													{reasonLabels[reason as keyof typeof reasonLabels] ||
														reason}
												</SelectItem>
											))}
										</SelectContent>
									</Select>
									<FormMessage />
								</FormItem>
							)}
						/>

						<FormField
							control={form.control}
							name="note"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Additional Note (Optional)</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Provide more details if needed..."
											disabled={mutation.isPending}
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

							<Button
								type="submit"
								variant="destructive"
								disabled={mutation.isPending}
							>
								{mutation.isPending ? <Submitting /> : "Reject Order"}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
