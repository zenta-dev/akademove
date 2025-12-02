import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import { MoreHorizontal } from "lucide-react";
import { AcceptOrderDialog } from "@/components/dialogs/accept-order";
import { MarkPreparingDialog } from "@/components/dialogs/mark-preparing";
import { MarkReadyDialog } from "@/components/dialogs/mark-ready";
import { OrderDetailDialog } from "@/components/dialogs/order-detail";
import { RejectOrderDialog } from "@/components/dialogs/reject-order";
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
	const isCancellable =
		val.status === "REQUESTED" ||
		val.status === "MATCHING" ||
		val.status === "ACCEPTED";
	const isReassignable =
		val.status === "ACCEPTED" ||
		val.status === "ARRIVING" ||
		val.status === "IN_TRIP";

	// Merchant-specific actions for FOOD orders
	const isFoodOrder = val.type === "FOOD";
	const canAccept = isFoodOrder && val.status === "REQUESTED";
	const canReject = isFoodOrder && val.status === "REQUESTED";
	const canMarkPreparing = isFoodOrder && val.status === "ACCEPTED";
	const canMarkReady = isFoodOrder && val.status === "PREPARING";

	return (
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
				<DropdownMenuItem>Track on Map</DropdownMenuItem>

				{/* Merchant FOOD order actions */}
				{(canAccept || canReject || canMarkPreparing || canMarkReady) && (
					<DropdownMenuSeparator />
				)}
				{canAccept && (
					<AcceptOrderDialog
						orderId={val.id}
						trigger={
							<DropdownMenuItem
								className="text-green-600"
								onSelect={(e) => e.preventDefault()}
							>
								Accept Order
							</DropdownMenuItem>
						}
					/>
				)}
				{canReject && (
					<RejectOrderDialog
						orderId={val.id}
						trigger={
							<DropdownMenuItem
								className="text-red-600"
								onSelect={(e) => e.preventDefault()}
							>
								Reject Order
							</DropdownMenuItem>
						}
					/>
				)}
				{canMarkPreparing && (
					<MarkPreparingDialog
						orderId={val.id}
						trigger={
							<DropdownMenuItem
								className="text-blue-600"
								onSelect={(e) => e.preventDefault()}
							>
								Mark Preparing
							</DropdownMenuItem>
						}
					/>
				)}
				{canMarkReady && (
					<MarkReadyDialog
						orderId={val.id}
						trigger={
							<DropdownMenuItem
								className="text-purple-600"
								onSelect={(e) => e.preventDefault()}
							>
								Mark Ready
							</DropdownMenuItem>
						}
					/>
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
	);
};
