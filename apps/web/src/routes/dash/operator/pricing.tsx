import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	type DeliveryPricingConfiguration,
	type FoodPricingConfiguration,
	type PricingConfiguration,
	PricingConfigurationSchema,
	type RidePricingConfiguration,
} from "@repo/schema/configuration";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { BikeIcon, PackageIcon, PizzaIcon, Save } from "lucide-react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Skeleton } from "@/components/ui/skeleton";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const CONFIGURATIONS = [
	{
		key: "ride-service-pricing",
		name: m.ride_service(),
		icon: BikeIcon,
		textColor: "text-blue-500",
		bgColor: "bg-blue-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-blue-500",
				bgColor: "dark:data-[state=active]:bg-blue-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-blue-500",
				bgColor: "data-[state=active]:bg-blue-500/10",
			},
		},
		defaultValues: {
			baseFare: 0,
			perKmRate: 0,
			minimumFare: 0,
			platformFeeRate: 0,
			taxRate: 0,
		} satisfies RidePricingConfiguration,
		fields: [
			"baseFare",
			"perKmRate",
			"minimumFare",
			"platformFeeRate",
			"taxRate",
		] as const,
	},
	{
		key: "delivery-service-pricing",
		name: m.delivery_service(),
		icon: PackageIcon,
		textColor: "text-green-500",
		bgColor: "bg-green-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-green-500",
				bgColor: "dark:data-[state=active]:bg-green-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-green-500",
				bgColor: "data-[state=active]:bg-green-500/10",
			},
		},
		defaultValues: {
			baseFare: 0,
			perKmRate: 0,
			minimumFare: 0,
			platformFeeRate: 0,
			taxRate: 0,
			perKgRate: 0,
		} satisfies DeliveryPricingConfiguration,
		fields: [
			"baseFare",
			"perKmRate",
			"minimumFare",
			"platformFeeRate",
			"taxRate",
			"perKgRate",
		] as const,
	},
	{
		key: "food-service-pricing",
		name: m.food_service(),
		icon: PizzaIcon,
		textColor: "text-yellow-500",
		bgColor: "bg-yellow-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-yellow-500",
				bgColor: "dark:data-[state=active]:bg-yellow-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-yellow-500",
				bgColor: "data-[state=active]:bg-yellow-500/10",
			},
		},
		defaultValues: {
			baseFare: 0,
			perKmRate: 0,
			minimumFare: 0,
			platformFeeRate: 0,
			taxRate: 0,
		} satisfies FoodPricingConfiguration,
		fields: [
			"baseFare",
			"perKmRate",
			"minimumFare",
			"platformFeeRate",
			"taxRate",
		] as const,
	},
];

type Configuration = (typeof CONFIGURATIONS)[number];

export const Route = createFileRoute("/dash/operator/pricing")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.PRICING }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			configurations: ["get", "update"],
		});
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

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.pricing()}</h2>
				<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
			</div>
			<Tabs defaultValue={CONFIGURATIONS[0].key}>
				<div className="w-min rounded-xl border bg-card p-1">
					<TabsList className="flex bg-transparent">
						{CONFIGURATIONS.map((e) => (
							<TabsTrigger
								key={e.key}
								value={e.key}
								className={cn(
									"p-4",
									e.tab.light.bgColor,
									e.tab.light.textColor,
									e.tab.dark.bgColor,
									e.tab.dark.textColor,
								)}
							>
								<e.icon />
								{e.name}
							</TabsTrigger>
						))}
					</TabsList>
				</div>
				{CONFIGURATIONS.map(ConfigurationItem)}
			</Tabs>
		</>
	);
}

const EXAMPLE_KM = 5;
const EXAMPLE_KG = 2;

function getFieldLabel(fieldName: string) {
	const labels: Record<string, () => string> = {
		baseFare: () => m.base_fare?.() || "Base Fare",
		perKmRate: () => m.per_km_rate?.() || "Price per KM",
		minimumFare: () => m.minimum_fare?.() || "Minimum Fare",
		platformFeeRate: () => m.platform_fee_rate?.() || "Platform Fee Rate (%)",
		taxRate: () => m.tax_rate?.() || "Tax Rate (%)",
		perKgRate: () => m.per_kg_rate?.() || "Price per KG",
	};
	return labels[fieldName]?.() || fieldName;
}

