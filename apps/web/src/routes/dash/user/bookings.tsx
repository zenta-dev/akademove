import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Calculator, CreditCard, Loader2, MapPin } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Separator } from "@/components/ui/separator";
import { Textarea } from "@/components/ui/textarea";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/user/bookings")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.USER.BOOKINGS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["USER"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();
	if (!allowed) navigate({ to: "/" });

	const [orderType, setOrderType] = useState<"RIDE" | "DELIVERY" | "FOOD">(
		"RIDE",
	);
	const [pickupAddress, setPickupAddress] = useState("");
	const [dropoffAddress, setDropoffAddress] = useState("");
	const [paymentMethod, setPaymentMethod] = useState("wallet");
	const [genderPreference, setGenderPreference] = useState<"SAME" | "ANY">(
		"ANY",
	);
	const [pickupNotes, setPickupNotes] = useState("");
	const [dropoffNotes, setDropoffNotes] = useState("");
	const [specialInstructions, setSpecialInstructions] = useState("");
	const [isEstimating, setIsEstimating] = useState(false);
	const [isPlacingOrder, setIsPlacingOrder] = useState(false);
	const [orderSummary, setOrderSummary] = useState<{
		distanceKm: number;
		baseFare: number;
		distanceFare: number;
		additionalFares: number;
		totalCost: number;
	} | null>(null);

	const isDelivery = orderType === "DELIVERY" || orderType === "FOOD";

	const handleEstimate = async () => {
		if (!pickupAddress || !dropoffAddress) {
			toast.error("Please enter both pickup and dropoff addresses");
			return;
		}

		setIsEstimating(true);
		try {
			// Mock estimation for now - would call actual API
			await new Promise((resolve) => setTimeout(resolve, 1500));
			setOrderSummary({
				distanceKm: 5.2,
				baseFare: 5000,
				distanceFare: 7800,
				additionalFares: isDelivery ? 2000 : 0,
				totalCost: isDelivery ? 14800 : 12800,
			});
			toast.success("Order estimated successfully");
		} catch (_error) {
			toast.error("Failed to estimate order");
		} finally {
			setIsEstimating(false);
		}
	};

	const handlePlaceOrder = async () => {
		if (!pickupAddress || !dropoffAddress) {
			toast.error("Please enter both pickup and dropoff addresses");
			return;
		}

		if (!orderSummary) {
			toast.error("Please estimate order first");
			return;
		}

		setIsPlacingOrder(true);
		try {
			// Mock order placement for now - would call actual API
			await new Promise((resolve) => setTimeout(resolve, 2000));
			toast.success("Order placed successfully!");
			// Navigate to order history or tracking
			navigate({
				to: "/dash/user/history",
				search: { limit: 15, page: 1, order: "desc", mode: "offset" },
			});
		} catch (_error) {
			toast.error("Failed to place order");
		} finally {
			setIsPlacingOrder(false);
		}
	};

	return (
		<div className="space-y-6">
			<div>
				<h2 className="font-medium text-xl">{m.bookings()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>

			<div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
				{/* Main Form */}
				<div className="space-y-6 lg:col-span-2">
					{/* Order Type Selection */}
					<Card>
						<CardHeader>
							<CardTitle className="flex items-center gap-2">
								<Calculator className="h-5 w-5" />
								Order Type
							</CardTitle>
							<CardDescription>
								Choose what type of service you need
							</CardDescription>
						</CardHeader>
						<CardContent>
							<RadioGroup
								value={orderType}
								onValueChange={(value) =>
									setOrderType(value as "RIDE" | "DELIVERY" | "FOOD")
								}
								className="grid grid-cols-3 gap-4"
							>
								<div className="flex items-center space-x-2">
									<RadioGroupItem value="RIDE" id="ride" />
									<Label htmlFor="ride" className="cursor-pointer">
										<div className="text-center">
											<div className="font-medium">Ride</div>
											<div className="text-muted-foreground text-xs">
												Transport
											</div>
										</div>
									</Label>
								</div>
								<div className="flex items-center space-x-2">
									<RadioGroupItem value="DELIVERY" id="delivery" />
									<Label htmlFor="delivery" className="cursor-pointer">
										<div className="text-center">
											<div className="font-medium">Delivery</div>
											<div className="text-muted-foreground text-xs">
												Package
											</div>
										</div>
									</Label>
								</div>
								<div className="flex items-center space-x-2">
									<RadioGroupItem value="FOOD" id="food" />
									<Label htmlFor="food" className="cursor-pointer">
										<div className="text-center">
											<div className="font-medium">Food</div>
											<div className="text-muted-foreground text-xs">Meal</div>
										</div>
									</Label>
								</div>
							</RadioGroup>
						</CardContent>
					</Card>

					{/* Location Selection */}
					<Card>
						<CardHeader>
							<CardTitle className="flex items-center gap-2">
								<MapPin className="h-5 w-5" />
								Locations
							</CardTitle>
							<CardDescription>
								Enter pickup and dropoff addresses
							</CardDescription>
						</CardHeader>
						<CardContent className="space-y-4">
							<div>
								<Label htmlFor="pickup">Pickup Address</Label>
								<Input
									id="pickup"
									placeholder="Enter pickup location"
									value={pickupAddress}
									onChange={(e) => setPickupAddress(e.target.value)}
								/>
							</div>
							<div>
								<Label htmlFor="dropoff">Dropoff Address</Label>
								<Input
									id="dropoff"
									placeholder="Enter dropoff location"
									value={dropoffAddress}
									onChange={(e) => setDropoffAddress(e.target.value)}
								/>
							</div>
						</CardContent>
					</Card>

					{/* Order Details */}
					<Card>
						<CardHeader>
							<CardTitle>Order Details</CardTitle>
							<CardDescription>
								Additional information for your order
							</CardDescription>
						</CardHeader>
						<CardContent className="space-y-4">
							{/* Gender Preference */}
							<div>
								<Label>Driver Gender Preference</Label>
								<Select
									value={genderPreference}
									onValueChange={(value) =>
										setGenderPreference(value as "SAME" | "ANY")
									}
								>
									<SelectTrigger>
										<SelectValue />
									</SelectTrigger>
									<SelectContent>
										<SelectItem value="ANY">No Preference</SelectItem>
										<SelectItem value="SAME">Same Gender</SelectItem>
									</SelectContent>
								</Select>
							</div>

							{/* Notes */}
							<div className="space-y-3">
								<Label>Order Notes</Label>
								<div>
									<Label htmlFor="pickup-notes" className="text-sm">
										Pickup Notes
									</Label>
									<Textarea
										id="pickup-notes"
										placeholder="e.g., Meet at the main entrance"
										value={pickupNotes}
										onChange={(e) => setPickupNotes(e.target.value)}
									/>
								</div>
								<div>
									<Label htmlFor="dropoff-notes" className="text-sm">
										Dropoff Notes
									</Label>
									<Textarea
										id="dropoff-notes"
										placeholder="e.g., Ring doorbell when arrived"
										value={dropoffNotes}
										onChange={(e) => setDropoffNotes(e.target.value)}
									/>
								</div>
								{isDelivery && (
									<div>
										<Label htmlFor="instructions" className="text-sm">
											Special Instructions
										</Label>
										<Textarea
											id="instructions"
											placeholder="Any special handling instructions"
											value={specialInstructions}
											onChange={(e) => setSpecialInstructions(e.target.value)}
										/>
									</div>
								)}
							</div>
						</CardContent>
					</Card>
				</div>

				{/* Sidebar */}
				<div className="space-y-6">
					{/* Payment Method */}
					<Card>
						<CardHeader>
							<CardTitle className="flex items-center gap-2">
								<CreditCard className="h-5 w-5" />
								Payment Method
							</CardTitle>
						</CardHeader>
						<CardContent>
							<Select value={paymentMethod} onValueChange={setPaymentMethod}>
								<SelectTrigger>
									<SelectValue placeholder="Select payment method" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="wallet">Wallet</SelectItem>
									<SelectItem value="QRIS">QRIS</SelectItem>
									<SelectItem value="BANK_TRANSFER">Bank Transfer</SelectItem>
								</SelectContent>
							</Select>
						</CardContent>
					</Card>

					{/* Order Summary */}
					<Card>
						<CardHeader>
							<CardTitle>Order Summary</CardTitle>
							<CardDescription>Review your order details</CardDescription>
						</CardHeader>
						<CardContent className="space-y-4">
							{!orderSummary ? (
								<div className="py-4 text-center">
									<p className="text-muted-foreground text-sm">
										Enter addresses and click "Estimate Order" to see pricing
									</p>
								</div>
							) : (
								<div className="space-y-3">
									<div className="flex justify-between">
										<span className="text-sm">Distance</span>
										<span className="font-medium text-sm">
											{orderSummary.distanceKm.toFixed(1)} km
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-sm">Base Fare</span>
										<span className="font-medium text-sm">
											Rp {orderSummary.baseFare.toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-sm">Distance Fare</span>
										<span className="font-medium text-sm">
											Rp {orderSummary.distanceFare.toLocaleString()}
										</span>
									</div>
									{orderSummary.additionalFares > 0 && (
										<div className="flex justify-between">
											<span className="text-sm">Additional Fees</span>
											<span className="font-medium text-sm">
												Rp {orderSummary.additionalFares.toLocaleString()}
											</span>
										</div>
									)}
									<Separator />
									<div className="flex justify-between">
										<span className="font-medium">Total</span>
										<span className="font-bold text-lg">
											Rp {orderSummary.totalCost.toLocaleString()}
										</span>
									</div>
								</div>
							)}

							<div className="space-y-2 pt-4">
								<Button
									onClick={handleEstimate}
									disabled={!pickupAddress || !dropoffAddress || isEstimating}
									variant="outline"
									className="w-full"
								>
									{isEstimating ? (
										<Loader2 className="mr-2 h-4 w-4 animate-spin" />
									) : null}
									Estimate Order
								</Button>
								<Button
									onClick={handlePlaceOrder}
									disabled={!orderSummary || isPlacingOrder}
									className="w-full"
								>
									{isPlacingOrder ? (
										<Loader2 className="mr-2 h-4 w-4 animate-spin" />
									) : null}
									Place Order
								</Button>
							</div>
						</CardContent>
					</Card>
				</div>
			</div>
		</div>
	);
}
