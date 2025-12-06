import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { MoreHorizontal } from "lucide-react";
import { useState } from "react";
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

export const OrderActionTable = ({ val }: { val: Order }) => {
	const [trackingDialogOpen, setTrackingDialogOpen] = useState(false);
	const isCancellable =
		val.status === "REQUESTED" ||
		val.status === "MATCHING" ||
		val.status === "ACCEPTED";
	const isReassignable =
		val.status === "ACCEPTED" ||
		val.status === "ARRIVING" ||
		val.status === "IN_TRIP";

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
