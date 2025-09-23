import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { capitalizeFirstLetter } from "better-auth";
import { BikeIcon, PackageIcon, PizzaIcon, Save } from "lucide-react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import {
	type UpdatePricing,
	UpdatePricingSchema,
} from "@/components/schema/pricing";
import { Submitting } from "@/components/submitting";
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
import { orpcQuery, queryClient } from "@/lib/client/orpc";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
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
	},
];

type Configuration = (typeof CONFIGURATIONS)[number];

export const Route = createFileRoute("/{-$lang}/dash/operator/pricing")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.PRICING }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			pricing: ["get", "update"],
		});
		if (!ok) redirect({ to: "/{-$lang}", throw: true });
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
	if (!allowed) navigate({ to: "/{-$lang}" });

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
const DEFAULT_VALUES: UpdatePricing = {
	price_per_km: 5000,
	commission: 5,
};

const EXAMPLE_KM = 5;

export function ConfigurationItem({
	key,
	name,
	icon: CustomIcon,
	textColor,
	bgColor,
}: Configuration) {
	const pricing = useQuery(
		orpcQuery.configuration.get.queryOptions({
			input: { params: { key } },
		}),
	);

	const form = useForm<UpdatePricing>({
		resolver: zodResolver(UpdatePricingSchema),
		defaultValues: DEFAULT_VALUES,
		values: pricing.data
			? {
					price_per_km: pricing.data.body.data.value.price_per_km,
					commission: pricing.data.body.data.value.commission,
				}
			: DEFAULT_VALUES,
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
						description: error.message || m.an_unexpected_error_occured(),
					},
				);
			},
		}),
	);

	const onSubmit = (values: UpdatePricing) =>
		mutation.mutateAsync({ params: { key }, body: { value: values } });

	const pricePerKm = form.watch("price_per_km") || 0;
	const commissionPercent = form.watch("commission") || 0;

	const totalPrice = pricePerKm * EXAMPLE_KM;
	const commissionRate =
		commissionPercent > 1 ? commissionPercent / 100 : commissionPercent;
	const driverReceives = totalPrice * (1 - commissionRate);

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
						<CardContent>
							<div className="grid grid-cols-1 gap-2 md:grid-cols-2">
								{(["price_per_km", "commission"] as const).map((fieldName) => (
									<FormField
										key={fieldName}
										control={form.control}
										name={fieldName}
										render={({ field }) => (
											<FormItem className="w-full">
												<FormLabel>
													{fieldName === "price_per_km"
														? m.price_per_km()
														: m.commission()}
												</FormLabel>
												<FormControl>
													{pricing.isPending ? (
														<Skeleton className="h-9 w-full" />
													) : (
														<Input
															{...field}
															type="number"
															disabled={mutation.isPending}
															onChange={(e) =>
																field.onChange(Number(e.target.value))
															}
															value={field.value}
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
								<Skeleton className="mt-4 h-20 w-full rounded-sm" />
							) : (
								<div className="mt-4 flex flex-col gap-2 rounded-sm bg-muted-foreground/5 p-2 text-gray-700 dark:text-gray-400">
									<p className="text-xs">Sample Fare ({EXAMPLE_KM} KM):</p>
									<p className="font-medium text-foreground text-md">
										Rp {totalPrice.toLocaleString("id-ID")}
									</p>
									<p className="font-medium text-foreground text-sm">
										<span className="text-gray-700 text-xs dark:text-gray-400">
											{m.driver_receives()} :
										</span>
										<span> Rp {driverReceives.toLocaleString("id-ID")}</span>
									</p>
								</div>
							)}
						</CardContent>
					</Card>
				</form>
			</Form>
		</TabsContent>
	);
}
