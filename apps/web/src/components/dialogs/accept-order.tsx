import { m } from "@repo/i18n";
import { useMutation } from "@tanstack/react-query";
import type { ReactElement } from "react";
import { useState } from "react";
import { toast } from "sonner";
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
import { orpcClient, queryClient } from "@/lib/orpc";
import { useMyMerchant } from "@/providers/merchant";

interface AcceptOrderDialogProps {
	orderId: string;
	trigger?: ReactElement;
}

export const AcceptOrderDialog = ({
	orderId,
	trigger,
}: AcceptOrderDialogProps) => {
	const [dialogOpen, setDialogOpen] = useState(false);
	const merchant = useMyMerchant();

	const mutation = useMutation({
		mutationFn: async () => {
			if (!merchant.value?.id) throw new Error("Merchant not found");
			const result = await orpcClient.merchant.order.accept({
				params: { merchantId: merchant.value.id, id: orderId },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: async () => {
			await queryClient.invalidateQueries({ queryKey: ["orders"] });
			await queryClient.invalidateQueries({
				queryKey: ["merchant", "analytics"],
			});
			toast.success("Order accepted successfully");
			setDialogOpen(false);
		},
		onError: (error: Error) => {
			toast.error("Failed to accept order", {
				description: error.message || "An unexpected error occurred",
			});
		},
	});

	const handleAccept = async () => {
		await mutation.mutateAsync();
	};

	const defaultTrigger = (
		<Button variant="default" size="sm">
			Accept Order
		</Button>
	);

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>{trigger || defaultTrigger}</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Accept Order</DialogTitle>
					<DialogDescription>
						Are you sure you want to accept this order? You will be responsible
						for preparing it.
					</DialogDescription>
				</DialogHeader>
				<DialogFooter>
					<DialogClose asChild>
						<Button variant="outline" disabled={mutation.isPending}>
							{m.cancel()}
						</Button>
					</DialogClose>

					<Button onClick={handleAccept} disabled={mutation.isPending}>
						{mutation.isPending ? <Submitting /> : "Accept Order"}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};
