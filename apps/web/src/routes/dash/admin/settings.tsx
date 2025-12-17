import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	type BusinessConfiguration,
	BusinessConfigurationSchema,
} from "@repo/schema/configuration";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	CalendarClockIcon,
	ClockIcon,
	GaugeIcon,
	MapPinIcon,
	PercentIcon,
	RadarIcon,
	Save,
	TrophyIcon,
	WalletIcon,
} from "lucide-react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
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
import { Skeleton } from "@/components/ui/skeleton";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

// Configuration sections
const SETTING_TABS = [
	{
		key: "wallet",
		name: "Wallet & Payments",
		icon: WalletIcon,
		description: "Configure wallet limits and payment thresholds",
		textColor: "text-emerald-500",
		bgColor: "bg-emerald-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-emerald-500",
				bgColor: "dark:data-[state=active]:bg-emerald-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-emerald-500",
				bgColor: "data-[state=active]:bg-emerald-500/10",
			},
		},
	},
	{
		key: "cancellation",
		name: "Cancellation Fees",
		icon: PercentIcon,
		description: "Set cancellation and no-show fee rates",
		textColor: "text-red-500",
		bgColor: "bg-red-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-red-500",
				bgColor: "dark:data-[state=active]:bg-red-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-red-500",
				bgColor: "data-[state=active]:bg-red-500/10",
			},
		},
	},
	{
		key: "matching",
		name: "Driver Matching",
		icon: RadarIcon,
		description: "Configure driver matching algorithm parameters",
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
		key: "payment",
		name: "Payment Timeouts",
		icon: ClockIcon,
		description: "Set payment and order timeout durations",
		textColor: "text-amber-500",
		bgColor: "bg-amber-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-amber-500",
				bgColor: "dark:data-[state=active]:bg-amber-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-amber-500",
				bgColor: "data-[state=active]:bg-amber-500/10",
			},
		},
	},
	{
		key: "lifecycle",
		name: "Order Lifecycle",
		icon: GaugeIcon,
		description: "Configure order completion and stale timeouts",
		textColor: "text-purple-500",
		bgColor: "bg-purple-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-purple-500",
				bgColor: "dark:data-[state=active]:bg-purple-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-purple-500",
				bgColor: "data-[state=active]:bg-purple-500/10",
			},
		},
	},
	{
		key: "driver",
		name: "Driver Settings",
		icon: MapPinIcon,
		description: "Configure driver location and rebroadcast settings",
		textColor: "text-cyan-500",
		bgColor: "bg-cyan-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-cyan-500",
				bgColor: "dark:data-[state=active]:bg-cyan-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-cyan-500",
				bgColor: "data-[state=active]:bg-cyan-500/10",
			},
		},
	},
	{
		key: "commission",
		name: "Commission",
		icon: TrophyIcon,
		description: "Configure badge commission reductions",
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
	{
		key: "scheduled",
		name: "Scheduled Orders",
		icon: CalendarClockIcon,
		description: "Configure scheduled order constraints",
		textColor: "text-indigo-500",
		bgColor: "bg-indigo-500/10",
		tab: {
			dark: {
				textColor: "dark:data-[state=active]:text-indigo-500",
				bgColor: "dark:data-[state=active]:bg-indigo-500/10",
			},
			light: {
				textColor: "data-[state=active]:text-indigo-500",
				bgColor: "data-[state=active]:bg-indigo-500/10",
			},
		},
	},
] as const;

type SettingTab = (typeof SETTING_TABS)[number];

// Field definitions with metadata
interface FieldDefinition {
	label: string;
	description: string;
	section: SettingTab["key"];
	unit?: string;
	step?: string;
	min?: number;
	max?: number;
	isPercentage?: boolean;
	isArray?: boolean;
}

