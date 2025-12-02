import { zodResolver } from "@hookform/resolvers/zod";
import { CommissionConfigurationSchema } from "@repo/schema/configuration";
import { useMutation, useQuery } from "@tanstack/react-query";
import { useEffect } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import type { z } from "zod";
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
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Progress } from "@/components/ui/progress";
import { orpcClient, queryClient } from "@/lib/orpc";

type CommissionFormData = z.infer<typeof CommissionConfigurationSchema>;

const COMMISSION_CONFIG_KEY = "commission-rates";

export function CommissionConfiguration() {
	const form = useForm<CommissionFormData>({
		// biome-ignore lint/suspicious/noExplicitAny: Required for zodResolver type compatibility with z.coerce
		resolver: zodResolver(CommissionConfigurationSchema) as any,
		defaultValues: {
			rideCommissionRate: 0.15,
			deliveryCommissionRate: 0.15,
			foodCommissionRate: 0.2,
			merchantCommissionRate: 0.1,
		},
	});

	// Fetch commission configuration
	const { data: configData, isLoading } = useQuery({
		queryKey: ["configuration", COMMISSION_CONFIG_KEY],
		queryFn: async () => {
			const result = await orpcClient.configuration.get({
				params: { key: COMMISSION_CONFIG_KEY },
			});
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result.body.data;
		},
	});

	// Reset form when data loads
	useEffect(() => {
		if (configData?.value) {
			form.reset(configData.value as CommissionFormData);
		}
	}, [configData, form]);

	// Update mutation
	const updateMutation = useMutation({
		mutationFn: async (variables: {
			params: { key: string };
			body: { value?: unknown };
		}) => {
			const result = await orpcClient.configuration.update(variables);
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result;
		},
		onSuccess: () => {
			queryClient.invalidateQueries({
				queryKey: ["configuration", COMMISSION_CONFIG_KEY],
			});
			toast.success("Commission rates updated successfully");
		},
		onError: (error: Error) => {
			toast.error(`Failed to update: ${error.message}`);
		},
	});

	const onSubmit = (data: CommissionFormData) => {
		updateMutation.mutate({
			params: { key: COMMISSION_CONFIG_KEY },
			body: { value: data },
		});
	};

	if (isLoading) {
		return (
			<div className="flex items-center justify-center py-12">
				<p className="text-muted-foreground text-sm">Loading...</p>
			</div>
		);
	}

	const watchedValues = form.watch();

	return (
		<Card>
			<CardHeader>
				<CardTitle>Commission Rates</CardTitle>
				<CardDescription>
					Configure platform and merchant commission rates for different service
					types
				</CardDescription>
			</CardHeader>
			<CardContent>
				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
						{/* Ride Commission */}
						<FormField
							control={form.control}
							name="rideCommissionRate"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Ride Commission Rate</FormLabel>
									<FormControl>
										<div className="space-y-2">
											<div className="flex items-center gap-4">
												<Input
													type="number"
													step="0.01"
													min="0"
													max="1"
													placeholder="0.15"
													{...field}
													onChange={(e) =>
														field.onChange(Number.parseFloat(e.target.value))
													}
												/>
												<span className="min-w-[4rem] text-right font-medium text-sm">
													{(
														(watchedValues.rideCommissionRate || 0) * 100
													).toFixed(1)}
													%
												</span>
											</div>
											<Progress
												value={(watchedValues.rideCommissionRate || 0) * 100}
												className="h-2"
											/>
										</div>
									</FormControl>
									<FormDescription>
										Platform commission for ride orders (0-1, e.g., 0.15 for
										15%)
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>

						{/* Delivery Commission */}
						<FormField
							control={form.control}
							name="deliveryCommissionRate"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Delivery Commission Rate</FormLabel>
									<FormControl>
										<div className="space-y-2">
											<div className="flex items-center gap-4">
												<Input
													type="number"
													step="0.01"
													min="0"
													max="1"
													placeholder="0.15"
													{...field}
													onChange={(e) =>
														field.onChange(Number.parseFloat(e.target.value))
													}
												/>
												<span className="min-w-[4rem] text-right font-medium text-sm">
													{(
														(watchedValues.deliveryCommissionRate || 0) * 100
													).toFixed(1)}
													%
												</span>
											</div>
											<Progress
												value={
													(watchedValues.deliveryCommissionRate || 0) * 100
												}
												className="h-2"
											/>
										</div>
									</FormControl>
									<FormDescription>
										Platform commission for delivery orders (0-1, e.g., 0.15 for
										15%)
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>

						{/* Food Commission */}
						<FormField
							control={form.control}
							name="foodCommissionRate"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Food Commission Rate</FormLabel>
									<FormControl>
										<div className="space-y-2">
											<div className="flex items-center gap-4">
												<Input
													type="number"
													step="0.01"
													min="0"
													max="1"
													placeholder="0.20"
													{...field}
													onChange={(e) =>
														field.onChange(Number.parseFloat(e.target.value))
													}
												/>
												<span className="min-w-[4rem] text-right font-medium text-sm">
													{(
														(watchedValues.foodCommissionRate || 0) * 100
													).toFixed(1)}
													%
												</span>
											</div>
											<Progress
												value={(watchedValues.foodCommissionRate || 0) * 100}
												className="h-2"
											/>
										</div>
									</FormControl>
									<FormDescription>
										Platform commission for food orders (0-1, e.g., 0.20 for
										20%)
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>

						{/* Merchant Commission */}
						<FormField
							control={form.control}
							name="merchantCommissionRate"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Merchant Commission Rate</FormLabel>
									<FormControl>
										<div className="space-y-2">
											<div className="flex items-center gap-4">
												<Input
													type="number"
													step="0.01"
													min="0"
													max="1"
													placeholder="0.10"
													{...field}
													onChange={(e) =>
														field.onChange(Number.parseFloat(e.target.value))
													}
												/>
												<span className="min-w-[4rem] text-right font-medium text-sm">
													{(
														(watchedValues.merchantCommissionRate || 0) * 100
													).toFixed(1)}
													%
												</span>
											</div>
											<Progress
												value={
													(watchedValues.merchantCommissionRate || 0) * 100
												}
												className="h-2"
											/>
										</div>
									</FormControl>
									<FormDescription>
										Merchant commission on food orders (0-1, e.g., 0.10 for 10%)
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>

						<Button type="submit" disabled={updateMutation.isPending}>
							{updateMutation.isPending ? "Saving..." : "Save Changes"}
						</Button>
					</form>
				</Form>
			</CardContent>
		</Card>
	);
}
