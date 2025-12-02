import { zodResolver } from "@hookform/resolvers/zod";
import {
	DeliveryPricingConfigurationSchema,
	FoodPricingConfigurationSchema,
	RidePricingConfigurationSchema,
} from "@repo/schema/configuration";
import { useMutation, useQuery } from "@tanstack/react-query";
import { Loader2 } from "lucide-react";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import type * as z from "zod";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { orpcClient, queryClient } from "@/lib/orpc";

const CONFIGURATION_KEYS = {
	RIDE: "ride-service-pricing",
	DELIVERY: "delivery-service-pricing",
	FOOD: "food-service-pricing",
} as const;

type RidePricing = z.infer<typeof RidePricingConfigurationSchema>;
type DeliveryPricing = z.infer<typeof DeliveryPricingConfigurationSchema>;
type FoodPricing = z.infer<typeof FoodPricingConfigurationSchema>;

export function PricingConfiguration() {
	const [activeTab, setActiveTab] = useState<"ride" | "delivery" | "food">(
		"ride",
	);

	return (
		<Tabs
			value={activeTab}
			onValueChange={(v) => setActiveTab(v as typeof activeTab)}
			className="w-full"
		>
			<TabsList className="grid w-full grid-cols-3">
				<TabsTrigger value="ride">Ride</TabsTrigger>
				<TabsTrigger value="delivery">Delivery</TabsTrigger>
				<TabsTrigger value="food">Food</TabsTrigger>
			</TabsList>

			<TabsContent value="ride" className="space-y-4">
				<RidePricingForm />
			</TabsContent>

			<TabsContent value="delivery" className="space-y-4">
				<DeliveryPricingForm />
			</TabsContent>

			<TabsContent value="food" className="space-y-4">
				<FoodPricingForm />
			</TabsContent>
		</Tabs>
	);
}