const FIELD_DEFINITIONS: Record<keyof BusinessConfiguration, FieldDefinition> =
	{
		// Wallet limits
		minTransferAmount: {
			label: "Minimum Transfer Amount",
			description: "Minimum amount allowed for wallet-to-wallet transfers",
			section: "wallet",
			unit: "IDR",
			min: 1000,
		},
		minWithdrawalAmount: {
			label: "Minimum Withdrawal Amount",
			description: "Minimum amount required for bank withdrawals",
			section: "wallet",
			unit: "IDR",
			min: 10000,
		},
		minTopUpAmount: {
			label: "Minimum Top-Up Amount",
			description: "Minimum amount for wallet top-ups",
			section: "wallet",
			unit: "IDR",
			min: 1000,
		},
		quickTopUpAmounts: {
			label: "Quick Top-Up Amounts",
			description:
				"Preset amounts shown in quick top-up buttons (comma-separated)",
			section: "wallet",
			unit: "IDR",
			isArray: true,
		},
		highValueOrderThreshold: {
			label: "High-Value Order Threshold",
			description:
				"Orders above this amount require OTP verification for delivery",
			section: "wallet",
			unit: "IDR",
			min: 50000,
		},

		// Cancellation fees
		userCancellationFeeBeforeAccept: {
			label: "Cancellation Fee (Before Accept)",
			description:
				"Fee rate when user cancels before driver accepts (0 = no fee, 10 = 10%)",
			section: "cancellation",
			unit: "%",
			step: "1",
			min: 0,
			max: 100,
			isPercentage: true,
		},
		userCancellationFeeAfterAccept: {
			label: "Cancellation Fee (After Accept)",
			description:
				"Fee rate when user cancels after driver accepts (0 = no fee, 10 = 10%)",
			section: "cancellation",
			unit: "%",
			step: "1",
			min: 0,
			max: 100,
			isPercentage: true,
		},
		noShowFee: {
			label: "No-Show Fee",
			description:
				"Fee rate when user doesn't show up after driver arrives (50 = 50%)",
			section: "cancellation",
			unit: "%",
			step: "1",
			min: 0,
			max: 100,
			isPercentage: true,
		},
		noShowDriverCompensationRate: {
			label: "No-Show Driver Compensation",
			description:
				"Percentage of no-show fee that goes to the driver (80 = 80%)",
			section: "cancellation",
			unit: "%",
			step: "1",
			min: 0,
			max: 100,
			isPercentage: true,
		},

		// Driver matching
		driverMatchingInitialRadiusKm: {
			label: "Initial Search Radius",
			description: "Starting radius for driver search when an order is placed",
			section: "matching",
			unit: "km",
			step: "0.5",
			min: 1,
			max: 50,
		},
		driverMatchingMaxRadiusKm: {
			label: "Maximum Search Radius",
			description: "Maximum radius the search will expand to (hard limit)",
			section: "matching",
			unit: "km",
			step: "1",
			min: 5,
			max: 50,
		},
		driverMatchingRadiusExpansionRate: {
			label: "Radius Expansion Rate",
			description:
				"How much the radius expands each attempt (20 = 20% increase)",
			section: "matching",
			unit: "%",
			step: "5",
			min: 10,
			max: 100,
			isPercentage: true,
		},
		driverMatchingTimeoutMinutes: {
			label: "Matching Timeout",
			description:
				"Maximum time to search for a driver before cancelling the order",
			section: "matching",
			unit: "minutes",
			min: 5,
			max: 60,
		},
		driverMatchingIntervalSeconds: {
			label: "Matching Interval",
			description: "Time between each matching attempt",
			section: "matching",
			unit: "seconds",
			min: 10,
			max: 120,
		},
		driverMatchingBroadcastLimit: {
			label: "Broadcast Limit",
			description: "Maximum number of drivers to notify about an order at once",
			section: "matching",
			unit: "drivers",
			min: 1,
			max: 50,
		},
		driverMaxCancellationsPerDay: {
			label: "Max Driver Cancellations",
			description:
				"Maximum order cancellations allowed per driver per day before suspension",
			section: "matching",
			unit: "cancellations",
			min: 1,
			max: 10,
		},

		// Payment timeouts
		paymentPendingTimeoutMinutes: {
			label: "Payment Pending Timeout",
			description:
				"Time allowed for payment completion before auto-cancellation",
			section: "payment",
			unit: "minutes",
			min: 5,
			max: 60,
		},

		// Order lifecycle
		orderCompletionTimeoutMinutes: {
			label: "Order Completion Timeout",
			description:
				"Time after completion before order is auto-finalized without rating",
			section: "lifecycle",
			unit: "minutes",
			min: 15,
			max: 1440,
		},
		noShowTimeoutMinutes: {
			label: "No-Show Timeout",
			description:
				"Time after which no-show orders are processed for cleanup and refund",
			section: "lifecycle",
			unit: "minutes",
			min: 5,
			max: 120,
		},
		orderStaleTimestampMinutes: {
			label: "Order Stale Timestamp",
			description:
				"Duration after which in-transit order timestamps are considered stale",
			section: "lifecycle",
			unit: "minutes",
			min: 1,
			max: 30,
		},

		// Driver location and rebroadcast
		driverLocationStaleThresholdMinutes: {
			label: "Driver Location Stale Threshold",
			description:
				"Time after which driver location is considered stale (auto-offline)",
			section: "driver",
			unit: "minutes",
			min: 5,
			max: 60,
		},
		driverRebroadcastIntervalMinutes: {
			label: "Rebroadcast Interval",
			description: "Time between rebroadcast attempts for unmatched orders",
			section: "driver",
			unit: "minutes",
			min: 1,
			max: 10,
		},
		driverRebroadcastRadiusMultiplier: {
			label: "Rebroadcast Radius Multiplier",
			description:
				"Multiplier for radius expansion during rebroadcast (150 = 1.5x)",
			section: "driver",
			unit: "%",
			step: "10",
			min: 100,
			max: 300,
			isPercentage: true,
		},

		// Commission
		maxBadgeCommissionReduction: {
			label: "Max Badge Commission Reduction",
			description: "Maximum commission reduction from driver badges (50 = 50%)",
			section: "commission",
			unit: "%",
			step: "5",
			min: 0,
			max: 100,
			isPercentage: true,
		},

		// Scheduled orders
		scheduledOrderMinAdvanceMinutes: {
			label: "Minimum Advance Time",
			description:
				"Minimum minutes in advance required for scheduling an order",
			section: "scheduled",
			unit: "minutes",
			min: 15,
			max: 120,
		},
		scheduledOrderMaxAdvanceDays: {
			label: "Maximum Advance Days",
			description: "Maximum days in advance allowed for scheduling an order",
			section: "scheduled",
			unit: "days",
			min: 1,
			max: 30,
		},
		scheduledOrderMatchingLeadTimeMinutes: {
			label: "Matching Lead Time",
			description: "Minutes before scheduled time when driver matching begins",
			section: "scheduled",
			unit: "minutes",
			min: 5,
			max: 60,
		},
		scheduledOrderMinRescheduleHours: {
			label: "Minimum Reschedule Hours",
			description:
				"Minimum hours before scheduled time required to allow rescheduling",
			section: "scheduled",
			unit: "hours",
			min: 1,
			max: 24,
		},
		onTimeDeliveryThresholdMinutes: {
			label: "On-Time Delivery Threshold",
			description:
				"Threshold in minutes for considering a delivery as on-time (metrics)",
			section: "lifecycle",
			unit: "minutes",
			min: 5,
			max: 60,
		},
	};