export function ConfigurationItem({
	key,
	name,
	icon: CustomIcon,
	textColor,
	bgColor,
	defaultValues,
	fields,
}: Configuration) {
	const pricing = useQuery(
		orpcQuery.configuration.get.queryOptions({
			input: { params: { key } },
		}),
	);

	const form = useForm({
		resolver: zodResolver(PricingConfigurationSchema),
		defaultValues: defaultValues,
		values: pricing.data
			? {
					baseFare: pricing.data.body.data.value.baseFare,
					perKmRate: pricing.data.body.data.value.perKmRate,
					minimumFare: pricing.data.body.data.value.minimumFare,
					platformFeeRate: pricing.data.body.data.value.platformFeeRate,
					taxRate: pricing.data.body.data.value.taxRate,
					perKgRate: pricing.data.body.data.value.perKgRate,
				}
			: defaultValues,
	});

	const mutation = useMutation(
		orpcQuery.configuration.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries({
					queryKey: orpcQuery.configuration.get.queryKey({
						input: { params: { key } },
					}),
				});
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(m.update_pricing().toLowerCase()),
					}),
				);
				form.clearErrors();
			},
			onError: (error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.update_pricing().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const onSubmit = (values: PricingConfiguration) =>
		mutation.mutateAsync({ params: { key }, body: { value: values } });

	const formValues = form.watch();
	const baseFare = Number(formValues.baseFare) || 0;
	const perKmRate = Number(formValues.perKmRate) || 0;
	const minimumFare = Number(formValues.minimumFare) || 0;
	const platformFeeRate = Number(formValues.platformFeeRate) || 0;
	const taxRate = Number(formValues.taxRate) || 0;
	const perKgRate =
		"perKgRate" in formValues ? Number(formValues.perKgRate) || 0 : 0;

	let subtotal = baseFare + perKmRate * EXAMPLE_KM;
	if (key === "delivery-service-pricing") {
		subtotal += perKgRate * EXAMPLE_KG;
	}

	const platformFee = subtotal * (platformFeeRate / 100);
	const tax = subtotal * (taxRate / 100);
	const totalPrice = Math.max(subtotal + platformFee + tax, minimumFare);
	const driverReceives = subtotal - platformFee;

	return (
		<TabsContent key={key} value={key}>
			<Form {...form}>
				<form onSubmit={form.handleSubmit(onSubmit)}>
					<div className="flex items-center justify-between py-4">
						<div className="flex items-center gap-2">
							<div className={cn("rounded p-2", bgColor)}>
								<CustomIcon className={textColor} />
							</div>
							<div>
								<h5 className="font-medium text-xl">{name}</h5>
								<p className="text-muted-foreground">{m.sub_pricing_desc()}</p>
							</div>
						</div>
						<Button type="submit" disabled={mutation.isPending}>
							{mutation.isPending ? (
								<Submitting />
							) : (
								<>
									<Save />
									{m.save_changes()}
								</>
							)}
						</Button>
					</div>
					<Card>
						<CardContent className="pt-6">
							<div className="grid grid-cols-1 gap-4 md:grid-cols-2">
								{fields.map((fieldName) => (
									<FormField
										key={fieldName}
										control={form.control}
										name={fieldName}
										render={({ field }) => (
											<FormItem className="w-full">
												<FormLabel>{getFieldLabel(fieldName)}</FormLabel>
												<FormControl>
													{pricing.isPending ? (
														<Skeleton className="h-9 w-full" />
													) : (
														<Input
															type="number"
															step="0.01"
															disabled={mutation.isPending}
															onChange={(e) =>
																field.onChange(Number(e.target.value))
															}
															value={Number(field.value) || 0}
															onBlur={field.onBlur}
															name={field.name}
														/>
													)}
												</FormControl>
												<FormMessage />
											</FormItem>
										)}
									/>
								))}
							</div>
							{pricing.isPending ? (
								<Skeleton className="mt-4 h-32 w-full rounded-sm" />
							) : (
								<div className="mt-4 flex flex-col gap-2 rounded-sm bg-muted-foreground/5 p-4 text-gray-700 dark:text-gray-400">
									<p className="font-semibold text-xs uppercase">
										Sample Fare Calculation ({EXAMPLE_KM} KM
										{key === "delivery-service-pricing" && `, ${EXAMPLE_KG} KG`}
										)
									</p>
									<div className="space-y-1 text-sm">
										<div className="flex justify-between">
											<span>Base Fare:</span>
											<span>Rp {baseFare.toLocaleString("id-ID")}</span>
										</div>
										<div className="flex justify-between">
											<span>Distance ({EXAMPLE_KM} KM):</span>
											<span>
												Rp {(perKmRate * EXAMPLE_KM).toLocaleString("id-ID")}
											</span>
										</div>
										{key === "delivery-service-pricing" && (
											<div className="flex justify-between">
												<span>Weight ({EXAMPLE_KG} KG):</span>
												<span>
													Rp {(perKgRate * EXAMPLE_KG).toLocaleString("id-ID")}
												</span>
											</div>
										)}
										<div className="flex justify-between border-t pt-1">
											<span className="font-medium">Subtotal:</span>
											<span className="font-medium">
												Rp {subtotal.toLocaleString("id-ID")}
											</span>
										</div>
										<div className="flex justify-between text-xs">
											<span>Platform Fee ({platformFeeRate}%):</span>
											<span>Rp {platformFee.toLocaleString("id-ID")}</span>
										</div>
										<div className="flex justify-between text-xs">
											<span>Tax ({taxRate}%):</span>
											<span>Rp {tax.toLocaleString("id-ID")}</span>
										</div>
										<div className="flex justify-between border-t pt-1 font-medium text-foreground">
											<span>Total Price:</span>
											<span>Rp {totalPrice.toLocaleString("id-ID")}</span>
										</div>
										<div className="mt-2 flex justify-between border-t pt-2 font-medium text-foreground">
											<span>{m.driver_receives()}:</span>
											<span>Rp {driverReceives.toLocaleString("id-ID")}</span>
										</div>
									</div>
								</div>
							)}
						</CardContent>
					</Card>
				</form>
			</Form>
		</TabsContent>
	);
}