function RidePricingForm() {
	const { data: config, isLoading } = useQuery({
		queryKey: ["configuration", CONFIGURATION_KEYS.RIDE],
		queryFn: async () => {
			const result = await orpcClient.configuration.get({
				params: { key: CONFIGURATION_KEYS.RIDE },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	const form = useForm<RidePricing>({
		// biome-ignore lint/suspicious/noExplicitAny: Required for zodResolver type compatibility with z.coerce
		resolver: zodResolver(RidePricingConfigurationSchema) as any,
		defaultValues: {
			baseFare: 0,
			perKmRate: 0,
			minimumFare: 0,
			platformFeeRate: 0,
			taxRate: 0,
		},
	});

	useEffect(() => {
		if (config?.value) {
			form.reset(config.value as RidePricing);
		}
	}, [config, form]);

	const mutation = useMutation({
		mutationFn: async (data: RidePricing) => {
			const result = await orpcClient.configuration.update({
				params: { key: CONFIGURATION_KEYS.RIDE },
				body: { value: data },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({
				queryKey: ["configuration", CONFIGURATION_KEYS.RIDE],
			});
			toast.success("Ride pricing updated successfully");
		},
		onError: (error: Error) => {
			toast.error(error.message || "Failed to update ride pricing");
		},
	});

	if (isLoading) {
		return (
			<div className="flex items-center justify-center py-12">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit((data) => mutation.mutate(data))}
				className="space-y-6"
			>
				<Card>
					<CardHeader>
						<CardTitle>Ride Service Pricing</CardTitle>
						<CardDescription>
							Configure pricing parameters for ride services
						</CardDescription>
					</CardHeader>
					<CardContent className="space-y-4">
						<div className="grid grid-cols-1 gap-4 md:grid-cols-2">
							<FormField
								control={form.control}
								name="baseFare"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Base Fare (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="5000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="perKmRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Per Km Rate (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="3000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="minimumFare"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Minimum Fare (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="8000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="platformFeeRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Platform Fee Rate</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="0.05"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="taxRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Tax Rate</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="0.11"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
						</div>

						{/* Calculation Preview */}
						<Card className="bg-muted/50">
							<CardHeader>
								<CardTitle className="text-base">Calculation Preview</CardTitle>
								<CardDescription>
									Example: 5km ride with current rates
								</CardDescription>
							</CardHeader>
							<CardContent>
								<div className="space-y-2 text-sm">
									<div className="flex justify-between">
										<span className="text-muted-foreground">Base Fare:</span>
										<span className="font-medium">
											Rp {(form.watch("baseFare") || 0).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">
											Distance (5km):
										</span>
										<span className="font-medium">
											Rp {((form.watch("perKmRate") || 0) * 5).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between border-t pt-2">
										<span className="text-muted-foreground">Subtotal:</span>
										<span className="font-medium">
											Rp{" "}
											{(
												(form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5
											).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">
											Platform Fee (
											{((form.watch("platformFeeRate") || 0) * 100).toFixed(1)}
											%):
										</span>
										<span className="font-medium">
											Rp{" "}
											{(
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5) *
												(form.watch("platformFeeRate") || 0)
											).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">
											Tax ({((form.watch("taxRate") || 0) * 100).toFixed(1)}%):
										</span>
										<span className="font-medium">
											Rp{" "}
											{(
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5) *
												(form.watch("taxRate") || 0)
											).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between border-t pt-2 font-semibold">
										<span>Total Price:</span>
										<span>
											Rp{" "}
											{(
												(form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5 +
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5) *
													(form.watch("platformFeeRate") || 0) +
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5) *
													(form.watch("taxRate") || 0)
											).toLocaleString()}
										</span>
									</div>
								</div>
							</CardContent>
						</Card>

						<div className="flex justify-end">
							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending && (
									<Loader2 className="mr-2 h-4 w-4 animate-spin" />
								)}
								Save Changes
							</Button>
						</div>
					</CardContent>
				</Card>
			</form>
		</Form>
	);
}

function DeliveryPricingForm() {
	const { data: config, isLoading } = useQuery({
		queryKey: ["configuration", CONFIGURATION_KEYS.DELIVERY],
		queryFn: async () => {
			const result = await orpcClient.configuration.get({
				params: { key: CONFIGURATION_KEYS.DELIVERY },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	const form = useForm<DeliveryPricing>({
		// biome-ignore lint/suspicious/noExplicitAny: Required for zodResolver type compatibility with z.coerce
		resolver: zodResolver(DeliveryPricingConfigurationSchema) as any,
		defaultValues: {
			baseFare: 0,
			perKmRate: 0,
			perKgRate: 0,
			minimumFare: 0,
			platformFeeRate: 0,
			taxRate: 0,
		},
	});

	useEffect(() => {
		if (config?.value) {
			form.reset(config.value as DeliveryPricing);
		}
	}, [config, form]);

	const mutation = useMutation({
		mutationFn: async (data: DeliveryPricing) => {
			const result = await orpcClient.configuration.update({
				params: { key: CONFIGURATION_KEYS.DELIVERY },
				body: { value: data },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({
				queryKey: ["configuration", CONFIGURATION_KEYS.DELIVERY],
			});
			toast.success("Delivery pricing updated successfully");
		},
		onError: (error: Error) => {
			toast.error(error.message || "Failed to update delivery pricing");
		},
	});

	if (isLoading) {
		return (
			<div className="flex items-center justify-center py-12">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit((data) => mutation.mutate(data))}
				className="space-y-6"
			>
				<Card>
					<CardHeader>
						<CardTitle>Delivery Service Pricing</CardTitle>
						<CardDescription>
							Configure pricing parameters for delivery services
						</CardDescription>
					</CardHeader>
					<CardContent className="space-y-4">
						<div className="grid grid-cols-1 gap-4 md:grid-cols-2">
							<FormField
								control={form.control}
								name="baseFare"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Base Fare (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="5000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="perKmRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Per Km Rate (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="3000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="perKgRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Per Kg Rate (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="2000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="minimumFare"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Minimum Fare (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="8000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="platformFeeRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Platform Fee Rate</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="0.05"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="taxRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Tax Rate</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="0.11"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
						</div>

						{/* Calculation Preview */}
						<Card className="bg-muted/50">
							<CardHeader>
								<CardTitle className="text-base">Calculation Preview</CardTitle>
								<CardDescription>
									Example: 5km delivery, 3kg package with current rates
								</CardDescription>
							</CardHeader>
							<CardContent>
								<div className="space-y-2 text-sm">
									<div className="flex justify-between">
										<span className="text-muted-foreground">Base Fare:</span>
										<span className="font-medium">
											Rp {(form.watch("baseFare") || 0).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">
											Distance (5km):
										</span>
										<span className="font-medium">
											Rp {((form.watch("perKmRate") || 0) * 5).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">Weight (3kg):</span>
										<span className="font-medium">
											Rp {((form.watch("perKgRate") || 0) * 3).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between border-t pt-2">
										<span className="text-muted-foreground">Subtotal:</span>
										<span className="font-medium">
											Rp{" "}
											{(
												(form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5 +
												(form.watch("perKgRate") || 0) * 3
											).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">
											Platform Fee (
											{((form.watch("platformFeeRate") || 0) * 100).toFixed(1)}
											%):
										</span>
										<span className="font-medium">
											Rp{" "}
											{(
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5 +
													(form.watch("perKgRate") || 0) * 3) *
												(form.watch("platformFeeRate") || 0)
											).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground">
											Tax ({((form.watch("taxRate") || 0) * 100).toFixed(1)}%):
										</span>
										<span className="font-medium">
											Rp{" "}
											{(
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5 +
													(form.watch("perKgRate") || 0) * 3) *
												(form.watch("taxRate") || 0)
											).toLocaleString()}
										</span>
									</div>
									<div className="flex justify-between border-t pt-2 font-semibold">
										<span>Total Price:</span>
										<span>
											Rp{" "}
											{(
												(form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5 +
												(form.watch("perKgRate") || 0) * 3 +
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5 +
													(form.watch("perKgRate") || 0) * 3) *
													(form.watch("platformFeeRate") || 0) +
												((form.watch("baseFare") || 0) +
													(form.watch("perKmRate") || 0) * 5 +
													(form.watch("perKgRate") || 0) * 3) *
													(form.watch("taxRate") || 0)
											).toLocaleString()}
										</span>
									</div>
								</div>
							</CardContent>
						</Card>

						<div className="flex justify-end">
							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending && (
									<Loader2 className="mr-2 h-4 w-4 animate-spin" />
								)}
								Save Changes
							</Button>
						</div>
					</CardContent>
				</Card>
			</form>
		</Form>
	);
}

function FoodPricingForm() {
	const { data: config, isLoading } = useQuery({
		queryKey: ["configuration", CONFIGURATION_KEYS.FOOD],
		queryFn: async () => {
			const result = await orpcClient.configuration.get({
				params: { key: CONFIGURATION_KEYS.FOOD },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	const form = useForm<FoodPricing>({
		// biome-ignore lint/suspicious/noExplicitAny: Required for zodResolver type compatibility with z.coerce
		resolver: zodResolver(FoodPricingConfigurationSchema) as any,
		defaultValues: {
			baseFare: 0,
			perKmRate: 0,
			minimumFare: 0,
			platformFeeRate: 0,
			taxRate: 0,
		},
	});

	useEffect(() => {
		if (config?.value) {
			form.reset(config.value as FoodPricing);
		}
	}, [config, form]);

	const mutation = useMutation({
		mutationFn: async (data: FoodPricing) => {
			const result = await orpcClient.configuration.update({
				params: { key: CONFIGURATION_KEYS.FOOD },
				body: { value: data },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({
				queryKey: ["configuration", CONFIGURATION_KEYS.FOOD],
			});
			toast.success("Food pricing updated successfully");
		},
		onError: (error: Error) => {
			toast.error(error.message || "Failed to update food pricing");
		},
	});

	if (isLoading) {
		return (
			<div className="flex items-center justify-center py-12">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit((data) => mutation.mutate(data))}
				className="space-y-6"
			>
				<Card>
					<CardHeader>
						<CardTitle>Food Service Pricing</CardTitle>
						<CardDescription>
							Configure pricing parameters for food delivery services
						</CardDescription>
					</CardHeader>
					<CardContent className="space-y-4">
						<div className="grid grid-cols-1 gap-4 md:grid-cols-2">
							<FormField
								control={form.control}
								name="baseFare"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Base Fare (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="5000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="perKmRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Per Km Rate (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="3000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="minimumFare"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Minimum Fare (IDR)</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="8000"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="platformFeeRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Platform Fee Rate</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="0.05"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="taxRate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Tax Rate</FormLabel>
										<FormControl>
											<Input
												type="number"
												step="0.01"
												placeholder="0.11"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
						</div>

						{/* Calculation Preview */}
						<Card className="bg-muted/50">
							<CardHeader>
								<CardTitle className="text-sm">Calculation Preview</CardTitle>
								<CardDescription className="text-xs">
									Example: 5km delivery + IDR 50,000 food order
								</CardDescription>
							</CardHeader>
							<CardContent className="space-y-2 text-sm">
								<div className="flex justify-between">
									<span className="text-muted-foreground">Base Fare:</span>
									<span className="font-mono">
										IDR {form.watch("baseFare")?.toLocaleString() || 0}
									</span>
								</div>
								<div className="flex justify-between">
									<span className="text-muted-foreground">
										Distance (5km × IDR {form.watch("perKmRate") || 0}):
									</span>
									<span className="font-mono">
										IDR {((form.watch("perKmRate") || 0) * 5).toLocaleString()}
									</span>
								</div>
								<div className="flex justify-between">
									<span className="text-muted-foreground">Food Subtotal:</span>
									<span className="font-mono">IDR 50,000</span>
								</div>
								<div className="flex justify-between border-t pt-2">
									<span className="text-muted-foreground">Subtotal:</span>
									<span className="font-mono">
										IDR{" "}
										{(
											(form.watch("baseFare") || 0) +
											(form.watch("perKmRate") || 0) * 5 +
											50000
										).toLocaleString()}
									</span>
								</div>
								<div className="flex justify-between">
									<span className="text-muted-foreground">
										Platform Fee (
										{((form.watch("platformFeeRate") || 0) * 100).toFixed(1)}%):
									</span>
									<span className="font-mono">
										IDR{" "}
										{(
											((form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5 +
												50000) *
											(form.watch("platformFeeRate") || 0)
										).toLocaleString()}
									</span>
								</div>
								<div className="flex justify-between">
									<span className="text-muted-foreground">
										Tax ({((form.watch("taxRate") || 0) * 100).toFixed(1)}%):
									</span>
									<span className="font-mono">
										IDR{" "}
										{(
											((form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5 +
												50000) *
											(form.watch("taxRate") || 0)
										).toLocaleString()}
									</span>
								</div>
								<div className="flex justify-between border-t pt-2 font-semibold">
									<span>Total Price:</span>
									<span className="font-mono">
										IDR{" "}
										{Math.max(
											((form.watch("baseFare") || 0) +
												(form.watch("perKmRate") || 0) * 5 +
												50000) *
												(1 +
													(form.watch("platformFeeRate") || 0) +
													(form.watch("taxRate") || 0)),
											form.watch("minimumFare") || 0,
										).toLocaleString()}
									</span>
								</div>
								{Math.max(
									((form.watch("baseFare") || 0) +
										(form.watch("perKmRate") || 0) * 5 +
										50000) *
										(1 +
											(form.watch("platformFeeRate") || 0) +
											(form.watch("taxRate") || 0)),
									form.watch("minimumFare") || 0,
								) === (form.watch("minimumFare") || 0) && (
									<p className="pt-2 text-amber-600 text-xs dark:text-amber-500">
										* Minimum fare applied
									</p>
								)}
							</CardContent>
						</Card>

						<div className="flex justify-end">
							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending && (
									<Loader2 className="mr-2 h-4 w-4 animate-spin" />
								)}
								Save Changes
							</Button>
						</div>
					</CardContent>
				</Card>
			</form>
		</Form>
	);
}