const DEFAULT_VALUES: BusinessConfiguration = {
	minTransferAmount: 10000,
	minWithdrawalAmount: 50000,
	minTopUpAmount: 10000,
	quickTopUpAmounts: [10000, 25000, 50000, 100000],
	userCancellationFeeBeforeAccept: 0,
	userCancellationFeeAfterAccept: 0.1,
	noShowFee: 0.5,
	noShowDriverCompensationRate: 0.8,
	highValueOrderThreshold: 500000,
	driverMatchingTimeoutMinutes: 15,
	driverMatchingInitialRadiusKm: 5,
	driverMatchingMaxRadiusKm: 20,
	driverMatchingRadiusExpansionRate: 0.2,
	driverMatchingIntervalSeconds: 30,
	driverMatchingBroadcastLimit: 10,
	driverMaxCancellationsPerDay: 3,
	paymentPendingTimeoutMinutes: 15,
	// Order lifecycle
	orderCompletionTimeoutMinutes: 60,
	noShowTimeoutMinutes: 30,
	orderStaleTimestampMinutes: 5,
	// Driver location and rebroadcast
	driverLocationStaleThresholdMinutes: 15,
	driverRebroadcastIntervalMinutes: 2,
	driverRebroadcastRadiusMultiplier: 1.5,
	// Commission
	maxBadgeCommissionReduction: 0.5,
	// Scheduled orders
	scheduledOrderMinAdvanceMinutes: 30,
	scheduledOrderMaxAdvanceDays: 7,
	scheduledOrderMatchingLeadTimeMinutes: 15,
	scheduledOrderMinRescheduleHours: 1,
	// On-time delivery
	onTimeDeliveryThresholdMinutes: 10,
};

