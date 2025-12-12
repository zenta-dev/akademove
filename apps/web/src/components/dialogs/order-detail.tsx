import { m } from "@repo/i18n";
import type { Order } from "@repo/schema/order";
import {
	CheckCircle2,
	Clock,
	History,
	MapPin,
	Package,
	Phone,
	User,
	Utensils,
} from "lucide-react";
import type { ReactElement } from "react";
import { useState } from "react";
import { MarkPreparingDialog } from "@/components/dialogs/mark-preparing";
import { MarkReadyDialog } from "@/components/dialogs/mark-ready";
import { OrderAuditHistory } from "@/components/order-audit-history";
import { OrderTrackingMap } from "@/components/order-tracking-map";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Collapsible,
	CollapsibleContent,
	CollapsibleTrigger,
} from "@/components/ui/collapsible";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
import { Separator } from "@/components/ui/separator";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { cn } from "@/utils/cn";

interface OrderDetailDialogProps {
	order: Order;
	trigger?: ReactElement;
}

export const OrderDetailDialog = ({
	order,
	trigger,
}: OrderDetailDialogProps) => {
	const [dialogOpen, setDialogOpen] = useState(false);

	const formatPrice = (price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	};

	const formatDate = (date: Date | string | undefined) => {
		if (!date) return "N/A";
		const dateObj = typeof date === "string" ? new Date(date) : date;
		return new Intl.DateTimeFormat("id-ID", {
			weekday: "short",
			year: "numeric",
			month: "short",
			day: "numeric",
			hour: "2-digit",
			minute: "2-digit",
			timeZone: "Asia/Jakarta",
		}).format(dateObj);
	};

	const statusConfig: Record<
		string,
		{ color: string; icon: typeof CheckCircle2 }
	> = {
		REQUESTED: {
			color:
				"bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300",
			icon: Clock,
		},
		MATCHING: {
			color: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
			icon: Clock,
		},
		ACCEPTED: {
			color: "bg-cyan-100 text-cyan-800 dark:bg-cyan-900 dark:text-cyan-300",
			icon: CheckCircle2,
		},
		PREPARING: {
			color:
				"bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-300",
			icon: Utensils,
		},
		READY_FOR_PICKUP: {
			color:
				"bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-300",
			icon: Package,
		},
		ARRIVING: {
			color:
				"bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-300",
			icon: MapPin,
		},
		IN_TRIP: {
			color:
				"bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300",
			icon: MapPin,
		},
		COMPLETED: {
			color:
				"bg-emerald-100 text-emerald-800 dark:bg-emerald-900 dark:text-emerald-300",
			icon: CheckCircle2,
		},
		CANCELLED_BY_USER: {
			color: "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
			icon: Clock,
		},
		CANCELLED_BY_DRIVER: {
			color: "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
			icon: Clock,
		},
		CANCELLED_BY_MERCHANT: {
			color: "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
			icon: Clock,
		},
		CANCELLED_BY_SYSTEM: {
			color: "bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300",
			icon: Clock,
		},
	};

	const StatusIcon = statusConfig[order.status]?.icon || Clock;

	const timelineSteps = [
		{
			label: m.order_detail_requested(),
			date: order.requestedAt,
			active: true,
		},
		{
			label: m.order_detail_accepted(),
			date: order.acceptedAt,
			active: !!order.acceptedAt,
		},
		{
			label: m.order_detail_preparing(),
			date: order.preparedAt,
			active: !!order.preparedAt && order.type === "FOOD",
		},
		{
			label: m.order_detail_ready(),
			date: order.readyAt,
			active: !!order.readyAt && order.type === "FOOD",
		},
		{
			label: m.order_detail_arrived(),
			date: order.arrivedAt,
			active: !!order.arrivedAt,
		},
	].filter((step) => step.active || order.type === "FOOD");

	const defaultTrigger = (
		<Button variant="ghost" size="sm">
			{m.order_detail_view()}
		</Button>
	);

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>{trigger || defaultTrigger}</DialogTrigger>
			<DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-3xl">
				<DialogHeader>
					<div className="flex items-start justify-between">
						<div>
							<DialogTitle className="flex items-center gap-2">
								{m.order_detail_title({ id: order.id.slice(0, 8) })}
								<Badge
									variant="secondary"
									className={cn(statusConfig[order.status]?.color)}
								>
									<StatusIcon className="mr-1 h-3 w-3" />
									{order.status.replace(/_/g, " ")}
								</Badge>
							</DialogTitle>
							<DialogDescription>
								{m.order_detail_created({ date: formatDate(order.createdAt) })}
							</DialogDescription>
						</div>
					</div>
				</DialogHeader>

				<div className="space-y-6">
					{/* Customer Information */}
					<div className="space-y-3">
						<h3 className="flex items-center gap-2 font-semibold text-sm">
							<User className="h-4 w-4" />
							{m.order_detail_customer_info()}
						</h3>
						<div className="grid gap-2 rounded-lg border p-4">
							<div className="flex justify-between">
								<span className="text-muted-foreground text-sm">
									{m.order_detail_customer_name()}
								</span>
								<span className="font-medium text-sm">
									{order.user?.name || "N/A"}
								</span>
							</div>
							{order.user?.phone && (
								<div className="flex justify-between">
									<span className="text-muted-foreground text-sm">
										{m.order_detail_customer_phone()}
									</span>
									<span className="flex items-center gap-1 font-medium text-sm">
										<Phone className="h-3 w-3" />
										{String(order.user.phone.number).replace(
											/(\d{4})(\d{4})(\d+)/,
											"****-****-$3",
										)}
									</span>
								</div>
							)}
						</div>
					</div>

					{/* Driver Information */}
					{order.driver && (
						<div className="space-y-3">
							<h3 className="flex items-center gap-2 font-semibold text-sm">
								<MapPin className="h-4 w-4" />
								{m.order_detail_driver_info()}
							</h3>
							<div className="grid gap-2 rounded-lg border p-4">
								<div className="flex justify-between">
									<span className="text-muted-foreground text-sm">
										{m.order_detail_driver_name()}
									</span>
									<span className="font-medium text-sm">
										{order.driver.studentId || "N/A"}
									</span>
								</div>
								{order.driver.licensePlate && (
									<div className="flex justify-between">
										<span className="text-muted-foreground text-sm">
											{m.order_detail_driver_vehicle()}
										</span>
										<span className="font-medium text-sm">
											{order.driver.licensePlate}
										</span>
									</div>
								)}
								{order.driver.rating && (
									<div className="flex justify-between">
										<span className="text-muted-foreground text-sm">
											{m.order_detail_driver_rating()}
										</span>
										<span className="font-medium text-sm">
											⭐ {order.driver.rating.toFixed(1)}
										</span>
									</div>
								)}
							</div>
						</div>
					)}

					{/* Order Items (for FOOD orders) */}
					{order.type === "FOOD" && order.items && order.items.length > 0 && (
						<div className="space-y-3">
							<h3 className="flex items-center gap-2 font-semibold text-sm">
								<Utensils className="h-4 w-4" />
								{m.order_detail_items()}
							</h3>
							<div className="rounded-lg border">
								<Table>
									<TableHeader>
										<TableRow>
											<TableHead>{m.order_detail_item_header()}</TableHead>
											<TableHead className="text-center">
												{m.order_detail_qty_header()}
											</TableHead>
											<TableHead className="text-right">
												{m.order_detail_price_header()}
											</TableHead>
											<TableHead className="text-right">
												{m.order_detail_subtotal_header()}
											</TableHead>
										</TableRow>
									</TableHeader>
									<TableBody>
										{order.items.map((item, index) => (
											<TableRow key={item.item.id || `item-${index}`}>
												<TableCell className="font-medium">
													<div className="flex items-center gap-3">
														{item.item.image && (
															<img
																src={item.item.image}
																alt={item.item.name || "Item"}
																className="h-10 w-10 rounded object-cover"
															/>
														)}
														<span>
															{item.item.name || m.order_detail_unknown_item()}
														</span>
													</div>
												</TableCell>
												<TableCell className="text-center">
													{item.quantity}
												</TableCell>
												<TableCell className="text-right">
													{formatPrice(item.item.price || 0)}
												</TableCell>
												<TableCell className="text-right">
													{formatPrice((item.item.price || 0) * item.quantity)}
												</TableCell>
											</TableRow>
										))}
									</TableBody>
								</Table>
							</div>
						</div>
					)}

					{/* Location Information */}
					<div className="space-y-3">
						<h3 className="flex items-center gap-2 font-semibold text-sm">
							<MapPin className="h-4 w-4" />
							{m.order_detail_locations()}
						</h3>
						<div className="grid gap-2 rounded-lg border p-4">
							<div className="flex justify-between">
								<span className="text-muted-foreground text-sm">
									{m.order_detail_pickup()}
								</span>
								<span className="font-medium text-sm">
									{order.pickupAddress ||
										`${order.pickupLocation.y.toFixed(4)}, ${order.pickupLocation.x.toFixed(4)}`}
								</span>
							</div>
							<div className="flex justify-between">
								<span className="text-muted-foreground text-sm">
									{m.order_detail_dropoff()}
								</span>
								<span className="font-medium text-sm">
									{order.dropoffAddress ||
										`${order.dropoffLocation.y.toFixed(4)}, ${order.dropoffLocation.x.toFixed(4)}`}
								</span>
							</div>
							<div className="flex justify-between">
								<span className="text-muted-foreground text-sm">
									{m.order_detail_distance()}
								</span>
								<span className="font-medium text-sm">
									{order.distanceKm.toFixed(1)} km
								</span>
							</div>
						</div>
					</div>

					{/* Map View */}
					<div className="space-y-3">
						<h3 className="flex items-center gap-2 font-semibold text-sm">
							<MapPin className="h-4 w-4" />
							{m.order_detail_map_view()}
						</h3>
						<OrderTrackingMap
							pickup={{
								lat: order.pickupLocation.y,
								lng: order.pickupLocation.x,
							}}
							delivery={{
								lat: order.dropoffLocation.y,
								lng: order.dropoffLocation.x,
							}}
							orderStatus={order.status}
						/>
					</div>

					{/* Order Summary */}
					<div className="space-y-3">
						<h3 className="flex items-center gap-2 font-semibold text-sm">
							<Package className="h-4 w-4" />
							{m.order_detail_summary()}
						</h3>
						<div className="rounded-lg border p-4">
							<div className="space-y-2">
								<div className="flex justify-between text-sm">
									<span className="text-muted-foreground">
										{m.order_detail_base_price()}
									</span>
									<span>{formatPrice(order.basePrice)}</span>
								</div>
								{order.tip && order.tip > 0 && (
									<div className="flex justify-between text-sm">
										<span className="text-muted-foreground">
											{m.order_detail_tip()}
										</span>
										<span>{formatPrice(order.tip)}</span>
									</div>
								)}
								<Separator />
								<div className="flex justify-between font-bold">
									<span>{m.order_detail_total()}</span>
									<span>{formatPrice(order.totalPrice)}</span>
								</div>
								{order.merchantCommission && (
									<div className="flex justify-between text-muted-foreground text-sm">
										<span>{m.order_detail_commission()}</span>
										<span>- {formatPrice(order.merchantCommission)}</span>
									</div>
								)}
							</div>
						</div>
					</div>

					{/* Timeline */}
					<div className="space-y-3">
						<h3 className="flex items-center gap-2 font-semibold text-sm">
							<Clock className="h-4 w-4" />
							{m.order_detail_timeline()}
						</h3>
						<div className="space-y-2">
							{timelineSteps.map((step) => (
								<div key={step.label} className="flex items-center gap-3">
									<div
										className={cn(
											"h-2 w-2 rounded-full",
											step.date
												? "bg-green-600"
												: "bg-gray-300 dark:bg-gray-700",
										)}
									/>
									<div className="flex flex-1 justify-between text-sm">
										<span
											className={cn(
												step.date ? "font-medium" : "text-muted-foreground",
											)}
										>
											{step.label}
										</span>
										<span className="text-muted-foreground">
											{formatDate(step.date)}
										</span>
									</div>
								</div>
							))}
						</div>
					</div>

					{/* Audit History - Collapsible Section */}
					<Collapsible>
						<CollapsibleTrigger asChild>
							<Button
								variant="ghost"
								className="flex w-full items-center justify-between p-0 hover:bg-transparent"
							>
								<span className="flex items-center gap-2 font-semibold text-sm">
									<History className="h-4 w-4" />
									{m.order_history_title()}
								</span>
								<span className="text-muted-foreground text-xs">
									{m.order_history_click_expand()}
								</span>
							</Button>
						</CollapsibleTrigger>
						<CollapsibleContent className="pt-3">
							<OrderAuditHistory
								orderId={order.id}
								className="border-0 p-0 shadow-none"
							/>
						</CollapsibleContent>
					</Collapsible>

					{/* Action Buttons */}
					{order.type === "FOOD" && (
						<div className="flex flex-wrap gap-2">
							{order.status === "ACCEPTED" && (
								<MarkPreparingDialog
									orderId={order.id}
									trigger={
										<Button variant="default">
											{m.order_detail_mark_preparing()}
										</Button>
									}
								/>
							)}
							{order.status === "PREPARING" && (
								<MarkReadyDialog
									orderId={order.id}
									trigger={
										<Button variant="default">
											{m.order_detail_mark_ready()}
										</Button>
									}
								/>
							)}
							{order.status === "READY_FOR_PICKUP" && (
								<div className="rounded-md bg-blue-50 p-3 text-blue-900 text-sm dark:bg-blue-950 dark:text-blue-200">
									Waiting for driver to pick up the order...
								</div>
							)}
							{order.status === "IN_TRIP" && (
								<div className="rounded-md bg-green-50 p-3 text-green-900 text-sm dark:bg-green-950 dark:text-green-200">
									Order is being delivered to the customer...
								</div>
							)}
							{order.status === "COMPLETED" && (
								<div className="rounded-md bg-emerald-50 p-3 text-emerald-900 text-sm dark:bg-emerald-950 dark:text-emerald-200">
									Order completed successfully!
								</div>
							)}
							{order.status.startsWith("CANCELLED") && order.cancelReason && (
								<div className="rounded-md bg-red-50 p-3 text-red-900 text-sm dark:bg-red-950 dark:text-red-200">
									Cancelled: {order.cancelReason}
								</div>
							)}
						</div>
					)}
				</div>
			</DialogContent>
		</Dialog>
	);
};
