import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { useMutation } from "@tanstack/react-query";
import { MoreHorizontal } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { LiveTrackingDialog } from "@/components/dialogs/live-tracking";
import { OrderDetailDialog } from "@/components/dialogs/order-detail";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { orpcClient, queryClient } from "@/lib/orpc";

export const OrderActionTable = ({ val }: { val: Order }) => {
	const [trackingDialogOpen, setTrackingDialogOpen] = useState(false);

	// Generic order actions
	const isCancellable =
		val.status === "REQUESTED" ||
		val.status === "MATCHING" ||
		val.status === "ACCEPTED";
	const isReassignable =
		val.status === "ACCEPTED" ||
		val.status === "ARRIVING" ||
		val.status === "IN_TRIP";

	// Merchant-specific actions for food orders
	const isMerchantAcceptable =
		val.type === "FOOD" && val.status === "REQUESTED";
	const isMerchantPreparable = val.type === "FOOD" && val.status === "ACCEPTED";
	const isMerchantReadyForPickup =
		val.type === "FOOD" && val.status === "PREPARING";
	const isMerchantCancellable =
		val.type === "FOOD" &&
		(val.status === "REQUESTED" ||
			val.status === "ACCEPTED" ||
			val.status === "PREPARING");

	// Mutations for merchant actions
	const updateOrderMutation = useMutation({
		mutationFn: async (status: Order["status"]) => {
			const result = await orpcClient.order.update({
				params: { id: val.id },
				body: { status },
			});
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result.body.data;
		},
		onSuccess: () => {
			toast.success(m.success_placeholder({ action: "Order status updated" }));
			queryClient.invalidateQueries({ queryKey: ["orders"] });
			queryClient.invalidateQueries({ queryKey: ["order", val.id] });
		},
		onError: (error) => {
			toast.error(error.message);
		},
	});

	return (
		<>
			<DropdownMenu>
				<DropdownMenuTrigger asChild>
					<Button variant="ghost" className="h-8 w-8 p-0">
						<span className="sr-only">{m.actions()}</span>
						<MoreHorizontal className="h-4 w-4" />
					</Button>
				</DropdownMenuTrigger>
				<DropdownMenuContent align="end">
					<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
					<OrderDetailDialog
						order={val}
						trigger={
							<DropdownMenuItem onSelect={(e) => e.preventDefault()}>
								View Details
							</DropdownMenuItem>
						}
					/>
					<DropdownMenuItem
						onSelect={(e) => {
							e.preventDefault();
							setTrackingDialogOpen(true);
						}}
					>
						Track on Map
					</DropdownMenuItem>

					{/* Merchant actions for food orders */}
					{isMerchantAcceptable && (
						<>
							<DropdownMenuSeparator />
							<DropdownMenuItem
								className="text-green-600"
								onClick={() => updateOrderMutation.mutate("ACCEPTED")}
								disabled={updateOrderMutation.isPending}
							>
								Accept Order
							</DropdownMenuItem>
						</>
					)}

					{isMerchantPreparable && (
						<>
							<DropdownMenuSeparator />
							<DropdownMenuItem
								className="text-blue-600"
								onClick={() => updateOrderMutation.mutate("PREPARING")}
								disabled={updateOrderMutation.isPending}
							>
								Mark as Preparing
							</DropdownMenuItem>
						</>
					)}

					{isMerchantReadyForPickup && (
						<>
							<DropdownMenuSeparator />
							<DropdownMenuItem
								className="text-purple-600"
								onClick={() => updateOrderMutation.mutate("READY_FOR_PICKUP")}
								disabled={updateOrderMutation.isPending}
							>
								Mark as Ready for Pickup
							</DropdownMenuItem>
						</>
					)}

					{isMerchantCancellable && (
						<>
							<DropdownMenuSeparator />
							<DropdownMenuItem
								className="text-red-600"
								onClick={() =>
									updateOrderMutation.mutate("CANCELLED_BY_MERCHANT")
								}
								disabled={updateOrderMutation.isPending}
							>
								Cancel Order
							</DropdownMenuItem>
						</>
					)}

					{/* Generic actions */}
					{(isReassignable || isCancellable) && <DropdownMenuSeparator />}
					{isReassignable && (
						<DropdownMenuItem className="text-blue-600">
							Reassign Driver
						</DropdownMenuItem>
					)}
					{isCancellable && (
						<DropdownMenuItem className="text-red-600">
							Cancel Order
						</DropdownMenuItem>
					)}
				</DropdownMenuContent>
			</DropdownMenu>
			<LiveTrackingDialog
				order={val}
				open={trackingDialogOpen}
				onOpenChange={setTrackingDialogOpen}
			/>
		</>
	);
};