export const Route = createFileRoute("/dash/admin/settings")({
	head: () => ({
		meta: [{ title: `Business Settings - ${SUB_ROUTE_TITLES.ADMIN.OVERVIEW}` }],
	}),
	beforeLoad: async () => {
		const ok = await hasAccess(["ADMIN"]);
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
				<h2 className="font-medium text-xl">Business Settings</h2>
				<p className="text-muted-foreground">
					Configure platform-wide business rules and parameters
				</p>
			</div>
			<BusinessSettingsForm />
		</>
	);
}

function BusinessSettingsForm() {
	const businessConfig = useQuery(
		orpcQuery.configuration.get.queryOptions({
			input: { params: { key: "business-configuration" } },
		}),
	);

	const configValue = businessConfig.data?.body.data.value as
		| BusinessConfiguration
		| undefined;

	const form = useForm({
		// biome-ignore lint/suspicious/noExplicitAny: Schema type handling for zod resolver
		resolver: zodResolver(BusinessConfigurationSchema as any),
		defaultValues: DEFAULT_VALUES,
		values: configValue ?? DEFAULT_VALUES,
	});

	const mutation = useMutation(
		orpcQuery.configuration.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success("Business settings updated successfully");
				form.clearErrors();
			},
			onError: (error) => {
				toast.error("Failed to update settings", {
					description: error.message || "An unexpected error occurred",
				});
			},
		}),
	);

	// biome-ignore lint/suspicious/noExplicitAny: Form values type handling
	const onSubmit = (values: any) => {
		// Convert quickTopUpAmounts string back to array if needed
		const processedValues = {
			...values,
			quickTopUpAmounts: Array.isArray(values.quickTopUpAmounts)
				? values.quickTopUpAmounts
				: String(values.quickTopUpAmounts)
						.split(",")
						.map((v: string) => Number(v.trim()))
						.filter((v: number) => !Number.isNaN(v) && v > 0),
		};
		return mutation.mutateAsync({
			params: { key: "business-configuration" },
			body: { value: processedValues },
		});
	};

	if (businessConfig.isLoading) {
		return (
			<div className="space-y-4">
				<Skeleton className="h-12 w-full" />
				<Skeleton className="h-[400px] w-full" />
			</div>
		);
	}

	if (businessConfig.isError) {
		return (
			<Card className="border-destructive">
				<CardHeader>
					<CardTitle className="text-destructive">
						Error Loading Settings
					</CardTitle>
					<CardDescription>
						{businessConfig.error?.message ||
							"Failed to load business configuration"}
					</CardDescription>
				</CardHeader>
				<CardContent>
					<Button onClick={() => businessConfig.refetch()}>Try Again</Button>
				</CardContent>
			</Card>
		);
	}

	return (
		<Form {...form}>
			<form onSubmit={form.handleSubmit(onSubmit)}>
				<Tabs defaultValue={SETTING_TABS[0].key}>
					<div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
						<div className="w-min rounded-xl border bg-card p-1">
							<TabsList className="flex flex-wrap bg-transparent">
								{SETTING_TABS.map((tab) => (
									<TabsTrigger
										key={tab.key}
										value={tab.key}
										className={cn(
											"gap-2 p-3",
											tab.tab.light.bgColor,
											tab.tab.light.textColor,
											tab.tab.dark.bgColor,
											tab.tab.dark.textColor,
										)}
									>
										<tab.icon className="h-4 w-4" />
										<span className="hidden sm:inline">{tab.name}</span>
									</TabsTrigger>
								))}
							</TabsList>
						</div>
						<Button type="submit" disabled={mutation.isPending}>
							{mutation.isPending ? (
								<Submitting />
							) : (
								<>
									<Save className="mr-2 h-4 w-4" />
									{m.save_changes()}
								</>
							)}
						</Button>
					</div>

					{SETTING_TABS.map((tab) => (
						<TabsContent key={tab.key} value={tab.key} className="mt-4">
							<Card>
								<CardHeader>
									<div className="flex items-center gap-3">
										<div className={cn("rounded-lg p-2", tab.bgColor)}>
											<tab.icon className={cn("h-5 w-5", tab.textColor)} />
										</div>
										<div>
											<CardTitle>{tab.name}</CardTitle>
											<CardDescription>{tab.description}</CardDescription>
										</div>
									</div>
								</CardHeader>
								<CardContent>
									<div className="grid grid-cols-1 gap-6 md:grid-cols-2">
										{(
											Object.entries(FIELD_DEFINITIONS) as [
												keyof BusinessConfiguration,
												FieldDefinition,
											][]
										)
											.filter(([_, def]) => def.section === tab.key)
											.map(([fieldName, def]) => (
												<FormField
													key={fieldName}
													control={form.control}
													name={fieldName}
													render={({ field }) => (
														<FormItem>
															<FormLabel className="flex items-center gap-2">
																{def.label}
																{def.unit && (
																	<span className="text-muted-foreground text-xs">
																		({def.unit})
																	</span>
																)}
															</FormLabel>
															<FormControl>
																{def.isArray ? (
																	<Input
																		type="text"
																		disabled={mutation.isPending}
																		placeholder="10000, 25000, 50000, 100000"
																		value={
																			Array.isArray(field.value)
																				? (field.value as number[]).join(", ")
																				: String(field.value ?? "")
																		}
																		onChange={(e) => {
																			const values = e.target.value
																				.split(",")
																				.map((v) => Number(v.trim()))
																				.filter((v) => !Number.isNaN(v));
																			field.onChange(
																				values.length > 0
																					? values
																					: e.target.value,
																			);
																		}}
																		onBlur={field.onBlur}
																		name={field.name}
																	/>
																) : def.isPercentage ? (
																	<div className="relative">
																		<Input
																			type="number"
																			step={def.step ?? "1"}
																			min={0}
																			max={100}
																			disabled={mutation.isPending}
																			value={
																				field.value !== undefined
																					? Number(field.value) * 100
																					: ""
																			}
																			onChange={(e) =>
																				field.onChange(
																					Number(e.target.value) / 100,
																				)
																			}
																			onBlur={field.onBlur}
																			name={field.name}
																			className="pr-8"
																		/>
																		<span className="-translate-y-1/2 pointer-events-none absolute top-1/2 right-3 text-muted-foreground">
																			%
																		</span>
																	</div>
																) : (
																	<Input
																		type="number"
																		step={def.step ?? "1"}
																		min={def.min}
																		max={def.max}
																		disabled={mutation.isPending}
																		value={Number(field.value) || ""}
																		onChange={(e) =>
																			field.onChange(Number(e.target.value))
																		}
																		onBlur={field.onBlur}
																		name={field.name}
																	/>
																)}
															</FormControl>
															<FormDescription className="text-xs">
																{def.description}
															</FormDescription>
															<FormMessage />
														</FormItem>
													)}
												/>
											))}
									</div>

									{/* Section-specific previews */}
									{tab.key === "matching" && <MatchingPreview form={form} />}
									{tab.key === "cancellation" && (
										<CancellationPreview form={form} />
									)}
								</CardContent>
							</Card>
						</TabsContent>
					))}
				</Tabs>
			</form>
		</Form>
	);
}

