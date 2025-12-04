import type { Order } from "@repo/schema/order";
import { type Location, toLocation } from "@repo/schema/position";
import { CheckCircle2, Clock, MapPin, Star, User } from "lucide-react";
import { useEffect, useState } from "react";
import { toast } from "sonner";
import { useOrderWebSocket } from "@/hooks/use-order-websocket";
import { LiveTrackingMap } from "../live-tracking-map";
import { Badge } from "../ui/badge";
import { Button } from "../ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
} from "../ui/dialog";
import { Skeleton } from "../ui/skeleton";

interface LiveTrackingDialogProps {
	order: Order | null | undefined;
	open: boolean;
	onOpenChange: (open: boolean) => void;
}

/**
 * Live tracking dialog with real-time order updates via WebSocket
 *
 * Features:
 * - Real-time driver location updates
 * - Order status changes
 * - Driver information
 * - ETA and distance
 * - Connection status indicator
 */
export const LiveTrackingDialog = ({
	order,
	open,
	onOpenChange,
}: LiveTrackingDialogProps) => {
	const [driverLocation, setDriverLocation] = useState<Location | null>(null);

	// WebSocket connection for real-time updates
	const { isConnected, lastEvent } = useOrderWebSocket({
		orderId: order?.id,
		enabled: open && !!order?.id,
		onEvent: (event, envelope) => {
			switch (event) {
				case "DRIVER_LOCATION_UPDATE":
					if (envelope.p.driverUpdateLocation) {
						// driverUpdateLocation has x, y format where x=lng, y=lat
						setDriverLocation({
							lat: envelope.p.driverUpdateLocation.y,
							lng: envelope.p.driverUpdateLocation.x,
						});
					}
					break;

				case "DRIVER_ACCEPTED":
					toast.success("Driver accepted your order!");
					break;

				case "COMPLETED":
					toast.success("Order completed!");
					break;

				case "CANCELED":
					toast.error(envelope.p.cancelReason || "Order was cancelled");
					break;
			}
		},
	});

	// Reset driver location when dialog closes or order changes
	useEffect(() => {
		if (!open || !order) {
			setDriverLocation(null);
		}
	}, [open, order]);

	if (!order) return null;

	const hasDriver = !!order.driverId;

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent className="max-h-[90vh] max-w-4xl overflow-y-auto">
				<DialogHeader>
					<div className="flex items-center justify-between">
						<div>
							<DialogTitle>Live Order Tracking</DialogTitle>
							<DialogDescription>
								Track your order in real-time
							</DialogDescription>
						</div>
						<div className="flex items-center gap-2">
							<div
								className={`h-2 w-2 rounded-full ${isConnected ? "bg-green-500" : "bg-gray-400"}`}
							/>
							<span className="text-muted-foreground text-xs">
								{isConnected ? "Live" : "Offline"}
							</span>
						</div>
					</div>
				</DialogHeader>

				<div className="space-y-6">
					{/* Order Status */}
					<div className="flex items-center justify-between rounded-lg border p-4">
						<div className="flex items-center gap-3">
							<Clock className="h-5 w-5 text-muted-foreground" />
							<div>
								<p className="font-medium text-sm">Order Status</p>
								<Badge variant="default" className="mt-1">
									{formatStatus(order.status)}
								</Badge>
							</div>
						</div>
						{lastEvent && (
							<div className="text-right">
								<p className="text-muted-foreground text-xs">Last Update</p>
								<p className="text-xs">{formatEvent(lastEvent)}</p>
							</div>
						)}
					</div>

					{/* Driver Information */}
					{hasDriver ? (
						<div className="rounded-lg border p-4">
							<h3 className="mb-3 font-semibold text-sm">Driver Information</h3>
							<div className="grid gap-3 md:grid-cols-2">
								<div className="flex items-center gap-3">
									<User className="h-4 w-4 text-muted-foreground" />
									<div>
										<p className="text-muted-foreground text-xs">Name</p>
										<p className="font-medium text-sm">
											{order.driver?.user?.name || "Driver"}
										</p>
									</div>
								</div>
								{order.driver?.rating && (
									<div className="flex items-center gap-3">
										<Star className="h-4 w-4 text-muted-foreground" />
										<div>
											<p className="text-muted-foreground text-xs">Rating</p>
											<p className="font-medium text-sm">
												{order.driver.rating.toFixed(1)} ⭐
											</p>
										</div>
									</div>
								)}
								{order.driver?.licensePlate && (
									<div className="flex items-center gap-3">
										<CheckCircle2 className="h-4 w-4 text-muted-foreground" />
										<div>
											<p className="text-muted-foreground text-xs">Vehicle</p>
											<p className="font-medium text-sm">
												{order.driver.licensePlate}
											</p>
										</div>
									</div>
								)}
							</div>
						</div>
					) : (
						<div className="flex items-center justify-center rounded-lg border p-8">
							<div className="text-center">
								<User className="mx-auto mb-2 h-12 w-12 text-muted-foreground" />
								<p className="font-medium">Searching for driver...</p>
								<p className="text-muted-foreground text-sm">
									We're finding the best driver for you
								</p>
							</div>
						</div>
					)}

					{/* Live Map */}
					{order.pickupLocation && order.dropoffLocation ? (
						<LiveTrackingMap
							pickup={toLocation(order.pickupLocation)}
							delivery={toLocation(order.dropoffLocation)}
							driverLocation={driverLocation}
							driverName={order.driver?.user?.name}
							orderStatus={order.status}
							distance={
								order.distanceKm
									? `${order.distanceKm.toFixed(1)} km`
									: undefined
							}
						/>
					) : (
						<div className="flex items-center justify-center rounded-lg border p-8">
							<MapPin className="mr-2 h-5 w-5 text-muted-foreground" />
							<p className="text-muted-foreground">
								Location information unavailable
							</p>
						</div>
					)}

					{/* Order Details */}
					<div className="grid gap-4 md:grid-cols-2">
						<div className="rounded-lg border p-4">
							<h4 className="mb-2 font-semibold text-sm">Pickup</h4>
							<p className="text-muted-foreground text-sm">
								{order.note?.pickup || "Address not available"}
							</p>
						</div>
						<div className="rounded-lg border p-4">
							<h4 className="mb-2 font-semibold text-sm">Delivery</h4>
							<p className="text-muted-foreground text-sm">
								{order.note?.dropoff || "Address not available"}
							</p>
						</div>
					</div>

					{/* Action Button */}
					<Button
						variant="outline"
						onClick={() => onOpenChange(false)}
						className="w-full"
					>
						Close Tracking
					</Button>
				</div>
			</DialogContent>
		</Dialog>
	);
};