// Preview component for matching settings
// biome-ignore lint/suspicious/noExplicitAny: Form type handling
function MatchingPreview({ form }: { form: any }) {
	const values = form.watch();
	const initialRadius = Number(values.driverMatchingInitialRadiusKm) || 5;
	const maxRadius = Number(values.driverMatchingMaxRadiusKm) || 20;
	const expansionRate = Number(values.driverMatchingRadiusExpansionRate) || 0.2;
	const interval = Number(values.driverMatchingIntervalSeconds) || 30;
	const timeout = Number(values.driverMatchingTimeoutMinutes) || 15;

	// Calculate expansion steps
	const expansionSteps: { attempt: number; radius: number; time: number }[] =
		[];
	let currentRadius = initialRadius;
	let attempt = 0;
	let totalTime = 0;

	while (currentRadius < maxRadius && totalTime < timeout * 60) {
		attempt++;
		expansionSteps.push({
			attempt,
			radius: Math.min(currentRadius, maxRadius),
			time: totalTime,
		});
		currentRadius = currentRadius * (1 + expansionRate);
		totalTime += interval;
	}

	// Add final step at max radius
	if (currentRadius >= maxRadius && totalTime < timeout * 60) {
		expansionSteps.push({
			attempt: attempt + 1,
			radius: maxRadius,
			time: totalTime,
		});
	}

	return (
		<div className="mt-6 rounded-lg bg-muted/50 p-4">
			<h4 className="mb-3 font-medium text-sm">Matching Algorithm Preview</h4>
			<div className="space-y-2 text-sm">
				<div className="flex items-center justify-between border-b pb-2">
					<span className="text-muted-foreground">
						Total matching duration:
					</span>
					<span className="font-medium">{timeout} minutes</span>
				</div>
				<div className="flex items-center justify-between border-b pb-2">
					<span className="text-muted-foreground">
						Expansion steps to max radius:
					</span>
					<span className="font-medium">{expansionSteps.length} attempts</span>
				</div>
				<div className="mt-3">
					<p className="mb-2 text-muted-foreground text-xs">
						Radius expansion timeline:
					</p>
					<div className="flex flex-wrap gap-2">
						{expansionSteps.slice(0, 6).map((step) => (
							<div
								key={step.attempt}
								className="rounded bg-blue-500/10 px-2 py-1 text-blue-600 text-xs dark:text-blue-400"
							>
								{step.radius.toFixed(1)}km @ {Math.floor(step.time / 60)}m
								{step.time % 60}s
							</div>
						))}
						{expansionSteps.length > 6 && (
							<div className="rounded bg-muted px-2 py-1 text-muted-foreground text-xs">
								+{expansionSteps.length - 6} more
							</div>
						)}
					</div>
				</div>
			</div>
		</div>
	);
}

// Preview component for cancellation fees
// biome-ignore lint/suspicious/noExplicitAny: Form type handling
function CancellationPreview({ form }: { form: any }) {
	const values = form.watch();
	const beforeAccept = Number(values.userCancellationFeeBeforeAccept) || 0;
	const afterAccept = Number(values.userCancellationFeeAfterAccept) || 0.1;
	const noShow = Number(values.noShowFee) || 0.5;
	const driverComp = Number(values.noShowDriverCompensationRate) || 0.8;

	const exampleOrderAmount = 50000;

	return (
		<div className="mt-6 rounded-lg bg-muted/50 p-4">
			<h4 className="mb-3 font-medium text-sm">
				Fee Calculation Example (Rp {exampleOrderAmount.toLocaleString("id-ID")}{" "}
				order)
			</h4>
			<div className="grid grid-cols-1 gap-4 text-sm md:grid-cols-3">
				<div className="rounded-lg border bg-background p-3">
					<p className="mb-1 text-muted-foreground text-xs">
						Cancel before driver accepts
					</p>
					<p className="font-medium">
						Fee: Rp{" "}
						{(exampleOrderAmount * beforeAccept).toLocaleString("id-ID")}
					</p>
					<p className="text-green-600 text-xs">
						Refund: Rp{" "}
						{(exampleOrderAmount * (1 - beforeAccept)).toLocaleString("id-ID")}
					</p>
				</div>
				<div className="rounded-lg border bg-background p-3">
					<p className="mb-1 text-muted-foreground text-xs">
						Cancel after driver accepts
					</p>
					<p className="font-medium">
						Fee: Rp {(exampleOrderAmount * afterAccept).toLocaleString("id-ID")}
					</p>
					<p className="text-green-600 text-xs">
						Refund: Rp{" "}
						{(exampleOrderAmount * (1 - afterAccept)).toLocaleString("id-ID")}
					</p>
				</div>
				<div className="rounded-lg border bg-background p-3">
					<p className="mb-1 text-muted-foreground text-xs">
						No-show (driver arrives, user absent)
					</p>
					<p className="font-medium">
						Fee: Rp {(exampleOrderAmount * noShow).toLocaleString("id-ID")}
					</p>
					<p className="text-blue-600 text-xs">
						Driver gets: Rp{" "}
						{(exampleOrderAmount * noShow * driverComp).toLocaleString("id-ID")}
					</p>
				</div>
			</div>
		</div>
	);
}