const formatStatus = (status: string): string => {
	const statusMap: Record<string, string> = {
		REQUESTED: "Requested",
		MATCHING: "Finding Driver",
		ACCEPTED: "Driver Assigned",
		PREPARING: "Being Prepared",
		READY_FOR_PICKUP: "Ready for Pickup",
		ARRIVING: "Driver Arriving",
		IN_TRIP: "On the Way",
		COMPLETED: "Delivered",
		CANCELLED_BY_USER: "Cancelled",
		CANCELLED_BY_DRIVER: "Cancelled by Driver",
		CANCELLED_BY_SYSTEM: "Cancelled",
	};
	return statusMap[status] || status;
};

const formatEvent = (event: string): string => {
	const eventMap: Record<string, string> = {
		MATCHING: "Searching driver",
		OFFER: "Offer sent to drivers",
		DRIVER_ACCEPTED: "Driver accepted",
		DRIVER_LOCATION_UPDATE: "Location updated",
		COMPLETED: "Order completed",
		CANCELED: "Order cancelled",
		UNAVAILABLE: "Driver unavailable",
		CHAT_MESSAGE: "New message",
	};
	return eventMap[event] || event;
};

/**
 * Loading skeleton for tracking dialog
 */
export const LiveTrackingDialogSkeleton = () => {
	return (
		<div className="space-y-6">
			<Skeleton className="h-20 w-full" />
			<Skeleton className="h-32 w-full" />
			<Skeleton className="h-[500px] w-full" />
			<div className="grid gap-4 md:grid-cols-2">
				<Skeleton className="h-20 w-full" />
				<Skeleton className="h-20 w-full" />
			</div>
		</div>
	);
};
